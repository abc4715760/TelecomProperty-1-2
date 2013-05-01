//
//  NewUserViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-9.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "DRUserDefaultsManager.h"
@interface NewUserViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate>
@property(nonatomic,retain)UITextField *numberField;//用户ID
@property(nonatomic,retain)UITextField *prassField;//密码
@end
