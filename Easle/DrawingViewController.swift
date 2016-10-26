//
//  DrawingViewController.swift
//  Easle
//
//  Created by Ronald Hernandez on 10/24/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    @IBOutlet weak var buttonStack: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(appBecameActive), name: UIApplicationDidBecomeActiveNotification, object:  nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
        buttonStack.hidden = true
    }
    
    func appBecameActive() {
        buttonStack.hidden = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        buttonStack.hidden = true
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            self.lastPoint = point
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let point = touch.locationInView(self.imageView)
            
            
            UIGraphicsBeginImageContext(self.imageView.frame.size)
            
            let context = UIGraphicsGetCurrentContext()
            
            //we're drawing inside the imageView
            
            self.imageView.image?.drawInRect(CGRect(x: 0, y: 0, width: self.imageView.frame.size.width, height: self.imageView.frame.size.height))
            
            //start here
            CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y)
            
            //add line
            CGContextAddLineToPoint(context, point.x, point.y)
            
            //Make linke thicker
            CGContextSetLineWidth(context, 10)
            
            CGContextSetLineCap(context, .Round)
            
            CGContextSetRGBStrokeColor(context, red, green, blue, 1)
           
            CGContextStrokePath(context)
            
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            
            
            UIGraphicsEndImageContext()
            
            self.lastPoint = point
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        buttonStack.hidden = false
    }
    
    func eraseDrawing() {
        
        self.imageView.image = nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "drawingToSettingsSegue" {
            let settingsVC = segue.destinationViewController as! SettingsViewController
            
            settingsVC.drawingVC = self
            
        }
    }
    
    @IBAction func blueTapped(sender: AnyObject) {
        
        self.red = 56 / 255
        self.green = 109 / 255
        self.blue = 229 / 255
        
    }
    
    @IBAction func greenTapped(sender: AnyObject) {
        self.red = 37 / 255
        self.green = 235 / 255
        self.blue = 114 / 255
        
    }
    
    @IBAction func redTapped(sender: AnyObject) {
        self.red = 229 / 255
        self.green = 56 / 255
        self.blue = 56 / 255
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
        self.red =  249 / 255
        self.green = 215 / 255
        self.blue = 23 / 255
    }
    
    @IBAction func randomTapped(sender: AnyObject) {
       
        self.red =  CGFloat(arc4random_uniform(255)) / 255
        self.green = CGFloat(arc4random_uniform(255))  / 255
        self.blue = CGFloat(arc4random_uniform(255))  / 255
    }
    
}

