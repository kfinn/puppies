//
//  ViewController.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

let puppyReuseID = "puppyReuseID"

class ViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout {

    var model: [Gif] = []
    
    override init() {
        let flowLayout = CHTCollectionViewWaterfallLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumColumnSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(collectionViewLayout: flowLayout)
        
        navigationItem.title = "Puppies"
    }

    required convenience init(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerClass(PuppyCell.self, forCellWithReuseIdentifier: puppyReuseID)
        
        self.navigationController?.scrollNavigationBar.scrollView = collectionView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string:"http://api.giphy.com/v1/gifs/search?q=puppy&api_key=dc6zaTOxFJmzC")!) {
            (data, response, error) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            let gifs = Gif.gifsWithData(data)
            for gif in gifs {
                if let typedGif = gif as? Gif {
                    self.model.append(typedGif)
                }
            }
            self.collectionView.reloadData()
        }.resume()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(puppyReuseID, forIndexPath: indexPath) as PuppyCell
        cell.gif = model[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        if let firstGif = model.first {
            return Int(round(view.bounds.width / firstGif.width))
        }
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let scale = UIScreen.mainScreen().scale
        let gif = model[indexPath.item]
        return CGSize(width: gif.width / scale, height: gif.height / scale)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
