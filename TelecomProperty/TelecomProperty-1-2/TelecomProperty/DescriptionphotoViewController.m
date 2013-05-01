//
//  DescriptionphotoViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-28.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "DescriptionphotoViewController.h"

@interface DescriptionphotoViewController ()
{
    NSMutableData *Data;
    
}
@property(nonatomic,retain)MBProgressHUD * progressBox;
@end

@implementation DescriptionphotoViewController

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
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0,0, 320,self.view.bounds.size.height);
    [self.view addSubview:backImage];
    [backImage release];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    [self.view addSubview:navigation];
    [navigation release];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"发布实景";
    username.textColor=[UIColor whiteColor];
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    [username release];
//
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *upload=[UIButton buttonWithType:0];
    upload.frame=CGRectMake(320-60, 6, 60, 30);
    [upload setTitle:@"确定" forState:UIControlStateNormal];
    [upload setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [upload setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    [upload addTarget:self action:@selector(tapuserimageaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upload];

    UIImageView *sendphoto=[[UIImageView alloc]init];
   sendphoto.image=_photo;
    [self.view addSubview:sendphoto];
    sendphoto.frame=CGRectMake(0, 44,300,self.view.bounds.size.height-140);
    
    _sendinfo=[[CPTextViewPlaceholder alloc]initWithFrame:CGRectMake(5, 44+sendphoto.frame.size.height, 300, 100)];
    _sendinfo.placeholder=@"说点什么吧";
    _sendinfo.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _sendinfo.font = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    [self.view addSubview:_sendinfo];
}
-(void)tapuserimageaction:(id)sender
{
    [self requestImage:_photo];
    _progressBox = [[MBProgressHUD alloc] initWithView:self.view];
    [_progressBox setYOffset:-50];
    _progressBox.dimBackground = YES;//将view放入后台
    [self.view addSubview:_progressBox];
    //        3、开始旋转，例如你正在请求时
    [_progressBox setLabelText:@"正在加载"];
    [_progressBox show:YES];
}
-(void)requestImage :(UIImage*)image //上传图片
{
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSString *url=@"http://222.247.37.152/WebUpImage.aspx";
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *myImage=_photo;
    //得到图片的data
    
    NSData* data =UIImageJPEGRepresentation(myImage, 0.1);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png

    NSString *userindex=[EncapsulationASI UserIndex];
    [body appendFormat:@"Content-Disposition: form-data; name=\"FileName\"; filename=\"073101010001#%@#正问#%@#.png\"\r\n",userindex,_sendinfo];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"]);
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
    [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    Data=[[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[Data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *strdata=[[NSString alloc]initWithData:Data encoding:NSUTF8StringEncoding];
    NSString *str=[strdata substringToIndex:13];
    NSLog(@"%@",str);
    if ([[str  JSONValue] isKindOfClass:[NSDictionary class]]) {
        if ( [[[str JSONValue] objectForKey:@"status"] intValue]==1) {
            _progressBox.labelText=@"上传完成";
            [self performSelector:@selector(backaction:) withObject:nil afterDelay:2];
        }else{
            _progressBox.labelText=@"上传失败";
        }
    }
    if (_progressBox) {
        [_progressBox hide:YES afterDelay:1];
    }

}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
     _progressBox.labelText=@"上传失败";
      if (_progressBox) {
        [_progressBox hide:YES];
    }


}
-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
