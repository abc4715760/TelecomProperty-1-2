//
//  MySuggestionViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteView.h"
#import <MessageUI/MessageUI.h>
#import "EncapsulationASI.h"//封装
//#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "UrlAddress.h"
#import "AsyncImageView.h"
@interface MySuggestionViewController : UIViewController<UITextViewDelegate,MFMailComposeViewControllerDelegate,UISearchBarDelegate,EncapsupationDelegate,UITableViewDataSource,UITableViewDelegate>{
    int height;
}
@property(nonatomic,retain)UILabel*  labelword;//显示还能输入多少个字
@property(nonatomic,retain) UIImageView *backImage;
@property(nonatomic,retain) NoteView*textview;//意见输入框
@property(nonatomic,retain)UISearchBar *search;//显示所选的地址
@property(nonatomic,retain)UITableView *searchTable;//搜索后显示的小区
@property(nonatomic,retain) UIActivityIndicatorView *activityViewLoad;//活动指示器
@property(nonatomic,retain)NSMutableArray *Mycommunity;//存搜索的小区介绍列表；
@end
