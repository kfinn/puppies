//
//  InterfaceController.swift
//  Puppies WatchKit Extension
//
//  Created by Kevin Finn on 11/18/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet
    var image : WKInterfaceImage?

    override init(context: AnyObject?) {
        super.init(context: context)
        
        let puppyImage = UIImage.animatedImageWithAnimatedGIFURL(NSBundle.mainBundle().URLForResource("puppy", withExtension: "gif"))
        image!.setImage(puppyImage)
        let allFrames = NSRange(location:0, length:puppyImage.images!.count)
        image!.startAnimatingWithImagesInRange(allFrames, duration: 1, repeatCount: 0)
    }
}
