//
//  DetailCollectionViewController.m
//  Fotoflick-iOS
//
//  Created by yyjim on 11/3/13.
//  Copyright (c) 2013 cardinalblue. All rights reserved.
//

#import "DetailCollectionViewController.h"
#import "FOImageGalleryViewCell.h"
#import "CBWebImage.h"

@interface DetailCollectionViewController ()

@end

@implementation DetailCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
//    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
//    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    collectionViewLayout.minimumInteritemSpacing = 0;
    
    UICollectionViewFlowLayout *flowLayout =
        (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    flowLayout.itemSize = CGSizeMake(320, 504);
    [self.collectionView setCollectionViewLayout:flowLayout];
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    [self.collectionView reloadData];
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return [self.imageURLs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    FOImageGalleryViewCell *cell = (FOImageGalleryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = cell.imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSURL *url = [self.imageURLs objectAtIndex:indexPath.item];
    [imageView setImageWithURL:url placeholderImage:Nil
                       options:CBWebImageOptionsDefault
                     animation:CBWebImageViewAnimationOptionTypeFadeIn
               completionBlock:^(UIImage *image, NSError *error) {
                   
               }];
    return cell;
}

@end
