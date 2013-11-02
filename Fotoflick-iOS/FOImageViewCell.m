//
//  RecipeViewCell.m
//  CollectionViewDemo
//
//  Created by Simon on 9/1/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FOImageViewCell.h"

@implementation FOImageViewCell
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.borderColor = CBRGBA(255, 255, 255, 0.3).CGColor;
    self.imageView.layer.borderWidth = 0.5;
}

@end
