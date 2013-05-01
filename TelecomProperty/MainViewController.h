//
//  MainViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "Cell.h"

@interface MainViewController : UIViewController<NSURLConnectionDataDelegate,UITextFieldDelegate,UIGridViewDelegate>
@property(nonatomic,retain)NSMutableData *data;
@property(nonatomic,retain)UILabel *label3;
@property(nonatomic,retain)UIGridView *tabel;

@end
