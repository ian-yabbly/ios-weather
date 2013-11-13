//
//  YABWeather.m
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABWeather.h"

@implementation YABWeather

- (instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];

    if (self) {
        NSArray *weathers = [dict objectForKey:@"weather"];
        NSDictionary *main = [dict objectForKey:@"main"];
        NSDictionary *clouds = [dict objectForKey:@"clouds"];

        self.locationName = [dict objectForKey:@"name"];
        self.currentTemp = [self roundTemp:[main objectForKey:@"temp"]];
        self.minTemp = [self roundTemp:[main objectForKey:@"temp_min"]];
        self.maxTemp = [self roundTemp:[main objectForKey:@"temp_max"]];
        self.cloudPct = [clouds objectForKey: @"all"];
        if (weathers.count > 0) {
            self.description = [[weathers firstObject] objectForKey:@"description"];
        }
    }

    return self;
}

- (NSNumber *)roundTemp:(NSNumber *)temp
{
    return [NSNumber numberWithInt:(int)([temp floatValue] + 0.5f)];
}

@end
