//
//  DetailViewController.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ZLSwipeableViewDataSource, ZLSwipeableViewDelegate {
    
    lazy var swipeView = ZLSwipeableView()

    let gifStore : GifStore
    var currentIndex : Int
    
    required init(gifStore: GifStore, fromIndex: Int) {
        self.gifStore = gifStore
        self.currentIndex = fromIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
        swipeView.frame = view.bounds
        swipeView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        view.addSubview(swipeView)
        swipeView.dataSource = self
        swipeView.delegate = self
    }
    
    func nextViewForSwipeableView(swipeableView: ZLSwipeableView!) -> UIView! {
        
        let card = DetailCard(frame: view.bounds)
        card.gif = gifStore.gifs[currentIndex]
        card.setTranslatesAutoresizingMaskIntoConstraints(false)
        card.updateConstraintsIfNeeded()
        card.layoutIfNeeded()
        card.center = swipeableView.swipeableViewsCenter
        currentIndex++
        return card
    }
    
    func swipeableView(swipeableView: ZLSwipeableView!, didSwipeRight view: UIView!) {
        if let gifView = view as? DetailCard {
            gifStore.upVote(gifView.gif!)
        }
        maybeFetchMore()
    }
    
    func swipeableView(swipeableView: ZLSwipeableView!, didSwipeLeft view: UIView!) {
        if let gifView = view as? DetailCard {
            gifStore.downVote(gifView.gif!)
        }
        maybeFetchMore()
    }
    
    private func maybeFetchMore() {
        if gifStore.gifs.count - currentIndex < 5 {
            gifStore.preload()
        }
    }
}
