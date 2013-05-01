//
//  ResidentialIntroducedViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-20.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
#import "UrlAddress.h"
#import "JSON.h"
@interface ResidentialIntroducedViewController : UIViewController<UIScrollViewDelegate,EncapsupationDelegate,UIWebViewDelegate>
@property(retain,nonatomic)UrlAddress *strname;//小区对象
@property(retain,nonatomic)  UIWebView *web;//显示详情
@property(retain,nonatomic)UIActivityIndicatorView* activity;
@end
