//
//  MoreViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0,0, self.view.bounds.size.width,self.view.bounds.size.height);
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    [navigation release];
    
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"更多";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame=CGRectMake(0, 44, 320, 44);
    [but setTitle:@"去app Store评分" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(actionAPPID) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    UIButton *Updatebut=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    Updatebut.frame=CGRectMake(0, 44+44, 320, 44);
    [Updatebut setTitle:@"检查版本更新" forState:UIControlStateNormal];
    [Updatebut addTarget:self action:@selector(updateApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Updatebut];
    
  
    UIButton *back=[UIButton buttonWithType:0];
    back.frame=CGRectMake(10, 6, 60, 30);
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];

//    [self requestImage];
//    [self httprequest];
}
-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(NSString *)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:sender delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)autologo:(UIButton*)sender
{
    if (!sender.selected) {
        sender.selected=YES;
        [sender setTitle:@"注销" forState:UIControlStateSelected];
        LoginViewController *login=[LoginViewController new];
        [self presentModalViewController:login animated:YES];
       
    }else{
        sender.selected=NO;
       [sender setTitle:@"登陆" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:NULL forKey: @"firstName"];
        [self alertView:@"注销成功"];

    }
}
-(void)requestImage  //上传图片
{
  
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
     NSString *url=@"http://58.20.32.202:8090/images/left01up.jpg";
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *myImage=[UIImage imageNamed:@"广告条2.png"];
    //得到图片的data
    NSData* data = UIImagePNGRepresentation(myImage);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"FileName\"; filename=\"boris.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
     //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d",[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
     NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",returnData);
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@====",returnString);
    UIImageView  *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 88, 320,88 )];
    image.image=[UIImage imageWithData:returnData];
    [self.view addSubview:image];
    [image release];
}

-(void)httprequest
{
     NSString *url=@"http://192.168.1.110:8080/image.jsp?action=search&stype=p2p";
    NSURL *URL = [NSURL URLWithString:url];
    ASIFormDataRequest *Request = [ASIFormDataRequest requestWithURL:URL];
    [Request setRequestMethod:@"POST"];
    [Request addRequestHeader:@"Content-Type"value:@"application/json"];
    [Request setTimeOutSeconds:60];
    UIImage *myImage=[UIImage imageNamed:@"广告条2.png"];
    [Request setData:UIImagePNGRepresentation(myImage)forKey:@"file"];
    [Request setDelegate:self];
    [Request setCompletionBlock:^{
//        NSString *responseString = [Request responseString];
//NSLog(@"Response: %@====", responseString);
    }];
    [Request setFailedBlock:^{
//        NSError *error = [Request error];
//        NSLog(@"Error: %@,==%@", error.localizedDescription,Request.url);
    }];
    [Request startSynchronous];
}
//更新版本
-
(void)updateApp
{
   [Harpy checkVersionupdate:NO];
}
//去app strot评分
-(void)actionAPPID
{
   //  iTunes connect里的APPLE　ID在添加完一个应用之后就有了
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/tw/app/id596633232"]]];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    UIButton *autologo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    autologo.frame=CGRectMake(0, 44+44+44, 320, 44);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"]) {
        autologo.selected=YES;
    }else
    {
        autologo.selected=NO;
    }
    [autologo setTitle:@"注销" forState:UIControlStateSelected];
    [autologo setTitle:@"登陆" forState:UIControlStateNormal];
    [autologo addTarget:self action:@selector(autologo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autologo];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
