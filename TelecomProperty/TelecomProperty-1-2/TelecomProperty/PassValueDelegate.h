//
//  PassValueDelegate.h
//  DropDownList
//
//  Created by kingyee on 11-9-8.
//  Copyright 2011 Kingyee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlAddress.h"

@protocol PassValueDelegate

- (void)passValue:(NSString *)value andaddress:(UrlAddress*)address;

@end
