//
//  GarageViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-17.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreViewController.h"
@interface GarageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(retain,nonatomic)UITableView *table;
@property(retain,nonatomic)NSMutableArray *mutableArray;
@end
