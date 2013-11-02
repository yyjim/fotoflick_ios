//
//  FOImagePFObject.m
//  Fotoflick-iOS
//
//  Created by yyjim on 11/2/13.
//  Copyright (c) 2013 cardinalblue. All rights reserved.
//

#import "FOImagePFObject.h"

@implementation FOImagePFObject
@dynamic imageURLString;

#pragma mark - PFSubclassing ovrrride

+ (void)createImage
{
    FOImagePFObject *imagePFObject = [self object];
    imagePFObject.imageURLString = @"http://images5.fanpop.com/image/photos/25600000/Hello-Kitty-Sitting-hello-kitty-25604546-1210-1429.jpg";
    [imagePFObject save];
}


+ (NSString *)parseClassName {
    return @"Image";
}

- (NSURL *)imageURL
{
    return [NSURL URLWithString:self.imageURLString];
}

@end