//
//  FirstViewController.h
//  Test04
//
//  Created by HuHongbing on 9/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
#import "DetailViewController.h"
#import "ASIHTTPRequest.h"
#import "Announcements.h"
#import "LoadMoreTableFooterView.h"//上提显示更多
#import "EGORefreshTableHeaderView.h"//下拉刷新
#import "ASIFormDataRequest.h"
#import "UrlAddress.h"
/* 搜索条下面的tableview*/
#import "PassValueDelegate.h"
#import "DDList.h"
#import "AsyncImageView.h"
@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate,ASIHTTPRequestDelegate,LoadMoreTableFooterDelegate,EGORefreshTableHeaderDelegate,NSURLConnectionDataDelegate,UISearchBarDelegate,ASIHTTPRequestDelegate, PassValueDelegate>{
    UITableView* _tableView;
    NSInteger _currentSection;
    NSInteger _currentRow;
    int c;//控制页数的
    BOOL reloading;//更新
     LoadMoreTableFooterView *loadMoreFooterVIew;//上提显示更多的对象
    EGORefreshTableHeaderView *refreshHeaderView;//下拉刷新对象
    BOOL IsImage; //
    int height;//判断机型 设置高度
}
@property(nonatomic, retain) NSMutableArray* headViewArray;
@property(nonatomic, retain) UITableView* tableView;//显示公告的tabel
@property(nonatomic, retain)NSMutableArray *message;//小区公告信息
@property(nonatomic,retain)UISearchBar *search;//显示所选的地址
@property(nonatomic,retain)NSMutableArray *array;//显示城市数组
@property(nonatomic,retain)NSMutableArray *arraycoumy;//显示城市区数组
@property(nonatomic,retain)NSMutableArray *Community;//存放社区名字
@property(nonatomic,retain) UIActivityIndicatorView *activityViewLoad;//活动指示器
@property(nonatomic,retain)	DDList	*ddList;//搜索条时出现的小tableview
@property (nonatomic, copy)NSString *searchStr;//存信息
@property(nonatomic,retain)NSMutableArray *Mycommunity;//存搜索的小区介绍列表；
@property(nonatomic,retain)UITableView *searchTable;//搜索后显示的小区公告
- (void)setDDListHidden:(BOOL)hidden;

@end
