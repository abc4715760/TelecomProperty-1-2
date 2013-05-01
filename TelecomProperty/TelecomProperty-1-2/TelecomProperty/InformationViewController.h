//
//  InformationViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"//首页的按钮布局控件
#import "UIGridViewDelegate.h"//
#import "Cell.h"
#import "Harpy.h"//更新版本
#import "JHTickerView.h"    // 滚动label
#import "UrlAddress.h"//一个对象存广告地址图片
#import "AOScrollerView.h"//广告滚动
#import "LoginViewController.h"//登陆信息
@interface InformationViewController : UIViewController<NSURLConnectionDataDelegate,UIGridViewDelegate,UIScrollViewDelegate,ValueClickDelegate,LoginDelegate,UIAlertViewDelegate,EncapsupationDelegate>
{
    NSMutableArray *Arr;//存放广告图片的数组
    int TimeNum;//控制时间在5秒滚动换一张图片
    BOOL Tend;//是反向转动
    BOOL Present;
    EncapsulationASI *encapsulation;//调封装的ASI
}
@property(nonatomic,retain)UIGridView *tabel;//公共板块
@property(nonatomic,retain)AOScrollerView*scroll;//存放广告的视图
@property(nonatomic,retain)UIPageControl *page;//让广告滚一页一页的滚动
@property(nonatomic,retain)JHTickerView* labelGPS;//滚动显示文字的视图
@property(nonatomic)float hight; //区分4 和5 的高度
@property(nonatomic,retain)NSString* IsLogin;//自动登陆
@property(nonatomic,retain)NSMutableArray *MutableArray;//存登陆返回回来的用户信息
@property(nonatomic,retain) UILabel *username;//用户姓名
@property(nonatomic,retain)NSMutableArray *tickerStrings;//滚动字母显示
@property(nonatomic,retain)NSString *NoticeInfonumber;//通知条数
@property(nonatomic,retain)UIImageView *imagenaber;//背景通知条数
@property(nonatomic,retain)UIButton * Login;//登陆按钮
@property(nonatomic,retain)UIGridView *tableView;//用户个人板块
@property(nonatomic,retain)UILabel *choicename;//选择的小区名字
@end
