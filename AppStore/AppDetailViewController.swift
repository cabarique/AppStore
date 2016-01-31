//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by luis cabarique on 1/30/16.
//  Copyright © 2016 cabarique inc. All rights reserved.
//

import UIKit
import Material

class AppDetailViewController: UIViewController {
    
    var blurEffectView: UIVisualEffectView?
    var app: AppModel?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var getButton: FlatButton!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "DetailView", bundle: NSBundle.mainBundle())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.contentView.layer.cornerRadius = 5
        self.view.layer.shadowOpacity = 0.8
        self.view.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        appImage.layer.cornerRadius = 10
        appImage.backgroundColor = UIColor.clearColor()
        getButton.layer.borderColor = MaterialColor.blue.darken2.CGColor
        getButton.layer.borderWidth = 1

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if app!.encondedImages.count > 0{
            appImage.image = UIImage(data: app!.encondedImages[0])
        }
        
        appImage.layer.cornerRadius = 10
        appImage.setNeedsDisplay()
        
        name.text = app!.name
        artist.text = app!.artist
        descriptionTextView.text = app!.summary
        descriptionTextView.scrollsToTop = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showInView(aView: UIView!, withApp app: AppModel, animated: Bool)
    {
        self.app = app
        
        let blurEffect = UIBlurEffect(style: .Dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView!.frame = aView.bounds
        blurEffectView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.view.frame = aView.frame
        self.view.insertSubview(blurEffectView!, atIndex: 0)
        
        aView.addSubview(self.view)
        
        blurEffectView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "removeAnimate"))
        if animated
        {
            self.showAnimate()
        }
    }
    
    @IBAction func getApp(sender: AnyObject) {
        let url = NSURL(string: app!.link)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    func showAnimate()
    {
        //self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        self.blurEffectView?.alpha = 0.0
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.blurEffectView?.alpha = 1.0
            //self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
        
    }
    
    func removeAnimate()
    {

        view.removeFromSuperview()
        UIView.animateWithDuration(0.25, animations: {
            //self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0
            self.blurEffectView?.alpha = 0.0
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.blurEffectView?.removeFromSuperview()
                    self.view.removeFromSuperview()
                }
        });
    }

}
