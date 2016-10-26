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
            
            CGContextSetRGBStrokeColor(context, 0.3, 0.6, 0.2, 1)
           
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
}

