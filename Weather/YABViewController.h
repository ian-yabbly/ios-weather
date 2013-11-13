//
//  YABViewController.h
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YABWeatherView.h"

@interface YABViewController : UIViewController

@property (nonatomic, strong) YABWeatherView *weatherView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end
