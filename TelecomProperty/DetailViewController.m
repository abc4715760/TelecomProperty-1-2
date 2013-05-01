//
//  DetailViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-17.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        backImage.frame=CGRectMake(0,0, 320, 480);
    }
    else
    {
        backImage.frame=CGRectMake(0,0, 320, 548);
    }

    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"公告详情";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
  
    if (!iphone5) {
        higt=480;
    }else
    {
        higt=568;
    }
    
    UILabel*scroll=[[UILabel alloc]init];
    scroll.frame=CGRectMake(15, 60,320-30, higt-40-88-40);
    scroll.userInteractionEnabled=YES;
    scroll.layer.shadowRadius=30.f;
    scroll.layer.borderWidth=2.f;
   scroll.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    [self.view addSubview:scroll];
    
    _communityLabel=[[UITextView alloc]initWithFrame:CGRectMake(18, 60+40,320-36, higt-126-88)];
    _communityLabel.text=[NSString stringWithFormat:@"%@",_DetailsubtitlStr];
    _communityLabel.font=[UIFont systemFontOfSize:14.f];
    _communityLabel.textAlignment=UITextAlignmentCenter;
    _communityLabel.editable=NO;
   
    [self.view addSubview:_communityLabel];
    UILabel *label=[UILabel new];
    label.backgroundColor=[UIColor clearColor];
    label.text=_titleStr;
    label.frame=CGRectMake(0, 60, 320, 30);
    label.font=[UIFont systemFontOfSize:18];
    label.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:label];
    [backImage release];
    [navigation release];
    [username release];
    [label release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
