//
//  FOImagePFObject.h
//  Fotoflick-iOS
//
//  Created by yyjim on 11/2/13.
//  Copyright (c) 2013 cardinalblue. All rights reserved.
//

#import <Parse/Parse.h>

@interface FOImagePFObject : PFObject
    <PFSubclassing>
@property (strong) NSString *imageURLString;
@property (assign, readonly) NSURL *imageURL;
+ (NSString *)parseClassName;
+ (void)createImage;
@end