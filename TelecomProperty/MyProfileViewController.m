//
//  MyProfileViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController (){
    NSMutableData *Data;
}
@end

@implementation MyProfileViewController

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
    _ArrayTable=nil;
    _userimage=nil;
    _table=nil;
    [_table release];
    [_ArrayTable release];
    _progressBox=nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0,0, 320, self.view.bounds.size.height);
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"我的个人资料";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor]; 
    username.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    _userimage=[[AsyncImageView alloc]initWithFrame:CGRectMake(15,44+10, 80, 80)];
    _userimage.userInteractionEnabled=YES;
    [self.view addSubview:_userimage];
    _imageV=[UIImageView new];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapuserimageaction:)];
    tap.numberOfTapsRequired=1;
    [_userimage addGestureRecognizer:tap];
    [tap release];
 
    UIButton*userlabel=[UIButton buttonWithType:0];
    userlabel.frame =CGRectMake(139,44, 100,40);
   userlabel.titleLabel.text=@"姓名:王默默";
    [userlabel setTitle:userlabel.titleLabel.text forState:UIControlStateNormal];
    [userlabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [userlabel addTarget:self action:@selector(userlabelaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:userlabel];

    UIButton*addressl=[UIButton buttonWithType:0];
    addressl.frame =CGRectMake(139, 90, 60+80, 60);
    addressl.titleLabel.text=@"地址:长沙芙蓉区牧民服务区";
    addressl.titleLabel.numberOfLines=0;
    [addressl setTitle:addressl.titleLabel.text forState:UIControlStateNormal];
    [addressl setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addressl addTarget:self action:@selector(addresslaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressl];
	
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0,_userimage.frame.origin.y+_userimage.frame.size.height+20, 320,self.view.bounds.size.height-180)   style:UITableViewStyleGrouped];
    _table.dataSource=self;
    _table.delegate=self;
    _table.backgroundView=[UIView new];
    _table.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_table];
    [navigation release];
    [backImage release];
    [self selectuserinfo];//发送请求获取用户的个人资料
}
-(void)selectuserinfo
{
          /*  获取用户的userindex*/
    EncapsulationASI *asi=[EncapsulationASI new];
    asi.delegate=self;
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    NSLog(@"%@==",str);
    [asi startRequstASIurl:@"InfoManage/SelectService.asmx/GetUserInfo" andgroupindex:nil andsendinfo:nil userindex:str addinfo:@"req1" andsitecode:nil];
}

#pragma mark requestASI
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    NSDictionary *dic=[strData  JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
        if ([userinfo isEqualToString:@"req1"]) {
            _ArrayTable=[NSMutableArray new];
            NSString *status=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
            if ([status intValue]==1) {
                NSDictionary*dictionary=[[dic objectForKey:@"data"] objectAtIndex:0];
                NSLog(@"dic==%@",dictionary);
                UrlAddress *url=[[UrlAddress alloc]init];
                url.imageurl=[dictionary objectForKey:@"imageurl"];
                url. nickname=[dictionary objectForKey:@"nickname"];//[昵称]
                url. signinfo=[dictionary objectForKey:@"signinfo"];//[个性签名],
                url. realname=[dictionary objectForKey:@"realname"];//[真实姓名]
                url. sexuality=[dictionary objectForKey:@"sexuality"];//[性别],
                url.birthday=[dictionary objectForKey:@"birthday"];//[生日],
                url. age=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"age"]];//[年龄],
                url.bornanimal=[dictionary objectForKey:@"bornanimal"];//[生肖],
                url.constellation=[dictionary objectForKey:@"constellation"];//[星座],
                url.bloodtype=[dictionary objectForKey:@"bloodtype"];//[血型],
                url.job=[dictionary objectForKey:@"job'"];//[从事职业]
                url.mailbox=[dictionary objectForKey:@"mailbox"];//[邮箱]
                url.location=[dictionary objectForKey:@"locaton"];//现居住地址
                [_ArrayTable addObject:url];
                if ([dictionary objectForKey:@"imageurl"]) {
                    _userimage.urlString=[dictionary objectForKey:@"imageurl"];
                }else{
                _userimage.image=[UIImage imageNamed:@"myimage.png"];
                }
                NSLog(@"%d",[_ArrayTable count]);
            }else{
                NSLog(@"没数据");
                _table.userInteractionEnabled=NO;
                [EncapsulationASI alertView:nil andmessage:@"该用户质料没有数据"];
            }

        }else if ([userinfo isEqualToString:@"req2"]){
            NSLog(@"%@",dic);
            if ([[dic objectForKey:@"status"] intValue]==1) {
                [self selectuserinfo];
            }else{
                [EncapsulationASI alertView:nil andmessage:@"修改失败"];}
        }
            
    }
    [_table reloadData];
}

