//
//  PuppyCell.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

class PuppyCell: UICollectionViewCell {
    
    let gifView : GifView
    
    var gif : Gif? {
        didSet {
            gifView.gif = gif
        }
    }
    
    override init(frame: CGRect) {
        gifView = GifView(frame: frame)
        super.init(frame: frame)
        gifView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        contentView.addSubview(gifView)
    }
    
    required init(coder aDecoder: NSCoder) {
        gifView = GifView(coder: aDecoder)
        super.init(coder: aDecoder)
        gifView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        contentView.addSubview(gifView)
    }
}
