//
//  ViewController.swift
//  KeyboardOfMiddleEarth
//
//  Created by ooo on 5/17/15.
//  Copyright (c) 2015 Rohan Revival. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tweet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tweet(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Open external link?", message: "Webpage in Safari, profile in Twitter app or compose a new eMail.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Open http://www.codedifferent.com",
            
            style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: "http://www.codedifferent.com")!)
                return
        }))
        
        alert.addAction(UIAlertAction(title: "Open @codedifferent in Twitter app",
            style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?screen_name=codedifferent")!)
                return
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = sender.bounds
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func testButtonPressed(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Open external link?", message: "Webpage in Safari, profile in Twitter app or compose a new eMail.", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Open http://www.codedifferent.com",

            style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: "http://www.codedifferent.com")!)
                return
        }))
        
        alert.addAction(UIAlertAction(title: "Open @codedifferent in Twitter app",
            style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?screen_name=codedifferent")!)
                return
        }))
        
        alert.addAction(UIAlertAction(title: "Create eMail",
            style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                UIApplication.sharedApplication().openURL(NSURL(string: "mailto:your@emailadress.com")!)
                return
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel, handler: nil))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = sender.bounds
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }



}

