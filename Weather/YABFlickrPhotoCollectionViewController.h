//
//  YABFlickerPhotoCollectionViewController.h
//  Weather
//
//  Created by Ian Shafer on 11/13/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YABFlickrPhotoCollectionViewController : UICollectionViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *photos;

@end
