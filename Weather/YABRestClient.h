//
//  YABRestClient.h
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YABWeather.h"

@interface YABRestClient : NSObject

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDataTask *getWeatherTask;

+ (YABRestClient *)singletonInstance;

- (void)getWeatherByCity:(NSString *)city
                 country:(NSString *)country
                 success:(void (^)(YABWeather *))successHandler
                   error:(void (^)(NSError *))errorHandler;

@end