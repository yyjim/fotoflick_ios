//
//  FOImageGalleryViewCell.m
//  Fotoflick-iOS
//
//  Created by yyjim on 11/3/13.
//  Copyright (c) 2013 cardinalblue. All rights reserved.
//

#import "FOImageGalleryViewCell.h"

@implementation FOImageGalleryViewCell

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
    self.imageView.layer.borderWidth = 0;
}

@end
