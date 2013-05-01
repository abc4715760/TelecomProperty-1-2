//
//  CommunityViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CusotomViewController.h"
@interface CommunityViewController : UIViewController<NSURLConnectionDataDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>
@property(nonatomic,retain)UITableView *Tablecommunity;//小区信息展示
@property(nonatomic,retain)NSMutableArray *Arraycommunity;//存小区信息
@property(nonatomic,retain)UITableView *TableGoodfriend;//好友信息展示
//@property(nonatomic,retain)UITableView *tablegroup;//群组信息展示
//@property(nonatomic,retain)NSMutableArray *ArrayGroup;//存群组信息
@property(nonatomic,retain)UIScrollView *scrollView;//装三个tableView
@property(nonatomic,retain)NSMutableArray  *MutableArray;//存好友信息

@property(retain,nonatomic)NSMutableDictionary *dictionary;//存k值为首字母的  value 名字 为字典
@property(retain,nonatomic) NSMutableArray *pingfirst;//存排好序的首字母的数组
@property(retain,nonatomic) NSMutableArray *namearray;//存按名字排序 的对象
@property(retain,nonatomic)UITableView *RecentlyTable;//显示最近联系人的视图
@property(retain,nonatomic)NSMutableArray *RecentlyArray;//最近联系人

@property(retain,nonatomic)UIImageView *imageView;//显示随按的按钮位置变化而变化
@property(nonatomic,retain) UIPickerView*picker;//显示
@property(nonatomic,retain)NSMutableDictionary *MutableDict;//存处数据
@property(nonatomic,retain)NSString *strcity;//显示城市里的区
@property(nonatomic,retain)NSString *strcity0;//显示城市
@property(nonatomic,retain)NSString *strcity1;//显示城市 区下的小区
@property(nonatomic,retain)UILabel *lablecommuct;//显示所选的地址
@end
