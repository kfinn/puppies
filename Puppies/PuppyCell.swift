//
//  PuppyCell.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

class PuppyCell: UICollectionViewCell {
    
    let gifView : GifView = {
        let gifView = GifView(frame: CGRectZero)
        gifView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        return gifView
    }()
    
    var gif : Gif? {
        didSet {
            gifView.gif = gif
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gifView.frame = contentView.bounds
        contentView.addSubview(gifView)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gifView.frame = contentView.bounds
        contentView.addSubview(gifView)
    }
}
