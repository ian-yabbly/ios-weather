//
//  YABRestClient.m
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABRestClient.h"
#import "YABFlickrPhoto.h"

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
            NSError *jsonError;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if (jsonError) {
                if (errorHandler) {
                    errorHandler(jsonError);
                }
            } else {
                YABWeather *weather = [[YABWeather alloc] initWithDict:jsonDict];
                successHandler(weather);
            }
        }
    }];

    [_getWeatherTask resume];
}

- (void)getPhotosSuccess:(void (^)(NSArray *))successHandler
                   error:(void (^)(NSError *))errorHandler
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.galleries.getPhotos&name=value&api_key=%@&gallery_id=%@&format=json&nojsoncallback=1&extras=url_s,url_q,url_o",
                        FLICKR_API_KEY,
                        FLICKR_GALLERY_ID];
    NSURL *url = [NSURL URLWithString:urlStr];

    NSURLSessionDataTask *task =
    [_urlSession dataTaskWithURL:url
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   if (error) {
                       if (errorHandler) {
                           errorHandler(error);
                       }
                   } else {
                       NSError *jsonError;
                       NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:kNilOptions
                                                                                  error:&jsonError];
                       if (jsonError) {
                           if (errorHandler) {
                               errorHandler(jsonError);
                           }
                       } else {
                           NSMutableArray *photos = [[NSMutableArray alloc] init];
                           NSArray *photoDicts = [[jsonDict objectForKey:@"photos"] objectForKey:@"photo"];
                           for (NSDictionary *p in photoDicts) {
                               YABFlickrPhoto *flickrPhoto = [[YABFlickrPhoto alloc] initWithDict:p];
                               [photos addObject:flickrPhoto];
                           }
                           successHandler(photos);
                       }
                   }
               }];

    [task resume];
}

- (id)getImageFromUrl:(NSString *)urlStr
                success:(void (^)(UIImage *))successHandler
                  error:(void (^)(NSError *))errorHandler
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionDataTask *task = [_urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (errorHandler) {
                errorHandler(error);
            }
        } else {
            UIImage *image = [UIImage imageWithData:data];
            if (successHandler) {
                successHandler(image);
            }
        }
    }];

    [task resume];

    return task;
}

- (void)cancel:(id)task
{
    NSURLSessionTask *theTask = (NSURLSessionTask *) task;
    if (theTask.state == NSURLSessionTaskStateRunning) {
        NSLog(@"Canceling download task");
        [theTask cancel];
    }
}

@end
