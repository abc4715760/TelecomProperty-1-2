//
//  LoginViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"//post请求
#import "NewUserViewController.h"//注册用户界面
#import "AttributedLabel.h"//label字体画线
#import "DRUserDefaultsManager.h"//自动登陆记住密码
#import "JSON.h"

//定义一个协议
@protocol LoginDelegate <NSObject>
-(void)userinformation:(NSMutableArray *)array  andselectde:(NSString *)sender;
@end
@interface LoginViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate>
{
    float hiegt;//区分 iphone 4 iphone 5的高度
}
@property(nonatomic,retain)UITextField *field; //用户
@property(nonatomic,retain)UITextField *fieldMI; //密码
@property(nonatomic,retain) UIButton * butpass;//记住密码
@property(nonatomic,assign)BOOL ispasswold;//判断是否记住密码
@property(nonatomic,retain) UIButton *but;//登陆
@property(nonatomic,assign)BOOL IsAuto;//记住密码
@property(nonatomic,retain) UIImageView *loginback;//登陆背景
@property(nonatomic,assign)id<LoginDelegate>delegate;
@end
