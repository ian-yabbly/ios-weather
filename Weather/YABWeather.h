//
//  YABWeather.h
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YABWeather : NSObject

@property (nonatomic, strong) NSString *description, *locationName;
@property (nonatomic, strong) NSNumber *currentTemp, *minTemp, *maxTemp, *cloudPct;

- (instancetype) initWithDict:(NSDictionary *)dict;

@end
