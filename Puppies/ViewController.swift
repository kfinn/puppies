//
//  ViewController.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

let puppyReuseID = "puppyReuseID"
private let columnWidth: CGFloat = 200.0

class ViewController: UICollectionViewController, CHTCollectionViewDelegateWaterfallLayout {

    let gifStore = GifStore()
    
    override init() {
        let flowLayout = CHTCollectionViewWaterfallLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumColumnSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(collectionViewLayout: flowLayout)
        navigationItem.title = "Puppies"
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handleGifAdded:", name: GifStoreAddedGifNotification, object: gifStore)
    }
    
    func handleGifAdded(notification: NSNotification) {
        collectionView.reloadData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    required convenience init(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.lightGrayColor()
        collectionView.registerClass(PuppyCell.self, forCellWithReuseIdentifier: puppyReuseID)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if gifStore.gifs.isEmpty {
            gifStore.preload()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(puppyReuseID, forIndexPath: indexPath) as PuppyCell
        cell.gif = gifStore.gifs[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        return Int(round(view.bounds.width / columnWidth))
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifStore.gifs.count
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let gif = gifStore.gifs[indexPath.item]
        return CGSize(width: columnWidth, height: (columnWidth / gif.width) * gif.height)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = DetailViewController(gifStore: gifStore, fromIndex: indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
