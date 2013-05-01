//
//  CommunityListViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-22.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlAddress.h"
#import "JSON.h"
#import "LoginViewController.h"

@interface CommunityListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EncapsupationDelegate,UIAlertViewDelegate,UISearchBarDelegate>{
    EncapsulationASI *encapsulation;
}
@property(nonatomic,retain)UrlAddress *communityobject;//小区对象
@property(nonatomic,retain)UITableView *table;//显示小区列表的视图
@property(nonatomic,retain)NSMutableArray *Community;//小区名字数据
@property(nonatomic,retain)NSString *groupindex;//小区ID
@property(nonatomic,retain)UISearchBar *search;
@property (nonatomic,retain) NSMutableDictionary * SectionDict ;//对象对应的首字母排好的须的字典
@property (nonatomic,retain) NSMutableArray * SectionMutableAry;//存中文名字的对象人首字母

@end
