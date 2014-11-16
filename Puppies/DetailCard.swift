//
//  DetailCard.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

class DetailCard: UIView {
    
    private let tagsLabel : UILabel = {
        let tags = UILabel()
        tags.autoresizingMask = .FlexibleTopMargin | .FlexibleWidth
        tags.numberOfLines = 0
        return tags
    }()
    
    private let gifView : GifView = {
        let gifView = GifView(frame: CGRectZero)
        gifView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleRightMargin | .FlexibleLeftMargin
        return gifView
    }()
    
    var gif : Gif? {
        didSet {
            gifView.gif = gif
            if let tags = gif?.tags.allObjects as? [String] {
                self.tagsLabel.text = ", ".join(tags)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor.whiteColor()
        
        let tagsFrame = CGRectMake(10, bounds.height - 50, bounds.width - 20, 40)
        tagsLabel.frame = tagsFrame
        addSubview(tagsLabel)
        
        let gifFrame = CGRectMake(10, 10, bounds.width - 20, bounds.height - 60)
        gifView.frame = gifFrame
        addSubview(gifView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
