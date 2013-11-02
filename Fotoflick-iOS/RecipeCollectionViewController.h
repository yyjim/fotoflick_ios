//
//  RecipeCollectionViewController.h
//  CollectionViewDemo
//
//  Created by Simon on 9/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
- (IBAction)shareButtonTouched:(id)sender;

@end
