//
//  YABWeatherView.h
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YABWeather.h"

@interface YABWeatherView : UIView

@property (nonatomic, strong) UILabel *nameLabel, *descriptionLabel, *tempLabel, *cloudPctLabel;
@property (nonatomic, strong) YABWeather *weather;

- (void)setupView;

@end
