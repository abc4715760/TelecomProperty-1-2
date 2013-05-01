//
//  CharacterSetViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "UrlAddress.h"
@interface CharacterSetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EncapsupationDelegate>
@property(nonatomic,retain)UITableView *NoticeTable;//显示通知的视图
@property(nonatomic,retain)NSMutableDictionary * MutableDic;//内容
@end
