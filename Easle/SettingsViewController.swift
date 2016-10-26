//
//  SettingsViewController.swift
//  Easle
//
//  Created by Ronald Hernandez on 10/24/16.
//  Copyright © 2016 Ronaldoh1. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
 
    weak var drawingVC: DrawingViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func erase(sender: UIBarButtonItem) {
        self.drawingVC?.eraseDrawing()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
