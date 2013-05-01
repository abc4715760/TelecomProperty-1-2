//
//  MyBusinessCardViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "UrlAddress.h"//存城市名字
#import "LoginViewController.h"
#import "CommunityListViewController.h"//小区列表
@interface MyBusinessCardViewController : UIViewController<UISearchBarDelegate,UIAlertViewDelegate,EncapsupationDelegate,UITableViewDataSource,UITableViewDelegate>{
    int height;
    EncapsulationASI *encapsulation;
}
@property(nonatomic,retain) UIPickerView*picker;//显示
@property(nonatomic,retain)NSString *strcity;//显示城市里的区
@property(nonatomic,retain)NSString *strcity0;//显示城市
@property(nonatomic,retain)NSString *strcity1;//显示城市 区下的小区
@property(nonatomic,retain)UISearchBar *search;//显示所选的地址
@property(nonatomic,retain)NSMutableArray *array;//显示城市数组
@property(nonatomic,retain)NSMutableArray *arraycoumy;//显示城市区数组
@property(nonatomic,retain)NSMutableArray *Community;//存放社区名字
@property(nonatomic,retain) UIActivityIndicatorView *activityViewLoad;//活动指示器
@property(nonatomic,retain)NSString *groupindex;//小区ID
@property(nonatomic,retain)UITableView *tableView;//显示市下的县区
@end