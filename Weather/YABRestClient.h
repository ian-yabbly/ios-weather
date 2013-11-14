//
//  YABRestClient.h
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YABWeather.h"

#define FLICKR_API_KEY @"9ec32eb2e4cd15c14dcf7aa59a8d4f8f"
#define FLICKR_API_SECRET @"60f59d57ecf79dae"
#define FLICKR_GALLERY_ID @"5704-72157635109428121"

@interface YABRestClient : NSObject

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDataTask *getWeatherTask;

+ (YABRestClient *)singletonInstance;

- (void)getWeatherByCity:(NSString *)city
                 country:(NSString *)country
                 success:(void (^)(YABWeather *))successHandler
                   error:(void (^)(NSError *))errorHandler;

- (void)getPhotosSuccess:(void (^)(NSArray *))successHandler
                     error:(void (^)(NSError *))errorHandler;

- (id)getImageFromUrl:(NSString *)urlStr
                success:(void (^)(UIImage *))successHandler
                  error:(void (^)(NSError *))errorHandler;

- (void)cancel:(id)task;

@end