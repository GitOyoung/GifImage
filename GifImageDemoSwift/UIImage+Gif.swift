//
//  UIImage+Gif.swift
//  GifImageDemoSwift
//
//  Created by oyoung on 15/12/28.
//  Copyright © 2015年 oyoung. All rights reserved.
//

import UIKit
import ImageIO

func gcdForPair(a: Int?, b: Int?) -> Int
{
    if a == nil || b == nil {
        if a != nil {
            return a!
        }
        else if b != nil {
            return b!
        }
        else {
            return 1
        }
    }
    
    var big = a!
    var small = b!
    
    if big < small {
        let tmp = big
        big = small
        small = tmp
    }
    
    var left: Int
    repeat {
        left = big % small
        big = small
        small = left
    } while small != 0
    
    return big
}

func gcdOfArray(array: [Int]) -> Int
{
    guard !array.isEmpty else {
        return 1
    }
    var gcd = array[0]
    for v in array {
        gcd = gcdForPair(v, b: gcd)
    }
    return gcd
}

extension UIImage {
    
    
    public class func gifWithData(data d: NSData) -> UIImage?
    {
        guard let s = CGImageSourceCreateWithData(d, nil) else {
            return nil
        }
        return UIImage.animatedImageWithSource(source: s)
    }
    
    public class func gifNamed(name: String) ->UIImage?
    {
        guard let bundleURL = NSBundle.mainBundle().URLForResource(name, withExtension: "gif") else {
            return nil
        }
        guard let imageData = NSData(contentsOfURL: bundleURL) else {
            return nil
        }
        return gifWithData(data: imageData)
    }
    
    public class func animatedImageWithSource(source s: CGImageSource) ->UIImage?
    {
        let count = CGImageSourceGetCount(s)
        var images = [CGImageRef]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(s, i, nil) {
                images.append(image)
            }
            
            let delay = delayForImageAtIndex(i, source: s)
            delays.append(Int(delay * 1000.0)) //帧间隔，单位ms
        }
        
        let duration: Int = delays.reduce(0) { $0 + $1 } //求和
        
        let gcd = gcdOfArray(delays)
        var frames = [UIImage]()
        
        for i in 0..<count {
            let frame = UIImage(CGImage: images[i])
            let frameCount: Int = Int(duration / gcd)
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImageWithImages(frames, duration: Double(duration) / 1000.0)
        return animation
        
    }
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
  
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionaryRef = unsafeBitCast(
            CFDictionaryGetValue(cfProperties, unsafeAddressOf(kCGImagePropertyGIFDictionary)),
            CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties, unsafeAddressOf(kCGImagePropertyGIFUnclampedDelayTime)),
            AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                unsafeAddressOf(kCGImagePropertyGIFDelayTime)), AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    
}


extension UIImageView {
    
}
