//
//  ViewController.swift
//  GifImageDemoSwift
//
//  Created by oyoung on 15/12/28.
//  Copyright © 2015年 oyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = UIImage.gifNamed("joy")
        let gifView = UIImageView(image: gif)
        gifView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        gifView.center = view.center
        
        view.addSubview(gifView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

