//
//  ResidentialIntroducedViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-20.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "ResidentialIntroducedViewController.h"

@interface ResidentialIntroducedViewController ()

@end

@implementation ResidentialIntroducedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    _activity=nil;
    _web=nil;
    _strname=nil;
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
    username.text=_strname.groupname;
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
    [backImage release];
    [navigation release];
    [username release];
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0,44,320,460-44)];
    _web.delegate= self;
    [self webViewbounces];//去掉UIWebView的底图 当内容超出视图大小不滚动
    [self.view addSubview:_web];
    
    _activity=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
   _activity.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;////设置显示效果大白
    _activity.color=[UIColor lightTextColor];
    _activity.center=self.view.center;//设置位置在中间
    [self.view addSubview:_activity];//把活动指示器添加到视图上来
   
    [self residential];
}
-(void)webViewbounces{
for (UIView *view in [_web subviews]){
    if ([view isKindOfClass:[UIScrollView class]])
    {
        ((UIScrollView *)view).bounces = NO; //去掉UIWebView的底图 当内容超出视图大小不滚动
        //        [(UIScrollView *)view setShowsVerticalScrollIndicator:NO]; //右侧的滚动
        if ([view isKindOfClass:[UIScrollView class]]){
            for (UIView *shadowView in view.subviews){
                // 上下滚动出边界时的黑色的图片 也就是拖拽后的上下阴影
                if ([shadowView isKindOfClass:[UIImageView class]]){
                    shadowView.hidden = YES;
                }
            }
        }
    }}
}

//或许详情信息
-(void)residential{
EncapsulationASI *asi=[EncapsulationASI new];
NSString *url=@"InfoManage/SelectService.asmx/GetPropertyInfo";
NSString *groupname=_strname.groupindex;
asi.delegate =self;
[asi startRequstASIurl:url andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req1" andsitecode:groupname];
}
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    NSString *stringhtml=nil;
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]]) {
    if ([userinfo isEqualToString:@"req1"]) {
       NSLog(@"%@",[[[dic objectForKey:@"data"]objectAtIndex:0] objectForKey:@"remark"]);
        stringhtml=[[[dic objectForKey:@"data"]objectAtIndex:0] objectForKey:@"remark"];
    }
    }
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152:8080/uploads"];
    [_web loadHTMLString:stringhtml baseURL:url];
}
#pragma mark ==webdelegate
//开始请求下载数据
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activity startAnimating];//开始
}
//将要结束加载数据
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activity stopAnimating];//结束
}
//请求加载数据异常进入该代理
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);//设置代理提示
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
