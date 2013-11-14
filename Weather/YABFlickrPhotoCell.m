//
//  YABFlickrPhotoCell.m
//  Weather
//
//  Created by Ian Shafer on 11/13/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABFlickrPhotoCell.h"
#import "YABRestClient.h"

@implementation YABFlickrPhotoCell

- (instancetype) init
{
    self = [super init];
    if (self) {
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setup
{
    _imageView.image = nil;
    
    _downloadTask = [[YABRestClient singletonInstance] getImageFromUrl:_photo.originalUrl success:^(UIImage *image) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _imageView.image = image;
        }];
    } error:^(NSError *error) {
        NSLog(@"Error retrieving image [%@]", error.description);
    }];
}

- (void) maybeCancelDownload
{
    if (_downloadTask) {
        [[YABRestClient singletonInstance] cancel:_downloadTask];
    }
}

@end
