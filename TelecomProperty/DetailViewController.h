//
//  DetailViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-17.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncapsulationASI.h"
@interface DetailViewController : UIViewController
{
    int higt;
}
@property(nonatomic, retain)NSString *DetailsubtitlStr;
@property(nonatomic,retain)UITextView * communityLabel;
@property(nonatomic,retain)NSString *titleStr;
@end
