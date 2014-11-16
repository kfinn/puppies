//
//  Gif.m
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

#import "Gif.h"

static NSString *const kTagsTransformer = @"kTagsTransformer";
static NSString *const kURLTransformer = @"kURLTransformer";

@implementation Gif

+ (void)load {
    [super load];
    
    [NSValueTransformer setValueTransformer:[MTLValueTransformer transformerWithBlock:^NSSet *(NSArray *input) {
        return [NSSet setWithArray:input];
    }] forName:kTagsTransformer];
    
    [NSValueTransformer setValueTransformer:[MTLValueTransformer transformerWithBlock:^NSURL*(NSString *input) {
        return [NSURL URLWithString:input];
    }] forName:kURLTransformer];
}

+ (NSArray *)gifsWithData:(NSData *)data {
    NSArray *gifsJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil][@"data"];
    return [MTLJSONAdapter modelsOfClass:self fromJSONArray:gifsJson error:nil];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"url": @"image_url", @"width": @"image_width", @"height": @"image_height"};
}

+ (NSValueTransformer *)tagsJSONTransformer {
    return [NSValueTransformer valueTransformerForName:kTagsTransformer];
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:kURLTransformer];
}

@end
