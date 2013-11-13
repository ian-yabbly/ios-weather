//
//  YABRestClient.m
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABRestClient.h"

@implementation YABRestClient

+ (YABRestClient *)singletonInstance
{
    static dispatch_once_t pred;
    static YABRestClient *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[YABRestClient alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:urlSessionConfig
                                                    delegate:nil
                                               delegateQueue:nil];
    }
    return self;
}

- (void)getWeatherByCity:(NSString *)city
                 country:(NSString *)country
                 success:(void (^)(YABWeather *))successHandler
                   error:(void (^)(NSError *))errorHandler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?units=imperial&q=%@,%@", city, country]];

    if (_getWeatherTask && _getWeatherTask.state == NSURLSessionTaskStateRunning) {
        [_getWeatherTask cancel];
    }

    _getWeatherTask = [_urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error && errorHandler) {
            errorHandler(error);
        } else if (successHandler) {
            NSError *error;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            YABWeather *weather = [[YABWeather alloc] initWithDict:jsonDict];
            successHandler(weather);
        }
    }];

    [_getWeatherTask resume];
}

- (void)getPhotosSuccess:(void (^)(NSArray *))successHandler
                   error:(void (^)(NSError *))errorHandler
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&name=value&api_key=%@&gallery_id=%@", FLICKR_API_KEY, FLICKR_GALLERY_ID]];
    NSURLSessionDataTask *task = [_urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // TODO Check error and process data
    }];

    [task resume];
}

@end
