//
//  InformDetailsViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-20.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "InformDetailsViewController.h"

@interface InformDetailsViewController ()

@end

@implementation InformDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)backaction:(id)sender
{
    
    //    UIApplication *app = [UIApplication sharedApplication];
    //    NSURL *url = [NSURL URLWithString:@"myapp://scenerytest"];
    ////
    //    if ([app  canOpenURL:url]) {  //同样的道理，利用 UIApplication 类的  - (BOOL)canOpenURL:(NSURL *)url 成员方法可以判断是否能启动应用B；
    //
    //        [app openURL:url];
    //        NSLog(@"can  launch B app!");
    //
    //    }else {
    //
    //        NSLog(@"can not launch B app!");
    //    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"游客您好";
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
   
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,44,320, 44)];
    label.text=[_Notife objectForKey:@"titleinfo"];
    label.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:label];
    UITextView *ContentView=[[UITextView alloc]initWithFrame:CGRectMake(20, 100,280,300)];
    ContentView.editable=NO;
    ContentView.text=[_Notife objectForKey:@"sendifo"];
    ContentView.font=[UIFont systemFontOfSize:16.f];
        [self.view addSubview:ContentView];
      
    UIButton * leftbut=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [leftbut setTitle:@"上一条" forState:UIControlStateNormal];
    leftbut.alpha=0.8;//透明
    leftbut.frame=CGRectMake(0,self.view.center.y-20,80, 40);
//   [leftbut addTarget:self action:@selector(leftaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftbut];
    
    UIButton * rightbut=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightbut setTitle:@"下一条" forState:UIControlStateNormal];
    rightbut.frame=CGRectMake(320-80,self.view.center.y-20,80, 40);
    rightbut.alpha=0.7;//透明
//    [rightbut addTarget:self action:@selector(rightaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightbut];
    [backImage release];
    [navigation release];
    [username release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