//修改姓名
-(void)userlabelaction:(id)sender
{
    [self alertview];
}
-(void)alertview{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"该项不允许修改" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}
//修改地址
-(void)addresslaction:(id)sender
{
    [self alertview];
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
    if (buttonIndex==0) {
        [self fromPhotoes];
    }else if(buttonIndex==1){
        [self fromcamare:nil];
    }
}
-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
 
    
}
#pragma mark  相册
-(void)fromPhotoes//相册
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//判断设备是否支持相册功能
    {
        UIImagePickerController *imagePickerC=[[UIImagePickerController alloc]init];
        //    imagePickerC.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary; //
        imagePickerC.allowsEditing=YES;//是否对图片进行编辑
        imagePickerC.delegate=self;
           [self performSelector:@selector(performView:) withObject:imagePickerC afterDelay:0]; 
     
    }else{
        [self alertaction:@"该设备不支持相册"];
    }
    
}
-(void)performView:(UIImagePickerController*)imagePickerC
{
    [self presentViewController:imagePickerC animated:YES completion:^{
        
    } ];//推出照片选择的页面
}
-(void)alertaction:(NSString *)sender{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:sender delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//回调方法：当选择一个照片后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    [picker dismissViewControllerAnimated:YES completion:^{
        
//        [NSThread detachNewThreadSelector:@selector(requestImage:) toTarget:self withObject:[info valueForKey:@"UIImagePickerControllerOriginalImage"]];//分一条线程
        if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
            [self requestImage:[info valueForKey:UIImagePickerControllerEditedImage]];
            
        }else{
            [self requestImage:[info valueForKey:UIImagePickerControllerOriginalImage]];
            
        }
    }]; //关闭照片选择页面
}
#pragma mark =======
//回调方法：当取消选择照片后调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark ===loadImge
-(void)requestImage:(UIImage*)image  //上传图片
{
    _progressBox = [[MBProgressHUD alloc] initWithView:self.view];
    [_progressBox setYOffset:-50];
    _progressBox.dimBackground = YES;//将view放入后台
    [self.view addSubview:_progressBox];
    //        3、开始旋转，例如你正在请求时
    [_progressBox setLabelText:@"正在加载"];
    [_progressBox show:YES];

    _imageV.image=[RTImage ImageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width,image.size.height)];
  //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSString *url=@"http://222.247.37.152/WebUserImage.aspx";
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *myImage=_imageV.image;
    //得到图片的data
    NSData* data = UIImageJPEGRepresentation(myImage, 0.5);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    NSString *userID=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    [body appendFormat:@"Content-Disposition: form-data; name=\"FileName\"; filename=\"%@#.png\"\r\n",userID];
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
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSLog(@"%@",returnData);
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@====",returnString);
     [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
   
}
-(void)httprequest
{
//    NSLog(@"hhyhhhhhh");
    NSString *url=@"http://222.247.37.152/WebUserImage.aspx";
    NSURL *URL = [NSURL URLWithString:url];
    ASIFormDataRequest *Request = [ASIFormDataRequest requestWithURL:URL];
    [Request setRequestMethod:@"POST"];
    [Request addRequestHeader:@"Content-Type"value:@"application/json"];
    [Request setTimeOutSeconds:60];
    UIImage *myImage=[UIImage imageNamed:@"myimage.png"];
    NSString *userID=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    [Request setData:UIImagePNGRepresentation(myImage)forKey:[NSString stringWithFormat:@"%@#.png",userID]];
    [Request setDelegate:self];
    [Request setCompletionBlock:^{
          NSString *responseString = [Request responseString];
          NSLog(@"Response: %@====", responseString);
    }];
    [Request setFailedBlock:^{
        NSError *error = [Request error];
           NSLog(@"Error: %@,==%@", error.localizedDescription,Request.url);
    }];
    [Request startSynchronous];
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
    if ([[str  JSONValue] isKindOfClass:[NSDictionary class]]) {
          if ( [[[str JSONValue] objectForKey:@"status"] intValue]==1) {
            _progressBox.labelText=@"更新完成";
               _userimage.image=_imageV.image;
       }else{
         _progressBox.labelText=@"更新失败";
        }
            }
    if (_progressBox) {
            [_progressBox hide:YES afterDelay:1];
    }
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
       if (_progressBox) {
           _progressBox.labelText=@"失败";
       [_progressBox hide:YES afterDelay:1];
        
       }
   
}

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
#pragma mark ==tableviewdata==
//设置每块section的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"基本信息"];
}
#pragma mark 数据源代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//有多少块
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;//返回多少行
    
}
-(void)makeSubCell:(UITableViewCell *)aCell withTitle:(NSString *)title
             value:(NSString*)value withimage:(UIImage*)image
{
    //显示固定 标示信息
    CGRect tRect = CGRectMake(30,10,110,40);
    UILabel* lbl = [[UILabel alloc] initWithFrame:tRect]; //此处使用id定义任何控件对象
    [lbl setText:title];
    lbl.font=[UIFont systemFontOfSize:15];
    [lbl setBackgroundColor:[UIColor clearColor]];
    //显示内容
    UILabel * edtPassword = [[UILabel alloc] initWithFrame:CGRectMake(150,10,320-150,40)];
    [edtPassword setText:value];
    //    NSLog(@"%@",value);
    edtPassword.font=[UIFont systemFontOfSize:14];
    [edtPassword setBackgroundColor:[UIColor clearColor]];
    //显示图片
//    UIImageView *imagv=[[UIImageView alloc]initWithFrame:CGRectMake(10,15,15,15)];
//    imagv.image=image;
//    [aCell addSubview:imagv];
    [aCell addSubview:lbl];
    [aCell addSubview:edtPassword];
    
    [lbl release];
    [edtPassword release];
    
}
//函数二 表格控制函数
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *SimpleTableIdentifier = @"Simple";

    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell==nil) {
        cell= [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:nil] autorelease];
    }

    UrlAddress *url=((UrlAddress *)[_ArrayTable objectAtIndex:0]);
    if (indexPath.row==0) {
       
        [self makeSubCell:cell withTitle:@"昵称" value:url.nickname withimage:nil];
    }
    else if(indexPath.row==1)
    {
       
        [self makeSubCell:cell withTitle:@"性别" value:url. sexuality  withimage:nil];
    }
    else if (indexPath.row==2)
    {
        [self makeSubCell:cell withTitle:@"生日" value:url.birthday withimage:nil];
    }
    else if (indexPath.row==3)
    {
        [self makeSubCell:cell withTitle:@"年龄" value:url.age withimage:nil];
    }
    else if(indexPath.row==4){
        [self makeSubCell:cell withTitle:@"生肖" value:url.bornanimal withimage:nil];
    }
    
    else if (indexPath.row==5)
    {
        [self makeSubCell:cell withTitle:@"星座" value:url.constellation withimage:nil];
    }

    else if (indexPath.row==6)
    {
        [self makeSubCell:cell withTitle:@"血型" value:url.bloodtype withimage:nil];
    }
    else if (indexPath.row==7)
    {
        [self makeSubCell:cell withTitle:@"从事职业" value:url.job withimage:nil];
    }
    
   else if (indexPath.row==8)
    {
        [self makeSubCell:cell withTitle:@"邮箱" value:url.mailbox withimage:nil];
    }

    else if (indexPath.row==9)
    {
        [self makeSubCell:cell withTitle:@"个性签名" value:url.signinfo withimage:nil];
    }
