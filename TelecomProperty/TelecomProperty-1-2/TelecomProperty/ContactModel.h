//
//  ContactModel.h
//  ContactDome
//
//  Created by dujiepeng on 13-2-27.
//  Copyright (c) 2013年 dujiepeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (assign) int PersonID;
@property (nonatomic,retain) NSString * PersonName;
@property (nonatomic,retain) NSMutableArray * PhoneLabelAry;
@property (nonatomic,retain) NSData * PersonImageData;
@property (nonatomic,retain) NSString * PersonNameFirstLetter;
@property (nonatomic,retain) NSString * PersonNameLetter;
@end


