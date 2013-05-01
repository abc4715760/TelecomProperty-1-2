//
//  ChineseToPinyin.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-23.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseToPinyin : NSObject {
    
}

+ (NSString *) pinyinFromChiniseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string;

@end