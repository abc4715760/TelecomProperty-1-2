//
//  LoginViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredUsersViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
  _field=nil;
   _fieldMI=nil;
  _butpass=nil;
   _loginback=nil;
}
-(void)backaction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
//记忆密码
-(void)passwordaction:(id)sender
{
    DRUserDefaultsManager *manager=[DRUserDefaultsManager sharedUserDefaultsManager];
    [manager setUserID:_field.text];
    if (_ispasswold) {
        _ispasswold=NO;
        _butpass.selected=NO;
        NSNumber *ispass=[NSNumber numberWithBool:_ispasswold];
        [manager setIsRememberPassword:ispass];//把按钮的状态存到本地文件里 用于判断
        [manager setUserPassword:NULL];// 存一个空值覆盖原来的密码
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:NULL forKey:@"userID"];
        [defaults setObject:NULL forKey:@"passwad"];
        [defaults synchronize];
        [_butpass setBackgroundImage:[UIImage imageNamed:@"btn_check_off.png"] forState:UIControlStateNormal];
    }else{
        _ispasswold=YES;
        _butpass.selected=YES;
        NSNumber *ispass=[NSNumber numberWithBool:_ispasswold];
        [manager setIsRememberPassword:ispass];//存按钮状态
        [manager setUserPassword:_fieldMI.text]; //存密码
        [_butpass setBackgroundImage:[UIImage imageNamed:@"btn_check_on.png"] forState:UIControlStateSelected];
    }

}
//注册
-(void)registeredaction:(id)sender
{
    /*
    RegisteredUsersViewController *registeredUsers=[[RegisteredUsersViewController alloc]init];
    [self presentModalViewController:registeredUsers animated:YES]; */
  NewUserViewController *NewUser=[[NewUserViewController alloc]init];
   [self presentViewController:NewUser animated:YES completion:^{
       }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
      //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
        backImage.frame=CGRectMake(0,0, 320, self.view.bounds.size.height);
       [self.view addSubview:backImage];
    [backImage release];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    [navigation release];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"用户登陆";
    username.textColor=[UIColor whiteColor];
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    [username release];
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    but.titleLabel.font=[UIFont systemFontOfSize:15.f];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIImageView *tabar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar.png"]];
    tabar.frame=CGRectMake(0, self.view.bounds.size.height-44, 320, 44);
    tabar.userInteractionEnabled=YES;
    [self.view addSubview:tabar];
    [tabar release];
   
    _loginback=[[UIImageView alloc]initWithFrame:CGRectMake(20,50, 320-40,130)];
    _loginback.userInteractionEnabled=YES;
    _loginback.image=[UIImage imageNamed:@"背景图4.png"];
    [self.view addSubview:_loginback];
    
    UIImageView *loginback3=[[UIImageView alloc]initWithFrame:CGRectMake(117-40,55+10,155, 30)];
    loginback3.image=[UIImage imageNamed:@"号码.png"];
    [self.view addSubview:loginback3];
    [loginback3 release];
    
    UILabel *number=[[UILabel alloc]initWithFrame:CGRectMake(70-40,55+10,40, 30)];
    number.text=@"账号";
    number.backgroundColor=[UIColor clearColor];
    [self.view addSubview:number];
    [number release];
    _field=[[UITextField alloc]initWithFrame:CGRectMake(120-40,60+10,155, 30)];
    _field.placeholder=@"输入注册账号";
    [_field becomeFirstResponder];
    _field.returnKeyType=UIReturnKeyNext;
    _field.delegate=self;
    _field.keyboardType=UIKeyboardTypePhonePad;
    [self.view addSubview:_field];
    UIImageView *loginback4=[[UIImageView alloc]initWithFrame:CGRectMake(117-40,100+10,155, 30)];
    loginback4.image=[UIImage imageNamed:@"号码.png"];
    [self.view addSubview:loginback4];
    [loginback4 release];
    UILabel *number1=[[UILabel alloc]initWithFrame:CGRectMake(70-40,100+10,40, 30)];
    number1.text=@"密码";
    number1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:number1];
    [number1 release];
    _fieldMI=[[UITextField alloc]initWithFrame:CGRectMake(120-40,105+10, 155, 30)];
    _fieldMI.placeholder=@"输入密码";
    _fieldMI.delegate=self;
    //_fieldMI.text=@"123456";
    _fieldMI.secureTextEntry=YES;
    _fieldMI.inputAccessoryView=[self huishou];
    _fieldMI.returnKeyType=UIReturnKeyDone;
   // _fieldMI.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:_fieldMI];
    /*
     ========
     */
    DRUserDefaultsManager *manager=[[DRUserDefaultsManager alloc]init];
    _fieldMI.text=[manager userPassword]; //取密码
    if ([[manager userID]intValue]==0) {
        _field.text=nil;//取回存到本地的用户名 开始默认存了零需要覆盖空
    }else{
    _field.text=[manager userID];//取回存到本地的用户名
    }

    UILabel *autopasswold=[[UILabel alloc]initWithFrame:CGRectMake(120-40,130+10,80,40)];
    autopasswold.text=@"记住密码";
    autopasswold.textAlignment=NSTextAlignmentCenter;
    autopasswold.backgroundColor=[UIColor clearColor];
    autopasswold.font=[UIFont systemFontOfSize:14.0f];
    [self.view addSubview:autopasswold];
    [autopasswold release];
    _butpass=[UIButton buttonWithType:UIButtonTypeCustom];
    _butpass.frame=CGRectMake(110-40, 140+10, 20, 20);
    _ispasswold=[DRUserDefaultsManager sharedUserDefaultsManager].isRememberPassword.boolValue;  //取回存到本地的按钮状态 
    if (_ispasswold) {
        _butpass.selected=YES;
        [_butpass setBackgroundImage:[UIImage imageNamed:@"btn_check_on.png"] forState:UIControlStateSelected];
    }else{
        _butpass.selected=NO;
        [_butpass setBackgroundImage:[UIImage imageNamed:@"btn_check_off.png"] forState:UIControlStateNormal];
    }
    [_butpass addTarget:self action:@selector(passwordaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_butpass];
    //label
    AttributedLabel *forgetpasswold=[[AttributedLabel alloc]initWithFrame:CGRectMake(120+60,130+20,80,40)];
    forgetpasswold.text=@"忘记密码";
    [self.view addSubview:forgetpasswold];
    [forgetpasswold setColor:[UIColor redColor] fromIndex:0 length:4];
    forgetpasswold.backgroundColor=[UIColor clearColor];
    [forgetpasswold setStyle:kCTUnderlineStyleSingle fromIndex:0 length:4];
    forgetpasswold.font=[UIFont systemFontOfSize:14.0f];
    
    UIButton *loginButton=[UIButton buttonWithType:0];
    loginButton.frame=CGRectMake(320-60,6 ,60,30);
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    loginButton.titleLabel.font=[UIFont systemFontOfSize:15.f];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginrequeset) forControlEvents:UIControlEventTouchUpInside];
     [loginButton setBackgroundImage:[UIImage imageNamed:@"按钮右.png"] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    UIButton *registeredButton=[UIButton buttonWithType:0];
    registeredButton.frame=CGRectMake(10,160+20 ,300 ,40);
    [registeredButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registeredButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registeredButton setBackgroundImage:[UIImage imageNamed:@"注册按钮.png"] forState:UIControlStateNormal];
    [registeredButton addTarget:self action:@selector(registeredaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeredButton];
 
}
-(UIView *)huishou
{
    //回收键盘
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *Bar2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"jianpan.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(huishouaction)];
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    NSArray *array=[[NSArray alloc]initWithObjects:bar1,Bar2, nil];
    toolbar.items=array;
    toolbar.barStyle=UIBarStyleBlackTranslucent;//透明
    return toolbar ;
}
//登陆请求
-(void)loginrequeset{
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetUserRole"];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:_field.text forKey:@"tell"];
    [PostRequst setPostValue:_fieldMI.text forKey:@"pwd"];
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
}
#pragma mark alertView
-(void)alertviewmessage:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark ASIHTTpRequstDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
     NSString *strData=[[NSString alloc]initWithData:   [request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
    NSNumber* status=[dic objectForKey:@"status"];
    if ([status intValue]==0) {
           [self alertviewmessage:@"账号不存在或密码不正确"];
        NSLog(@"账号不存在或密码不正确");
    }else{
        /*
         存用户信息*/
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *firstName=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"userindex"]];
        [defaults setObject:firstName forKey:@"firstName"];
        if (!_butpass.selected) {
             NSLog(@"Data saved%@", [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"userindex"]]);
        }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_field.text forKey:@"userID"];
        [defaults setObject:_fieldMI.text forKey:@"passwad"];
        [defaults synchronize];
            NSLog(@"Data saved%@", [dic objectForKey:@"data"]);
        }
        [self.delegate userinformation: [dic objectForKey:@"data"]andselectde:@"1"];
        NSLog(@"登陆成功");
        
        [self  dismissModalViewControllerAnimated:YES];
    }
    }else{
       NSLog(@"返回数据问题");
    }

}
-(void)requestFailed:(ASIHTTPRequest *)request
{

}
#pragma mark  --huishoujianpan--
-(void)huishouaction
{
    [_fieldMI resignFirstResponder];

}
#pragma mark textFIelddelgate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        [self loginrequeset];//登陆
        [self huishouaction];//回收键盘
    }
    return YES;
}
//将要开始编辑进的代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    //添加动画
//    [UIView animateWithDuration:0.4 animations:^{
//        _loginback.frame=CGRectMake(_loginback.frame.origin.x,100-50-10, _loginback.frame.size.width,_loginback.frame.size.height);
//    }];
    return YES;
}
#pragma mark =====
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
