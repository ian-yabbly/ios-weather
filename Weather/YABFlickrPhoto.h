//
//  YABFlickrPhoto.h
//  Weather
//
//  Created by Ian Shafer on 11/13/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YABFlickrPhoto : NSObject

@property (nonatomic, strong) NSString *photoId, *title, *square75Url, *square150Url, *originalUrl;

- (instancetype) initWithDict:(NSDictionary *)dict;

@end
