//
//  RegisteredUsersViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-16.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "RegisteredUsersViewController.h"

@interface RegisteredUsersViewController ()

@end

@implementation RegisteredUsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)completeaction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
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
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    UIButton *completebut=[UIButton buttonWithType:0];
         completebut.frame=CGRectMake(320-65, 6, 60, 30);
    [completebut setTitle:@"完成" forState:UIControlStateNormal];
    [completebut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [completebut addTarget:self action:@selector(completeaction:) forControlEvents:UIControlEventTouchUpInside];
     [completebut setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    [self.view addSubview:completebut];
    _scrollView=[[UIScrollView alloc]init ];
    if (!iphone5) {
         _scrollView.frame=CGRectMake(0,44,320, 460-44);
    }else
    {
     _scrollView.frame=CGRectMake(0,44,320, 548-44-40);
    }
    _scrollView.scrollEnabled=YES;//是否可以滚动
    _scrollView.indicatorStyle=UIScrollViewIndicatorStyleBlack;//设置滚动条的样式
    
    _scrollView.showsHorizontalScrollIndicator=NO;//显示水平滚动条
    _scrollView.showsVerticalScrollIndicator=YES;//不显示垂直滚动条
    _scrollView.bounces=YES;//滚动超出边界 反弹效果
    _scrollView.pagingEnabled=NO;//是否滚动到subview的边界 这个属性值也是设置划一屏
    _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width,_scrollView.frame.size.width+240);//设置滚动视图的内容大小
    [self.view addSubview:_scrollView];
    
    UILabel *numberID=[[UILabel alloc]initWithFrame:CGRectMake(11,33,170 ,30 )];
    numberID.text=@"用户ID";
    numberID.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:numberID];
    [numberID release];
    _numberField=[[UITextField alloc]initWithFrame:CGRectMake(77, 33,170, 30)];
    _numberField.placeholder=@"手机号码";
    _numberField.returnKeyType=UIReturnKeyNext;
    _numberField.delegate=self;
    _numberField.keyboardType=UIKeyboardTypePhonePad;
    _numberField.borderStyle= UITextBorderStyleRoundedRect;
    [_scrollView addSubview:_numberField];
    
    UILabel *prass=[[UILabel alloc]initWithFrame:CGRectMake(30, 78, 40, 30)];
    prass.text=@"密码";
    prass.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:prass];
    [prass release];
    _prassField=[[UITextField alloc]initWithFrame:CGRectMake(77,78,170, 30)];
    _prassField.placeholder=@"密码";
    _prassField.returnKeyType=UIReturnKeyNext;
    _prassField.delegate=self;
    _prassField.secureTextEntry=YES;//密码安全
    _prassField.keyboardType=UIKeyboardTypeDefault;
    _prassField.borderStyle= UITextBorderStyleRoundedRect;
    [_scrollView addSubview:_prassField];
    
    UILabel *user=[[UILabel alloc]initWithFrame:CGRectMake(30, 125, 40, 30)];
    user.text=@"昵称";
    user.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:user];
    [user release];
    _userField=[[UITextField alloc]initWithFrame:CGRectMake(77,125,170, 30)];
    _userField.placeholder=@"昵称";
    _userField.borderStyle= UITextBorderStyleRoundedRect;
    _userField.returnKeyType=UIReturnKeyNext;
    _userField.delegate=self;
    _userField.keyboardType=UIKeyboardTypeDefault;
    _userField.borderStyle= UITextBorderStyleRoundedRect;
    [_scrollView addSubview:_userField];
    
    UILabel *address=[[UILabel alloc]initWithFrame:CGRectMake(30, 125+91-44, 100, 30)];
    address.backgroundColor=[UIColor clearColor];
    address.text=@"地址";
    [_scrollView addSubview:address];
    [address release];
    _addressField=[[UITextField alloc]initWithFrame:CGRectMake(77,125+91-44,170, 30)];
    _addressField.placeholder=@"小区地址";
    _addressField.returnKeyType=UIReturnKeyNext;
    _addressField.delegate=self;
    _addressField.keyboardType=UIKeyboardTypeDefault;
    _addressField.borderStyle= UITextBorderStyleRoundedRect;
    [_scrollView addSubview:_addressField];
    
    UILabel *good=[[UILabel alloc]initWithFrame:CGRectMake(30, 125+91+47-44, 40, 60)];
    good.backgroundColor=[UIColor clearColor];
    good.text=@"个人\n爱好";
    good.numberOfLines=0;
    [_scrollView addSubview:good];
    [good release];
    _goodView=[[UITextView alloc]initWithFrame:CGRectMake(77,125+91+47-44,170, 60)];
    _goodView.returnKeyType=UIReturnKeyNext;
    _goodView.delegate=self;
    _goodView.keyboardType=UIKeyboardTypeDefault;
    [_scrollView addSubview:_goodView];
    
    
    UILabel *signature=[[UILabel alloc]initWithFrame:CGRectMake(30, 125+91+47+47+30-44, 40, 60)];
    signature.text=@"个人\n签名";
    signature.backgroundColor=[UIColor clearColor];
    signature.numberOfLines=0;
    [_scrollView addSubview:signature];
    [signature release];
    _signatureView=[[UITextView alloc]initWithFrame:CGRectMake(77,125+91+47+47+30-44,170, 60)];
    _signatureView.returnKeyType=UIReturnKeyNext;
    _signatureView.delegate=self;
    _signatureView.keyboardType=UIKeyboardTypeDefault;
    [_scrollView addSubview:_signatureView];
    
    
    UILabel *sex=[[UILabel alloc]initWithFrame:CGRectMake(30, 125+91+47+47+30+75-44, 40, 30)];
    sex.text=@"性别";
    sex.backgroundColor=[UIColor clearColor];
    sex.numberOfLines=0;
    [_scrollView addSubview:sex];
    [sex release];
    _sexField=[[UITextField alloc]initWithFrame:CGRectMake(77,125+91+47+47+30+75-44,60, 30)];
    _sexField.placeholder=@"性别";
    _sexField.delegate=self;
    
    _sexField.returnKeyType=UIReturnKeyDone;
    _sexField.borderStyle= UITextBorderStyleRoundedRect;
    [_scrollView addSubview:_sexField];
    
    _userimage=[[UIImageView alloc]initWithFrame:CGRectMake(30+120, 125+91+47+47+30+75-44, 123, 129)];
    _userimage.image=[UIImage imageNamed:@"myimage"];
    _userimage.userInteractionEnabled=YES;
    [_scrollView addSubview:_userimage];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapuserimageaction:)];
    tap.numberOfTapsRequired=1;
    [_userimage addGestureRecognizer:tap];
    [tap release];
    UIImageView *tabar=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar.png"]];
    if (!iphone5) {
        tabar.frame=CGRectMake(0, 460-44, 320, 44);
    }else{
        tabar.frame=CGRectMake(0, 548-44, 320, 44);
    }
    
    tabar.userInteractionEnabled=YES;
    [self.view addSubview:tabar];
    [backImage release];
    [navigation release];
    [username release];
}
#pragma mark textFieldDeleget
//文字输入时用这个代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])  //判断输入的字符是不是 return键
    {
        if (textField==_prassField) {
            [_prassField resignFirstResponder];
            [_userField becomeFirstResponder];
            //                [_scrollView setContentOffset:CGPointMake(0,50) animated:YES];
        } else if (textField==_userField) {
            [_userField resignFirstResponder];
            [_addressField becomeFirstResponder];
            //                 [_scrollView setContentOffset:CGPointMake(0,100) animated:YES];
        }
        else if (textField==_addressField) {
            [_addressField resignFirstResponder];
            [_goodView becomeFirstResponder];
            //                 [_scrollView setContentOffset:CGPointMake(0,150) animated:YES];
        }
        else if (textField==_sexField) {
            [_sexField resignFirstResponder];
            
        }
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_userField) {
        
        [_scrollView setContentOffset:CGPointMake(0,100) animated:YES];
    }
    else if (textField==_addressField) {
        
        [_scrollView setContentOffset:CGPointMake(0,150) animated:YES];
    }
    else if (textField==_sexField) {
        
        [_scrollView setContentOffset:CGPointMake(0,350) animated:YES];
    }
}
#pragma mark textViewDeleget
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])  //判断输入的字符是不是 return键
    {
        if (textView==_goodView) {
            [_goodView resignFirstResponder];
            [_signatureView becomeFirstResponder];
            [_scrollView setContentOffset:CGPointMake(0,280) animated:YES];
        } else if (textView==_signatureView) {
            [_signatureView resignFirstResponder];
            [_sexField becomeFirstResponder];
            [_scrollView setContentOffset:CGPointMake(0,350) animated:YES];
        }
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if (textView==_goodView) {
        
        [_scrollView setContentOffset:CGPointMake(0,200) animated:YES];
    } else if (textView==_signatureView) {
        
        [_scrollView setContentOffset:CGPointMake(0,280) animated:YES];
    }
    
}

