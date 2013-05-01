//
//  MyDynamicViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSON.h"
#import "UrlAddress.h"//存城市名字
#import "AsyncImageView.h"
#import "EncapsulationASI.h"//

@interface MyDynamicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,EncapsupationDelegate>
{
    int higet;
 }
@property(nonatomic,retain)UITableView *Tablecommunity;//推荐小区信息展示
@property(nonatomic,retain)NSMutableArray *Arraycommunity;//存总小区信息
@property (nonatomic,retain)NSArray *arr;//存小区的名字
@property (assign)BOOL isOpen;//判断cell是否处于展开
@property(nonatomic,retain)UISearchBar *search;//显示所选的地址
@property (nonatomic,retain)NSIndexPath *selectIndex;//选择的哪行
@property(nonatomic,retain)NSMutableArray *array;//显示城市数组
@property(nonatomic,retain)NSMutableArray *arraycoumy;//显示城市区数组
@property(nonatomic,retain)NSMutableArray *Community;//存放小区名字
@property(nonatomic,retain) UIActivityIndicatorView *activityViewLoad;//活动指示器
@property(nonatomic,retain)NSMutableArray *Mycommunity;//存搜索的小区介绍列表；
@property(nonatomic,retain)UITableView *searchTable;//搜索后显示的小区
@property(nonatomic,retain)NSMutableArray *recommended;//推荐小区信息
@end
