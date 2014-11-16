//
//  GifView.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

let animatedImageCache = NSCache()

class GifView: UIView {
    
    var gif : Gif? {
        didSet {
            self.gifView.animatedImage = nil;
            self.gifView.image = UIImage(named: "puppy.jpg");
            if let requestGif = gif? {
                if let cached = animatedImageCache.objectForKey(gif!) as? FLAnimatedImage {
                    self.gifView.animatedImage = cached
                } else {
                    let requestGif = gif
                    NSURLSession.sharedSession().dataTaskWithURL(requestGif!.url) {
                        (data, response, error) in
                        let animatedImage = FLAnimatedImage(animatedGIFData: data)
                        animatedImageCache.setObject(animatedImage, forKey: requestGif!)
                        if requestGif == self.gif {
                            self.gifView.animatedImage = animatedImage
                        }
                    }.resume()
                }
            }
        }
    }

    let gifView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gifView.frame = bounds;
        self.addSubview(gifView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gifView.frame = bounds;
        self.addSubview(gifView)
    }
}
