//
//  YABViewController.m
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABViewController.h"
#import "YABRestClient.h"
#import "YABWeatherView.h"

@interface YABViewController ()

@end

@implementation YABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor lightGrayColor];

    _weatherView = [[YABWeatherView alloc] init];
    _weatherView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_weatherView];

    UIButton *refreshButton = [[UIButton alloc] init];
    refreshButton.translatesAutoresizingMaskIntoConstraints = NO;
    [refreshButton setTitle:@"Refresh" forState:UIControlStateNormal];
    refreshButton.backgroundColor = [UIColor grayColor];
    [refreshButton addTarget:self action:@selector(refreshTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshButton];

    NSDictionary *viewsDict = @{@"weatherView": _weatherView, @"refreshButton": refreshButton};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[refreshButton]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDict]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[weatherView]-20-[refreshButton]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDict]];

    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"|[weatherView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDict]];

    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[weatherView]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDict]];
    _activityIndicatorView = [[UIActivityIndicatorView alloc]
                                                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activityIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [_activityIndicatorView addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.f
                                                                        constant:100.f]];

    [_activityIndicatorView addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.f
                                                                        constant:100.f]];

    [self fetchWeather];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTapped:(UIButton *)refreshButton
{
    [self fetchWeather];
}

- (void)fetchWeather
{
    [_activityIndicatorView startAnimating];
    [_weatherView addSubview:_activityIndicatorView];

    // TODO These constraints should prolly only be added once
    [_weatherView addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_weatherView
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];

    [_weatherView addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:_weatherView
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0]];

    [[YABRestClient singletonInstance] getWeatherByCity:@"Seattle"
                                                country:@"us"
                                                success:^(YABWeather *weather) {
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^() {
                                                        [_activityIndicatorView stopAnimating];
                                                        [_activityIndicatorView removeFromSuperview];
                                                        _weatherView.weather = weather;
                                                        [_weatherView setupView];
                                                    }];
                                                }
                                                  error:^(NSError *error) {
                                                      NSLog(@"%@", error.description);
                                                  }];
}

@end
