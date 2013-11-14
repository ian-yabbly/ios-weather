//
//  YABFlickerPhotoCollectionViewController.m
//  Weather
//
//  Created by Ian Shafer on 11/13/13.
//  Copyright (c) 2013 Yabbly. All rights reserved.
//

#import "YABFlickrPhotoCollectionViewController.h"
#import "YABFlickrPhotoCell.h"
#import "YABRestClient.h"
#import "YABFlickrPhoto.h"

@interface YABFlickrPhotoCollectionViewController ()

@end

@implementation YABFlickrPhotoCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.collectionView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [[YABRestClient singletonInstance]
     getPhotosSuccess:^(NSArray *photos) {
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             _photos = photos;
             [self.collectionView reloadData];
         }];
     }
     error:^(NSError *error) {
         NSLog(@"Error [%@]", error.description);
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_photos) {
        return _photos.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YABFlickrPhoto *photo = [_photos objectAtIndex:indexPath.row];
    YABFlickrPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoCell"
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.photo = photo;
    [cell setup];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150.f, 150.f);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell display ending [%d] [%d]", indexPath.section, indexPath.row);
    YABFlickrPhotoCell *flickrPhotoCell = (YABFlickrPhotoCell *) cell;
    [flickrPhotoCell maybeCancelDownload];
    flickrPhotoCell.imageView.image = nil;
}

@end
