//
//  GoodFriendViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodFriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)NSMutableArray *MutableArray;

@property(retain,nonatomic)NSMutableDictionary *dictionary;//存k值为首字母的  value 名字 为字典
@property(retain,nonatomic) NSMutableArray *pingfirst;//存排好序的首字母的数组
@property(retain,nonatomic) NSMutableArray *namearray;//存按名字排序 的对象
@end
