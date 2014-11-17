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
        tags.numberOfLines = 0
        tags.setTranslatesAutoresizingMaskIntoConstraints(false)
        return tags
    }()
    
    private let gifView : GifView = {
        let gifView = GifView(frame: CGRectZero)
        gifView.setTranslatesAutoresizingMaskIntoConstraints(false)
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
    
    var hasConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.5
        backgroundColor = UIColor.whiteColor()
        setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addSubview(tagsLabel)
        addSubview(gifView)
        
        self.setNeedsUpdateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !hasConstraints {
            hasConstraints = true
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[gif]-|", options: .allZeros, metrics: nil, views: ["gif": gifView]))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-[label]-|", options: .allZeros, metrics: nil, views: ["label": tagsLabel]))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[gif]-[label]-|", options: .allZeros, metrics: nil, views: ["gif": gifView, "label": tagsLabel]))
        }
        
        super.updateConstraints()
    }
}
