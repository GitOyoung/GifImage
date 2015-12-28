//
//  ViewController.swift
//  GifImageDemoSwift
//
//  Created by oyoung on 15/12/28.
//  Copyright © 2015年 oyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonView: ImageButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gif = UIImage.gifNamed("joy")
        let gifView = UIImageView(image: gif)
        gifView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        gifView.center = view.center
        gifView.hidden = true
        
        view.addSubview(gifView)
        
        let button = ImageButton(name: "joy", withExtension: "gif")
        button.frame = CGRect(x: 0, y: 0, width: 100 , height: 100)
        button.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.center = view.center
        buttonView = button
        view.addSubview(button)
        
        
    }
    
    @objc(buttonClick:)
    func buttonTouchUpInside(sender s: ImageButton)
    {
        
        if s.isAnimating()
        {
            s.stopAnimating()
        }
        else
        {
            s.startAnimating()
        }
//        UIView.animateWithDuration(0.2, animations: { () -> Void in
//            s.transform = CGAffineTransformMakeScale(1.5, 1.0)
//            }) { (d: Bool) -> Void in
//                UIView.animateWithDuration(0.2, animations: { () -> Void in
//                    s.transform = CGAffineTransformMakeScale(1.0, 1.5)
//                    }, completion: { (d: Bool) -> Void in
//                        UIView.animateWithDuration(0.2, animations: { () -> Void in
//                            s.transform = CGAffineTransformIdentity
//                            })
//                })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

