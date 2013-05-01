//
//  MyProfileViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTImage.h"
#import "JSON.h"
#import "UrlAddress.h"
#import "AsyncImageView.h"
@interface MyProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,EncapsupationDelegate,UIAlertViewDelegate,EncapsupationDelegate>{

    int Myinfo;//控制修改哪个信息
}
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)NSMutableArray *ArrayTable;
@property(nonatomic,retain)AsyncImageView *userimage;
@property(nonatomic,retain)UIImageView *imageV;
@property (nonatomic, strong) MBProgressHUD *progressBox;
@end
