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
                    fetchImage();
                }
            }
            setNeedsLayout()
        }
    }
    
    private func fetchImage() {
        if let requestGif = gif {
            NSURLSession.sharedSession().dataTaskWithURL(requestGif.url) {
                (data, response, error) in
                if let animatedImage = FLAnimatedImage(animatedGIFData: data) {
                    animatedImageCache.setObject(animatedImage, forKey: requestGif)
                    if requestGif == self.gif {
                        self.gifView.animatedImage = animatedImage
                    }
                } else {
                    NSLog("request failed: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
    var hasConstraints = false
    
    override func updateConstraints() {
        if !hasConstraints {
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-0-[gif]-0-|", options: .allZeros, metrics: nil, views: ["gif":gifView]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[gif]-0-|", options: .allZeros, metrics: nil, views: ["gif":gifView]))
        }
        
        super.updateConstraints()
    }

    let gifView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return imageView
    }()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gifView.frame = bounds;
        addSubview(gifView)
//        setTranslatesAutoresizingMaskIntoConstraints(false)
        setNeedsUpdateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gifView.frame = bounds;
        addSubview(gifView)
//        setTranslatesAutoresizingMaskIntoConstraints(false)
        setNeedsUpdateConstraints()
    }
}