//
//    else if (indexPath.row==10)
//    {
//        [self makeSubCell:cell withTitle:@"注册人电话" value:@"" withimage:nil];
//    }

    return cell;
}
//选中哪行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        [self alertViewtitle:@"修改昵称" submessage:@""];
        Myinfo=1;
    }
      else if(indexPath.row==1)
    {
        Myinfo=2;
          [self alertViewtitle:@"性别" submessage:@""];
    
    }
    else if (indexPath.row==2)
    {
        Myinfo=3;
          [self alertViewtitle:@"生日" submessage:@""];
      
    }
    else if (indexPath.row==3)
    {
        Myinfo=4;
          [self alertViewtitle:@"年龄" submessage:@""];
      
    }
    else if(indexPath.row==4){
        Myinfo=5;
        
          [self alertViewtitle:@"生肖" submessage:@""];
     
    }
    else if (indexPath.row==5)
    {
        Myinfo=6;
          [self alertViewtitle:@"星座" submessage:@""];
       
    }
    else if (indexPath.row==6)
    {
        Myinfo=7;
          [self alertViewtitle:@"血型" submessage:@""];
        
    }
    else if (indexPath.row==7)
    {
        Myinfo=8;
          [self alertViewtitle:@"从事职业" submessage:@""];
        
    }
    
    else if (indexPath.row==8)
    {
        Myinfo=9;
          [self alertViewtitle:@"邮箱" submessage:@""];
        
    }
    
    else if (indexPath.row==9)
    {
        Myinfo=10;
          [self alertViewtitle:@"个性签名" submessage:@""];

    }
     NSLog(@"%d",indexPath.row);
}
-(void)alertViewtitle:(NSString *)title submessage:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    alert.tag=1;
    [alert show];
    [alert release];
}
#pragma mark alertdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        if (buttonIndex==1) {
             [self MyinsertCommunity:[alertView textFieldAtIndex:nil].text];//传送修改的值
        }else  if(buttonIndex==0){
            
        }
    }
}

