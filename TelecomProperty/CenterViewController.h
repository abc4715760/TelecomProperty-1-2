//
//  CenterViewController.h
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-11.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowView.h"
#import "ImageViewCell.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "RTImage.h"
#import "DescriptionphotoViewController.h"
@interface CenterViewController : UIViewController<WaterFlowViewDelegate,WaterFlowViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ASIHTTPRequestDelegate,MBProgressHUDDelegate,EncapsupationDelegate>
{
//    MBProgressHUD *HUD;
    NSMutableArray *arrayData;
    WaterFlowView *waterFlow;
    int hiegt;
    UILabel *label;
    NSMutableData *Data;
  }

- (void)dataSourceDidLoad;
- (void)dataSourceDidError;
@property(nonatomic,retain)UIImageView *userimage;
@property(nonatomic,retain)UITextView *field;
@end
