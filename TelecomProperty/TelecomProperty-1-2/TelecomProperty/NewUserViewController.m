//
//  NewUserViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-9.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "NewUserViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

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
    _numberField=nil;
    _prassField=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if (!iphone5) {
        backImage.frame=CGRectMake(0,0, 320, 480);
    }else{
        backImage.frame=CGRectMake(0, 0, 320, 548);
    }
      [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"用户注册";
    username.textColor=[UIColor whiteColor];
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
     but.titleLabel.font=[UIFont systemFontOfSize:15.f];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    UIButton *completebut=[UIButton buttonWithType:0];
    completebut.frame=CGRectMake(320-65, 6, 60, 30);
    [completebut setTitle:@"注册" forState:UIControlStateNormal];
     completebut.titleLabel.font=[UIFont systemFontOfSize:15.f];
    [completebut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [completebut addTarget:self action:@selector(completeaction:) forControlEvents:UIControlEventTouchUpInside];
    [completebut setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    [self.view addSubview:completebut];
    UILabel *numberID=[[UILabel alloc]initWithFrame:CGRectMake(11,33+50,170 ,30 )];
    numberID.text=@"用户ID";
    numberID.backgroundColor=[UIColor clearColor];
    [self.view addSubview:numberID];
    [backImage release];
    [navigation release];
    [username release];
    _numberField=[[UITextField alloc]initWithFrame:CGRectMake(77, 33+50,170, 30)];
    _numberField.placeholder=@"手机号码";
//    _numberField.text=@"123456789";
    _numberField.returnKeyType=UIReturnKeyNext;
    _numberField.delegate=self;
    [_numberField becomeFirstResponder];
    _numberField.keyboardType=UIKeyboardTypePhonePad;
    _numberField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:_numberField];
    
    UILabel *prass=[[UILabel alloc]initWithFrame:CGRectMake(30, 78+50, 40, 30)];
    prass.text=@"密码";
    prass.backgroundColor=[UIColor clearColor];
    [self.view addSubview:prass];
    _prassField=[[UITextField alloc]initWithFrame:CGRectMake(77,78+50,170, 30)];
    _prassField.placeholder=@"密码";
    _prassField.returnKeyType=UIReturnKeyGo;
    _prassField.delegate=self;
//    _prassField.text=@"123456789";
    _prassField.secureTextEntry=YES;//密码安全
    _prassField.keyboardType=UIKeyboardTypeDefault;
    _prassField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:_prassField];
   
}
-(void)backaction:(id)sender
{
  
//    http://58.20.32.202:8090/InfoManage/InsertService.asmx?op=InsertUser
    [self dismissModalViewControllerAnimated:YES];
}
#pragma  mark ASIhttpdelegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"dddd");
//失败进入改代理
}
-(void)alertviewmessage:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *strData=[[NSString alloc]initWithData:   [request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary *dic=[strData JSONValue];
     if ([dic isKindOfClass:[NSDictionary class]] ) {
    NSNumber* status=[dic objectForKey:@"status"];
    NSLog(@"%@==",dic);
    if ([status intValue]==0||[status intValue]==9) {
        [self alertviewmessage:@"账号存在或输入有误"];
        NSLog(@"账号存在或输入有误");
    }else{
//        DRUserDefaultsManager *manager=[DRUserDefaultsManager sharedUserDefaultsManager];
//        NSNumber *ispass=[NSNumber numberWithBool:YES];
//        [manager setIsRememberPassword:ispass];//存按钮状态
//        [manager setUserPassword:_prassField.text]; //存密码
//        [manager setUserID:_numberField.text];
      [self dismissModalViewControllerAnimated:YES];
        NSLog(@"注册成功");
    }
     }else{
         NSLog(@"返回数据问题");
     }
 
}
//验证号码
+(BOOL)setpredicate:(NSString *)sender
{
    NSString *match=@"^\\d{11,12}$";//注意\d正则法则在OC中表达式\\d
    NSPredicate *result=[NSPredicate predicateWithFormat:@"SELF matches %@",match];//用谓词过滤
    return [result evaluateWithObject:sender];//用通过谓词对象 判断传进来的参数是否符合 是BOOL值
}
-(void)completeaction:(id)sender
{
//    if (![NewUserViewController setpredicate:_numberField.text] ){
//        [self alertviewmessage:@"请输入11或12位的手机账号"];}
// if(_prassField.text.length<=0){
//        [self  alertviewmessage:@"请输入密码"];
//    }else{
  
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/InsertService.asmx/InsertUser"];
    ASIFormDataRequest *ASIForm=[[ASIFormDataRequest alloc]initWithURL:url];
    [ASIForm setPostValue:_numberField.text forKey:@"telephone"];
    [ASIForm setPostValue:_prassField.text forKey:@"PassWord"];
    ASIForm.delegate=self;
    [ASIForm startAsynchronous];
//  }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