//用户申请加入小区
-(void)MyinsertCommunity:(NSString *)sender
{
    NSString *userindex=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    NSString *url=[NSString stringWithFormat:@"InfoManage/UpdateService.asmx/UpdateUserInfo"];
    EncapsulationASI *en=[EncapsulationASI new];
    en.delegate=self;
    [en ASIRequstuserindex:userindex andnickname:sender andrealname:@"11" andsexuality:@"" andbirthday:@"" andage:@"" andbornanimal:@"" andconstellation:@"" andbloodtype:@"" andjob:@"" andeducational:@"" andschool:@"" andmailbox:@"" andbirthplace:@"" andlocation:@"" andaddress:@"" andremark:@"" andurl:url anddic:@"req2"andsigninfo:@"1222"];
    /*
userindex=15&nickname=12&realname=11&sexuality=12&birthday=11&age=11&bornanimal=1&constellation=1&bloodtype=1&job=1&educational=1&school=1&mailbox=1&birthplace=1&location=1&address=1&remark=1*/
//    http://222.247.37.152/InfoManage/UpdateService.asmx/UpdateUserInfo?userindex=25&nickname=12&realname=11&sexuality=12&birthday=11&age=11&bornanimal=1&constellation=1&bloodtype=1&job=1&educational=1&school=1&mailbox=1&birthplace=1&location=1&address=1&remark=1&signinfo=1
   }
//取消哪行
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
