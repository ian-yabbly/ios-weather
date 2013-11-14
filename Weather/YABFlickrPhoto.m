//
//  YABFlickrPhoto.m
//  Weather
//
//  Created by Ian Shafer on 11/13/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABFlickrPhoto.h"

@implementation YABFlickrPhoto

- (instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];

    if (self) {
        self.photoId = [dict objectForKey:@"id"];
        self.title = [dict objectForKey:@"title"];
        self.square75Url = [dict objectForKey:@"url_s"];
        self.square150Url = [dict objectForKey:@"url_q"];
        self.originalUrl = [dict objectForKey:@"url_o"];
    }

    return self;
}

@end
