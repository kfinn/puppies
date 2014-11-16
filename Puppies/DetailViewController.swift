//
//  DetailViewController.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, ZLSwipeableViewDataSource, ZLSwipeableViewDelegate {
    
    let swipeView = ZLSwipeableView()

    let gifStore : GifStore
    var currentIndex : Int
    
    required init(gifStore: GifStore, fromIndex: Int) {
        self.gifStore = gifStore
        self.currentIndex = fromIndex
        super.init(nibName: nil, bundle: nil)
        swipeView.dataSource = self
        swipeView.delegate = self
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeView.frame = view.bounds
        swipeView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.view.addSubview(swipeView)
    }
    
    func nextViewForSwipeableView(swipeableView: ZLSwipeableView!) -> UIView! {
        let gif = gifStore.gifs[currentIndex]
        let view = GifView(frame: CGRect(origin: CGPointZero, size: CGSize(width: gif.width, height: gif.height)))
        view.gif = gifStore.gifs[currentIndex]
        currentIndex++
        return view
    }
    
    func swipeableView(swipeableView: ZLSwipeableView!, didSwipeRight view: UIView!) {
        if let gifView = view as? GifView {
            gifStore.upVote(gifView.gif!)
        }
        maybeFetchMore()
    }
    
    func swipeableView(swipeableView: ZLSwipeableView!, didSwipeLeft view: UIView!) {
        if let gifView = view as? GifView {
            gifStore.downVote(gifView.gif!)
        }
        maybeFetchMore()
    }
    
    private func maybeFetchMore() {
        if gifStore.gifs.count - currentIndex < 25 {
            gifStore.preload()
        }
    }
}