-(void)backaction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)tapuserimageaction:(id)sender
{
    UIActionSheet *Sheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"相册" otherButtonTitles:@"照相", nil];
    [Sheet addButtonWithTitle:@"取消"];
    Sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;//设置样式
    [Sheet   showInView:[UIApplication sharedApplication].keyWindow];
    /*
     注意事项，在开发过程中，发现有时候UIActionSheet的最后一项点击失效，点最后一项的上半区域时有效，这是在特定情况下才会发生，这个场景就是试用了UITabBar的时候才有。解决办法：
     在 showView时这样使用，[actionSheet showInView: [UIApplication sharedApplication].keyWindow];或者[sheet showInView: [AppDelegate sharedDelegate].tabBarController.view];这样就不会发生遮挡现象了。
     */
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"----%d---",buttonIndex);
    if (buttonIndex==0) {
        [self fromPhotoes];
    }else if(buttonIndex==1){
        [self fromcamare:nil];
    }
}
-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"==------");
    
}
#pragma mark  相册
-(void)fromPhotoes//相册
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//判断设备是否支持相册功能
    {
        UIImagePickerController *imagePickerC=[[UIImagePickerController alloc]init];
        //    imagePickerC.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary; //
        //    imagePickerC.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePickerC.allowsEditing=YES;//是否对图片进行编辑
        imagePickerC.delegate=self;
        [self presentViewController:imagePickerC animated:YES completion:^{
            
        } ];//推出照片选择的页面
    }else{
        [self alertaction:@"该设备不支持相册"];
    }
    
}
-(void)alertaction:(NSString *)sender{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:sender delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//回调方法：当选择一个照片后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    _userimage.image=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
     [picker dismissModalViewControllerAnimated:YES]; //关闭照片选择页面
}

//回调方法：当取消选择照片后调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark 相机
-(void)fromcamare:(id)sender{
    
    if ([UIImagePickerController  isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])//判断该机器是否支持相机
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;//照相机源代码
        [self presentModalViewController:picker animated:YES];
        
    }
    else
    {
        [self alertaction:@"该设备无法使用，没有照相机设备"];
        NSLog(@"无法使用，没有照相机设备");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
