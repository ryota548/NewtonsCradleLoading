//
//  ViewController.swift
//  NewtonsCradleLoading
//
//  Created by ryota-ko on 2015/11/20.
//  Copyright © 2015年 ryota-ko. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadingView.setupBall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

