//
//  Gif.h
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Mantle/Mantle.h>

@interface Gif : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSString *id;
@property (nonatomic) NSSet *tags;
@property (nonatomic) NSURL *url;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

+ (NSArray *)gifsWithData:(NSData *)data;

@end
