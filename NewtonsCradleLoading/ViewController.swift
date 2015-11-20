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
    
    @IBOutlet var loadingView: LoadingView!
    @IBOutlet var loadButton: UIButton!
    var didAnimation: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //loadingView.ballColor = UIColor.redColor()
        loadingView.applyBlur()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func roadContents(){
        if didAnimation == false{
            loadingView.setupBall()
            didAnimation = true
        }else{
            loadingView.stop()
            didAnimation = false
        }
        print(didAnimation)
    }

}

