//
//  GifStore.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import Foundation

public let GifStoreAddedGifNotification = "GifStoreAddedGifNotification"
public let GifStoreAddedGifNotificationIndexKey = "GifStoreAddedGifNotificationIndexKey"

class GifStore : NSObject {
    
    let tag: String
    var gifs = [Gif]()
    var gifsById = [String : Gif]()
    var requests = [NSURLSessionDataTask]()
    
    private var tagWeights = [String : Int]()
    private var totalWeight = 0
    
    required init(tag: String) {
        self.tag = tag
        super.init()
    }
    
    convenience override init() {
        self.init(tag: "puppy")
    }
}

extension GifStore {
    
    func upVote(gif: Gif) {
        vote(gif, weight: 1)
    }
    
    func downVote(gif: Gif) {
        vote(gif, weight: -1)
    }
    
    private func vote(gif: Gif, weight: Int) {
        if let tags = gif.tags.allObjects as? [String] {
            for tag in tags {
                if let currentVotes = tagWeights[tag] {
                    tagWeights[tag] = currentVotes + weight
                } else {
                    tagWeights[tag] = weight
                }
                totalWeight += weight
            }
        }
    }
}

extension GifStore {
    
    private var randomTag : String {
        get {
            if totalWeight != 0 {
                let randomIndex = random() % totalWeight
                var count = 0
                for (tag, weight) in tagWeights {
                    count += weight
                    if count > randomIndex {
                        return tag
                    }
                }
            }
            return tag
        }
    }
    
    func preload() {
        for _ in 0 ... 25 {
            fetchGif()
        }
    }
    
    private func fetchGif() {
        let tag = randomTag.stringByReplacingOccurrencesOfString(" ", withString: "-", options: .allZeros, range:nil);
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=\(tag)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            if let gif = Gif.fromData(data) {
                if !(self.gifsById[gif.id] != nil) {
                    self.gifsById[gif.id] = gif
                    self.gifs.append(gif)
                    NSNotificationCenter.defaultCenter().postNotificationName(GifStoreAddedGifNotification, object: self, userInfo: [GifStoreAddedGifNotificationIndexKey : self.gifs.count - 1])
                } else {
                    // try again for a new one
                    self.fetchGif()
                }
            } else {
                for request in self.requests {
                    request.cancel()
                }
                self.requests = []
                if let errorJson = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: nil) as? [String : AnyObject] {
                    if let meta = errorJson["meta"] as? [String : AnyObject] {
                        if let msg = meta["msg"] as? String {
                            UIAlertView(title: "Giphy Error", message: msg, delegate: nil, cancelButtonTitle: "OK").show()
                            return
                        }
                    }
                }
                if !(error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled) {
                    UIAlertView(title: "Unexpected Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                }
            }
        }
        requests.append(task)
        task.resume()
    }
}
