//
//  YABWeatherView.m
//  Weather
//
//  Created by Ian Shafer on 11/12/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABWeatherView.h"

@implementation YABWeatherView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupView
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.text = _weather.locationName;
    [self addSubview:_nameLabel];

    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.text = _weather.description;
    [self addSubview:_descriptionLabel];

    _tempLabel = [[UILabel alloc] init];
    _tempLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _tempLabel.text = [NSString stringWithFormat:@"Temp: %@\u00B0 (%@\u00B0-%@\u00B0)", _weather.currentTemp, _weather.minTemp, _weather.maxTemp];
    [self addSubview:_tempLabel];


    NSDictionary *viewDict = @{@"nameLabel": _nameLabel,
                               @"descriptionLabel": _descriptionLabel,
                               @"tempLabel": _tempLabel};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[nameLabel]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameLabel]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[descriptionLabel]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameLabel]-10-[descriptionLabel]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[tempLabel]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[descriptionLabel]-10-[tempLabel]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];
}

@end
