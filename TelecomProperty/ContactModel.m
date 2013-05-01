//
//  ContactModel.m
//  ContactDome
//
//  Created by dujiepeng on 13-2-27.
//  Copyright (c) 2013年 dujiepeng. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel
@synthesize PersonID;
@synthesize PersonName;
@synthesize PhoneLabelAry;
@synthesize PersonImageData;
@synthesize PersonNameFirstLetter;
@synthesize PersonNameLetter;
- (id)init
{
    self = [super init];
    if (self) {
        self.PhoneLabelAry = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [PersonNameLetter release];
    [PersonNameFirstLetter release];
    [PersonImageData release];
    [PersonName release];
    [PhoneLabelAry release];
    [super dealloc];
}
@end
