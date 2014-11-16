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
    
    private var tagWeights = [String : Int]()
    private var totalWeight = 0
    
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
    
    required init(tag: String) {
        self.tag = tag
        super.init()
    }
    
    convenience override init() {
        self.init(tag: "puppy")
    }
    
    func preload() {
        for _ in 0 ... 25 {
            NSLog("calling fetchGif")
            fetchGif()
        }
    }
    
    private func fetchGif() {
        let tag = randomTag;
        let url = NSURL(string: "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=\(tag)")
        NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, _, _) in
            if let payloadJson = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: nil) as? [NSObject : [NSObject : AnyObject]] {
                if let gifJson = payloadJson["data"] {
                    if let gif = MTLJSONAdapter.modelOfClass(Gif.self, fromJSONDictionary: gifJson, error: nil) as? Gif {
                        if !(self.gifsById[gif.id] != nil) {
                            self.gifsById[gif.id] = gif
                            self.gifs.append(gif)
                            NSNotificationCenter.defaultCenter().postNotificationName(GifStoreAddedGifNotification, object: self, userInfo: [GifStoreAddedGifNotificationIndexKey : self.gifs.count - 1])
                        }
                    }
                }
            } else {
                // try again
                self.fetchGif()
            }
        }.resume()
    }
}
