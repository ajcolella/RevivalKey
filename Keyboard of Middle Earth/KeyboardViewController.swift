//
//  KeyboardViewController.swift
//  KeyboardOfMiddleEarth
//
//  Created by ooo on 6/1/15.
//  Copyright (c) 2015 Rohan Revival. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = UITableView()
    
    let controlBarHeight: CGFloat = 38
    let buttonSize: CGFloat = 34
    var returnButtonWidth: CGFloat!
    var spaceButtonWidth: CGFloat!
    
    var nextKeyboardButton: UIButton!
    var spaceButton: UIButton!
    var returnButton: UIButton!
    var deleteButton: UIButton!
    var controlBar: UIButton!
    
    var quotes = [Quote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setQuotes()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - controlBarHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = true
        tableView.allowsSelectionDuringEditing = true
        tableView.userInteractionEnabled = true
        
        view.addSubview(tableView)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        spaceButtonWidth = (self.view.bounds.width - buttonSize*2 - 10)*0.6
        returnButtonWidth = (self.view.bounds.width - buttonSize*2 - 10)*0.4

        createControlBar()
        createNextKeyboardButton()
        createSpaceButton()
        createReturnButton()
        createDeleteButton()
        
        addControlBarConstraints()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        tableView.frame = CGRectMake(0, 0, size.width, size.height - controlBarHeight)
        tableView.reloadData()
    }
    
    func setQuotes() {
        DataManager.loadQuotesFromFile { (data) -> Void in
            if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                if let quoteArray = json["items"] as? [NSDictionary] {
                    for quoteDict in quoteArray {
                        self.quotes.append(Quote(json: quoteDict))
                    }
                }
            }
        }
    }
    
    func createControlBar() {
        controlBar = UIButton.buttonWithType(.System) as! UIButton//UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: controlBarHeight))
        controlBar.backgroundColor = UIColor(red: 209.0/255, green: 213.0/255, blue: 219.0/255, alpha: 1.0)
        controlBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(controlBar)
        
        var controlBarWidthConstraint = NSLayoutConstraint(item: controlBar, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: 0.0)
        var controlBarHeightConstraint = NSLayoutConstraint(item: controlBar, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: controlBarHeight)
        var controlBarBottomConstraint = NSLayoutConstraint(item: controlBar, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraints([controlBarWidthConstraint, controlBarHeightConstraint, controlBarBottomConstraint])
    }
    
    func createNextKeyboardButton () {
        nextKeyboardButton = UIButton.buttonWithType(.System) as! UIButton
        
        nextKeyboardButton.layer.cornerRadius = 4.0
        nextKeyboardButton.layer.borderColor = UIColor.grayColor().CGColor
        nextKeyboardButton.backgroundColor = UIColor.lightGrayColor()
        nextKeyboardButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        nextKeyboardButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        nextKeyboardButton.setTitle("\u{0001F310}", forState: .Normal)
        nextKeyboardButton.titleLabel?.font = UIFont.systemFontOfSize(24)

        nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        view.addSubview(nextKeyboardButton)
        
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -2.0)
        var nextKeyboardbuttonSizeConstraint = NSLayoutConstraint(item: nextKeyboardButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonSize)
        view.addConstraints([nextKeyboardButtonBottomConstraint, nextKeyboardbuttonSizeConstraint])
    }
    
    func createSpaceButton() {
        spaceButton = UIButton.buttonWithType(.Custom) as! UIButton
        spaceButton.frame = CGRectMake(0, 0, 244,  buttonSize)
        spaceButton.layer.cornerRadius = 4.0
        spaceButton.layer.borderColor = UIColor.grayColor().CGColor
        spaceButton.backgroundColor = UIColor.lightGrayColor()
        spaceButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        spaceButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        spaceButton.setTitle(NSLocalizedString("Space", comment: "Space bar"), forState: .Normal)
        
        spaceButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        spaceButton.addTarget(self, action: "insertSpace", forControlEvents: .TouchUpInside)
        view.addSubview(spaceButton)
        
        var spaceButtonBottomConstraint = NSLayoutConstraint(item: spaceButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -2.0)
        var spacebuttonSizeConstraint = NSLayoutConstraint(item: spaceButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonSize)
        view.addConstraints([spaceButtonBottomConstraint, spacebuttonSizeConstraint])
    }
    
    func insertSpace() {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        proxy.insertText(" ")
    }

    func createReturnButton() {
        returnButton = UIButton.buttonWithType(.Custom) as! UIButton
        returnButton.frame = CGRectMake(0, 0, 244,  buttonSize)
        returnButton.layer.cornerRadius = 4.0
        returnButton.layer.borderColor = UIColor.grayColor().CGColor
        returnButton.backgroundColor = UIColor.lightGrayColor()
        returnButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        returnButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        returnButton.setTitle(NSLocalizedString("Return", comment: "Return"), forState: .Normal)
        
        returnButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        returnButton.addTarget(self, action: "insertReturn", forControlEvents: .TouchUpInside)
        view.addSubview(returnButton)
        
        var returnButtonBottomConstraint = NSLayoutConstraint(item: returnButton, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: -2.0)
        var returnbuttonSizeConstraint = NSLayoutConstraint(item: returnButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonSize)
        view.addConstraints([returnButtonBottomConstraint, returnbuttonSizeConstraint])
    }
    
    func insertReturn() {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        proxy.insertText("\n")
    }

    func createDeleteButton() {
        deleteButton = UIButton.buttonWithType(.Custom) as! UIButton
        deleteButton.layer.cornerRadius = 4.0
        deleteButton.layer.frame = CGRectMake(0, 0, buttonSize + 2.0, buttonSize + 2.0)
        deleteButton.layer.borderColor = UIColor.grayColor().CGColor
        deleteButton.backgroundColor = UIColor.lightGrayColor()
        deleteButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        deleteButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        deleteButton.setTitle("\u{0000232B}", forState: .Normal)

        deleteButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        deleteButton.addTarget(self, action: "deleteButtonClicked", forControlEvents: .TouchUpInside)
        view.addSubview(deleteButton)
        
        var deleteButtonBottomConstraint = NSLayoutConstraint(item: deleteButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -2.0)
        var deletebuttonSizeConstraint = NSLayoutConstraint(item: deleteButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: buttonSize)
        self.view.addConstraints([deleteButtonBottomConstraint, deletebuttonSizeConstraint])
    }
    
    func deleteButtonClicked() {
        var proxy = textDocumentProxy as! UITextDocumentProxy
        proxy.deleteBackward()
    }
    
    func addControlBarConstraints() {
        let views = Dictionary(dictionaryLiteral: ("next", nextKeyboardButton),("space", spaceButton), ("return", returnButton), ("delete", deleteButton))
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-2-[next(==34)]-2-[space(>=162)]-2-[return(>=80)]-2-[delete(==34)]-2-|", options: nil, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraints)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.userInteractionEnabled = true
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel?.text = quotes[indexPath.row].text
        cell.detailTextLabel?.text = String(quotes[indexPath.row].movie! + " - " + quotes[indexPath.row].character!)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let quote = quotes[indexPath.row]
        (textDocumentProxy as! UIKeyInput).insertText(quote.text!)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let quote = quotes[indexPath.row]
        var height: CGFloat = 44
        let frame: CGRect = CGRectMake(0, 0, self.view.bounds.width, CGFloat.max)
        let label:UILabel = UILabel(frame: frame)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = UIFont(name: "Helvetica", size: 20.0)
        label.text = quote.text
        label.sizeToFit()
        
        
//        let size: CGSize = label.sizeThatFits(CGSizeMake(label.frame.size.width, CGFloat.max));
//        let insets: UIEdgeInsets = label.;
//        return height.constant = size.height + insets.top + insets.bottom;
//        label.sizeToFit()
////        label.sizeThatFits(CGSize(width: self.view.bounds.width, height: frame.height*1.8))
//        if label.frame.height > height {
//            height = label.frame.height
//        }
        return label.frame.height + 20.0
    }
    
}
