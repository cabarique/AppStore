//
//  ViewController.swift
//  AppStore
//
//  Created by luis cabarique on 1/26/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import UIKit
import Material
import FontAwesome_swift

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let limit = 20
    
    @IBOutlet weak var appsTAble: UITableView!
    
    var api: AppStoreClient!
    
    var apps: [AppModel] = []{
        didSet{
            appsTAble.reloadData()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "StoreView", bundle: NSBundle.mainBundle())
        api = AppStoreClientImp.sharedInstance
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getFreeApps(withLimit: limit).subscribeNext { (response) -> Void in
            let appsVO = response as! AppsVO
            self.apps = appsVO.apps
        }
        
        appsTAble.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        let navigationBarView: NavigationBarView = NavigationBarView()
        navigationBarView.backgroundColor = MaterialColor.blue.darken3
        
        /*
        To lighten the status bar - add the
        "View controller-based status bar appearance = NO"
        to your info.plist file and set the following property.
        */
        navigationBarView.statusBarStyle = .LightContent
        
        // Title label.
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "Apple Store"
        titleLabel.textAlignment = .Left
        titleLabel.textColor = MaterialColor.white
        titleLabel.font = RobotoFont.regularWithSize(20)
        navigationBarView.titleLabel = titleLabel
        navigationBarView.titleLabelInset.left = 64
        
        // Detail label.
        let detailLabel: UILabel = UILabel()
        detailLabel.text = "All Categories"
        detailLabel.textAlignment = .Left
        detailLabel.textColor = MaterialColor.white
        detailLabel.font = RobotoFont.regularWithSize(12)
        navigationBarView.detailLabel = detailLabel
        navigationBarView.detailLabelInset.left = 64
        
        // Menu button.
        //let img1: UIImage? = UIImage(named: "ic_menu_white")
        let btn1: FlatButton = FlatButton()
        btn1.pulseColor = MaterialColor.white
        btn1.pulseFill = true
        btn1.pulseScale = false
        btn1.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        btn1.setTitle(String.fontAwesomeIconWithName(.Bars), forState: .Normal)
        btn1.addTarget(self, action: "toggleCategories", forControlEvents: .TouchUpInside)

        // Add buttons to left side.
        navigationBarView.leftButtons = [btn1]
        
        
        // To support orientation changes, use MaterialLayout.
        view.addSubview(navigationBarView)
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        MaterialLayout.alignFromTop(view, child: navigationBarView)
        MaterialLayout.alignToParentHorizontally(view, child: navigationBarView)
        MaterialLayout.height(view, child: navigationBarView, height: 70)
        MaterialLayout.alignToParent(view, child: appsTAble, top: 70)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Tableview Magement
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let app = apps[indexPath.row]
        let cell =  appsTAble.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = app.name
        if app.encondedImages.count > 0 {
            cell.imageView?.image = UIImage(data: app.encondedImages[0])
        }else{
            cell.imageView?.image = nil
            if app.images.count > 0{
                let url = app.images[0]
                getDataFromUrl(url) { data in
                    dispatch_async(dispatch_get_main_queue()) {
                        app.encondedImages.insert(data!, atIndex: 0)
                        if let cellToUpdate = self.appsTAble?.cellForRowAtIndexPath(indexPath){
                            cellToUpdate.imageView?.image = UIImage(data: data!)
                            cellToUpdate.setNeedsDisplay()
                        }
                        
                    }
                }
            }
        }
        
        
        return cell
    }
    
    func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
            completion(data: NSData(data: data!))
            }.resume()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    

    func toggleCategories(){
        sideNavigationViewController?.toggle()
    }

}

