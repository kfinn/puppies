//
//  PuppyCell.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

let emptyAnimatedImage = FLAnimatedImage(animatedGIFData: NSData())

class PuppyCell: UICollectionViewCell {
    
    var gif : Gif? {
        didSet {
            if gif != nil {
                let requestGif = gif
                NSURLSession.sharedSession().dataTaskWithURL(requestGif!.url) {
                    (data, response, error) in
                    if requestGif == self.gif {
                        self.gifView.animatedImage = FLAnimatedImage(animatedGIFData: data)
                    }
                }.resume()
            } else {
                self.gifView.animatedImage = emptyAnimatedImage;
            }
        }
    }
    
    let gifView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        return imageView
    }()
    
    var hasConstraints = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gifView.frame = bounds;
        self.contentView.addSubview(gifView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gifView.frame = bounds;
        self.contentView.addSubview(gifView)
    }
}
