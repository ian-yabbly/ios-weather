//
//  YABFlickrPhotoCell.h
//  Weather
//
//  Created by Ian Shafer on 11/13/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YABFlickrPhoto.h"

@interface YABFlickrPhotoCell : UICollectionViewCell

@property (nonatomic, strong) YABFlickrPhoto *photo;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) id downloadTask;

- (void) setup;
- (void) maybeCancelDownload;

@end
