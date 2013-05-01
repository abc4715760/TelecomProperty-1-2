//
//  RegisteredUsersViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-16.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteredUsersViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,retain)UIImageView *userimage;
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UITextField *numberField;//用户ID
@property(nonatomic,retain)UITextField *prassField;//密码
@property(nonatomic,retain)UITextField *userField;//昵称
@property(nonatomic,retain)UITextField *addressField;//地址
@property(nonatomic,retain)UITextView *goodView;//爱好
@property(nonatomic,retain)UITextView *signatureView;//个人签名
@property(nonatomic,retain)  UITextField *sexField;//性别
@end
