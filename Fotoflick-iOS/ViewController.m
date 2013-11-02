//
//  ViewController.m
//  Fotoflick-iOS
//
//  Created by yyjim on 11/2/13.
//  Copyright (c) 2013 cardinalblue. All rights reserved.
//

#import <Parse/Parse.h>
#import "ViewController.h"
#import "FOImageViewCell.h"
#import "CBWebImage.h"
#import "DetailCollectionViewController.h"

#import "FOImagePFObject.h"

@interface ViewController ()
@property (strong) NSArray *imageURLs;
@end

@implementation ViewController

- (void)handleSystemNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:UIApplicationWillEnterForegroundNotification]) {
        [self queryData];
    }
}

- (void)handleTimer:(id)sender
{
    [self queryData];
}

- (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSystemNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)awakeFromNib
{
    [NSTimer scheduledTimerWithTimeInterval:20 target:self
                                   selector:@selector(handleTimer:)
                                   userInfo:nil
                                    repeats:YES];
    [self initialize];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)queryData
{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970];
    NSDate *beforeDate = [NSDate dateWithTimeIntervalSince1970:timeInterval - 60 * 60];
    
    PFQuery *query = [FOImagePFObject query];
    [query whereKey:@"createdAt" greaterThan:beforeDate];
    [query whereKey:@"createdAt" lessThan:currentDate];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            [self handleFetchData:objects];
        }
    }];
}

- (void)handleFetchData:(NSArray *)fetchData
{
    self.imageURLs = [fetchData collect:^id(id obj) {
        FOImagePFObject *imagePFObject = SAFE_CAST([FOImagePFObject class], obj);
        return imagePFObject.imageURL;
    }];
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 11, 0, 11);
    collectionViewLayout.itemSize = CGSizeMake(92, 92);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryData];
}


#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageURLs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    FOImageViewCell *cell = (FOImageViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *imageView = cell.imageView;
    
    NSURL *url = [self.imageURLs objectAtIndex:indexPath.item];
    [imageView setImageWithURL:url placeholderImage:Nil
                       options:CBWebImageOptionsDefault
                     animation:CBWebImageViewAnimationOptionTypeFadeIn
               completionBlock:^(UIImage *image, NSError *error) {
                   
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        DetailCollectionViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        destViewController.imageURLs = self.imageURLs;
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}


@end
