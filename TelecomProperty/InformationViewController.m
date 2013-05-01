#import "InformationViewController.h"
#import "CharacterSetViewController.h"//个性设置
#import "MySuggestionViewController.h"//我的建议
#import "MyBusinessCardViewController.h"//我的名片
#import "MyDynamicViewController.h"//我的动态
#import "MyProfileViewController.h"//我的质料
#import "CenterViewController.h"//实景
#import "FirstViewController.h"//小区公告
#import "JSON.h"
#import "GasViewController.h"//水电煤缴费
#import "GarageViewController.h"//车库
#import "YellowPagesViewController.h"//黄页
@interface InformationViewController ()

@end

@implementation InformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark ====----
-(void)userinformation:(NSMutableArray *)array andselectde:(NSString *)sender
{
    NSLog(@"%d===",[array count]);
    _IsLogin=sender;
    _MutableArray=array;
    NSLog(@"%@",[[_MutableArray objectAtIndex:0] objectForKey:@"userindex"]);
}
-(void)dealloc
{
    [super dealloc];
    _tabel=nil;
    [_tabel release];
    _scroll=nil;
    [_scroll release];
    _page=nil;
    [_page release];
    _labelGPS=nil;
    [_labelGPS release];
    _IsLogin=nil;
    [_imagenaber release];
    _NoticeInfonumber=nil;
    Arr=nil;
    [Arr release];
    encapsulation=nil;
}
#pragma mark UIGridViewDelgate
-(CGFloat)gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    
    return 80;
}
-(CGFloat)gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return 78;
}
-(NSInteger)numberOfColumnsOfGridView:(UIGridView *)grid
{
    return 4;
}
-(UIGridViewCell *)gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    
    Cell *cell=(Cell *)[grid dequeueReusableCell];
    if (cell==nil) {
        cell=[[Cell alloc]init];
    }
    if (grid==_tabel) {
        if (rowIndex==0&&columnIndex==0){
            cell.label.text=@"小区介绍";
            cell.thumbnail.image=[UIImage imageNamed:@"1-2"];
        }
        else if (rowIndex==0&&columnIndex==1){
            cell.label.text=@"小区公告";
            cell.thumbnail.image=[UIImage imageNamed:@"1-3"];
        }else if (rowIndex==0&&columnIndex==2){
            cell.label.text=@"小区实景";
            cell.thumbnail.image=[UIImage imageNamed:@"1-4"];
        }else if (rowIndex==0&&columnIndex==3){
            cell.label.text=@"小区黄页";
            cell.thumbnail.image=[UIImage imageNamed:@"企业黄页"];
        }
    } else if (grid==_tableView){
        if (rowIndex==0&&columnIndex==0){
            cell.label.text=@"我的通知";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
               NSMutableDictionary *dic=[EncapsulationASI notifictionplist];
            NSMutableArray *array=[[NSMutableArray alloc]init];
            for(int i=0;i<[[dic objectForKey:firstName] count];i++){
                NSString *read=[[[dic objectForKey:firstName]objectAtIndex:i]objectForKey:@"read"];
                if ([read intValue]==0) {
                    [array addObject: dic];
                }
            }
//              NSLog(@"%d==%d==%d",noleading,[_NoticeInfonumber intValue],[array count]);
            if ([_NoticeInfonumber intValue]>0||[array count]>0) {
                cell.number.hidden=NO;
            cell.NotifictionNumber.hidden=NO;
            cell.number.text=[[NSString alloc]initWithFormat:@"%d",[_NoticeInfonumber intValue]+[array count]];
                [self localNotification:cell.number.text]; //本地通知
            }else{
                cell.number.hidden=YES;
                cell.NotifictionNumber.hidden=YES;
            }
            if ([_IsLogin isEqualToString:@"1"]) {
                cell.thumbnail.image=[UIImage imageNamed:@"1-5"];
            }else{
                cell.thumbnail.image=[UIImage imageNamed:@"mymessage.png"];}
        }else if (rowIndex==0&&columnIndex==1){
            cell.label.text=@"我在小区";
            if ([_IsLogin isEqualToString:@"1"]) {
                cell.thumbnail.image=[UIImage imageNamed:@"1-6"];}
            else{
                cell.thumbnail.image=[UIImage imageNamed:@"mymaterial.png"];
            };
        }else if (rowIndex==0&&columnIndex==2){
            cell.label.text=@"我与物业";
            cell.thumbnail.image=[UIImage imageNamed:@"1-7"];
        }else if (rowIndex==0&&columnIndex==3){
            cell.label.text=@"我的中心";
            cell.thumbnail.image=[UIImage imageNamed:@"企业黄页"];
        }
    }
    [grid setSeparatorColor:[UIColor clearColor]];//没个cell的分割线
    return cell;
}
-(NSInteger)numberOfCellsOfGridView:(UIGridView *)grid
{
    if (grid==_tabel) {
        return 4;
    }else if (grid==_tableView){
        return 4;}
    return 0;
}
-(void)gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    if (_tabel==grid) {
        
        if (rowIndex==0&&colIndex==0){
            [self pageViewController:@"2"];
        }else if (rowIndex==0&&colIndex==1){
            [self  pageViewController:@"3"];
        }else if (rowIndex==0&&colIndex==2){
            [self pageViewController:@"4"];
        }else if (rowIndex==0&&colIndex==3){
            [self pageViewController:@"8"];
        }
        
    }
    else if (_tableView==grid){
        if (rowIndex==0&&colIndex==0){
            [self  pageViewController:@"5"];
        }else if (rowIndex==0&&colIndex==1){
            [self  pageViewController:@"6"];
        }else if (rowIndex==0&&colIndex==2){
            [self  pageViewController:@"7"];
        }else if (rowIndex==0&&colIndex==3){
            [self  pageViewController:@"9"];
        }
    }
}
#pragma ViewController
-(void)pageViewController:(id)sender
{
    switch ([sender intValue]) {
        case 1:
        {
            MyBusinessCardViewController *searth=[[MyBusinessCardViewController alloc]init];
            [self.navigationController pushViewController:searth animated:YES];
            [searth release];
            break;
        }
        case 2:{
            MyDynamicViewController *query=[[MyDynamicViewController alloc]init];
            [self.navigationController pushViewController:query animated:YES];
            [query release];
            break;
        }
        case 3:
        {
            FirstViewController *Physical=[[FirstViewController alloc]init];
            [self.navigationController pushViewController:Physical animated:YES];
            [Physical release];
            break;
        }
        case 4:{
            CenterViewController *center=[[CenterViewController alloc]init];
            [self.navigationController pushViewController:center animated:YES];
            [center release];
            break;
        }
        case 5:{
            if ([_IsLogin isEqualToString:@"1"]) {
                CharacterSetViewController *number=[[CharacterSetViewController alloc]init];
                [self.navigationController pushViewController:number animated:YES];
                [number release];
            }else {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"此功能需要先登录" message:@"您是否现在登陆"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            break;
        }
        case 6:{
            if ([_IsLogin isEqualToString:@"1"]) {
                MyProfileViewController *restaurant=[[MyProfileViewController alloc]init];
                [self.navigationController pushViewController:restaurant animated:YES];
                [restaurant release];
            }else {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"此功能需要先登录" message:@"您是否现在登陆"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            break;
        }
        case 7:
        {
            MySuggestionViewController *reservation=[[MySuggestionViewController alloc]init];
            [self.navigationController pushViewController:reservation animated:YES];
            [reservation release];
            break;
        } case 8:
        {
            YellowPagesViewController *reservation=[[YellowPagesViewController alloc]init];
            [self.navigationController pushViewController:reservation animated:YES];
            [reservation release];
            break;
        }
        case 9:
        {
            GarageViewController *reservation=[[GarageViewController alloc]init];
            [self.navigationController pushViewController:reservation animated:YES];
            [reservation release];
            break;
        }
        case 10:
        {
            GasViewController *reservation=[[GasViewController alloc]init];
            [self.navigationController pushViewController:reservation animated:YES];
            [reservation release];
            break;
        }
        default:
            break;
    }
}
#pragma mark -----
#pragma mark Alertdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"");
    }else {
        Present=YES;
        LoginViewController *login=[[LoginViewController alloc]init];
        login.delegate=self;//代理传自己的对象 掉自己的方法
        [self presentModalViewController:login animated:YES];
        [login release];
    }
}
#pragma AOScrollViewDelegate
-(void)buttonClick:(int)vid{
    NSLog(@"%d",vid);
    //     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",((UrlAddress *)[Arr objectAtIndex:vid]).urlAddress]]];
}

//本地通知
- (void)localNotification:(NSString*)sender {
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:10];//10秒后通知
        //        notification.repeatInterval=kCFCalendarUnitMinute;//循环次数，kCFCalendarUnitWeekday一周一次  //不设置默认发送一次不循环
        notification.timeZone=[NSTimeZone defaultTimeZone];//是UILocalNotification激 发时间是否根据时区改变而改变
        notification.applicationIconBadgeNumber=[sender intValue]; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"通知内容";//提示信息 弹出提示框
        notification.alertAction = @"打开";  //提示框按钮
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        notification.userInfo = infoDict; //添加额外的信息
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    [notification release];
}

#pragma mark -----
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self GetUpdate]; //检查是否有更新
    Present=NO;
    self.navigationController.navigationBarHidden=YES;
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0,0, 320,self.view.bounds.size.height);
    [self.view addSubview:backImage];
    
    if(!iphone5)
    {
        _hight=100;
    }
    else
    {
        _hight=130;
    }
    //    UIImageView *imageV=[[UIImageView alloc]init];
    //    if(!iphone5)
    //    {
    //       imageV.frame=CGRectMake(0, self.view.bounds.size.height-70,320,35);
    //    }else{
    //        imageV.frame=CGRectMake(0, 548-78, 320, 55);
    //    }
    //    imageV.image=[UIImage imageNamed:@"走马灯背景"];
    //    [self.view addSubview:imageV];
    //    [imageV release];
    
    //    //滚动label
    //    _labelGPS=[[JHTickerView alloc]init];
    //    [_labelGPS setDirection:JHTickerDirectionLTR];//字幕滚动的方向
    //    if(!iphone5)
    //    {
    //        _labelGPS.frame=CGRectMake(0, 460-70,320,35);
    //    }else{
    //        _labelGPS.frame=CGRectMake(0, 548-78, 320, 55);
    //    }
    //    _labelGPS.backgroundColor=[UIColor clearColor];
    //    [_labelGPS setTickerSpeed:60.0f];
    //    [self.view addSubview:_labelGPS];
    UIImageView *choiceback=[UIImageView new];
    choiceback.frame=CGRectMake(0,_hight, 320, 30);
    choiceback.backgroundColor=[UIColor lightGrayColor];
    choiceback.userInteractionEnabled=YES;
    [self.view addSubview:choiceback];
    
    UIButton *Residentialchoice=[UIButton buttonWithType:1];
    Residentialchoice.frame=CGRectMake(320-80,0,80, 30);
    [Residentialchoice setTitle:@"选择小区" forState:UIControlStateNormal];
    [Residentialchoice addTarget:self action:@selector(residentialacton:) forControlEvents:UIControlEventTouchUpInside];
    [choiceback addSubview:Residentialchoice];
    _choicename=[[UILabel alloc]initWithFrame:CGRectMake(20,0,200,30)];
    _choicename.backgroundColor=[UIColor clearColor];
    [choiceback addSubview:_choicename];
    _tabel=[[UIGridView alloc]initWithFrame:CGRectMake(0,_hight+30, 320,98) ];
    _tabel.uiGridViewDelegate=self;
    _tabel.scrollEnabled=NO;//设置表示图不滚动
    _tabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tabel];
    
    UIImageView *loginback=[UIImageView new];
    loginback.frame=CGRectMake(0,_hight+65+98-44, 320, 30);
    loginback.backgroundColor=[UIColor lightGrayColor];
    loginback.userInteractionEnabled=YES;
    [self.view addSubview:loginback];
    
    _Login=[UIButton buttonWithType:0];
    _Login.frame=CGRectMake(320-70,0,60,30);
    [_Login setTitle:@"登陆" forState:UIControlStateNormal];
    [_Login setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    if([_IsLogin isEqualToString:@"1"]){
        _Login.selected=YES;
        _Login.hidden=YES;
    }else{
        _Login.selected=NO;
        _Login.hidden=NO;
    }
    [_Login setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    [_Login addTarget:self action:@selector(loginaction:) forControlEvents:UIControlEventTouchUpInside];
    [loginback addSubview:_Login];
    
    UILabel *loginname=[[UILabel alloc]initWithFrame:CGRectMake(20,0,200,30)];
    loginname.text=@"用户名字";
    loginname.backgroundColor=[UIColor clearColor];
    [loginback addSubview:loginname];
    _tableView=[[UIGridView alloc]initWithFrame:CGRectMake(0,10+_tabel.frame.size.height+40+_hight, 320,100) ];
    _tableView.uiGridViewDelegate=self;
    _tableView.scrollEnabled=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [self advertisingrequsturl];//广告图片
}
-(void)residentialacton:(id)sender
{
    [self pageViewController:@"1"];
}
#pragma mark encdelegate
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
        if ([userinfo isEqualToString:@"req1"]){
            Arr=[NSMutableArray new];
            NSArray *arr=[dic objectForKey:@"data"];
            for (int i=0;i<[arr count]; i++) {
                UrlAddress *URL=[UrlAddress new];
                NSDictionary *dic=[arr objectAtIndex:i];
                if ([dic objectForKey:@"imageurl"]) {
                    URL.urlimage=[dic objectForKey:@"imageurl"];
                }
                if ([dic objectForKey:@"adurl"]) {
                    URL.urlAddress=[NSString stringWithFormat:@"%@",[dic objectForKey:@"adurl"]];
                }else
                {
                    URL.urlAddress=@"无";
                }
                [Arr addObject:URL];
                [URL release];
            }
            NSMutableArray  *mutablearr=[NSMutableArray new];
            NSMutableArray *mutabletitle=[NSMutableArray new];
            for (int i=0; i<[Arr count]; i++) {
                UrlAddress *url=((UrlAddress *)[Arr objectAtIndex:i]);
                [mutablearr addObject:url.urlimage ];//照片地址
                [mutabletitle addObject:url.urlAddress];//添加连接地址
                //广告视图
                _scroll=[[AOScrollerView alloc]initWithNameArr:mutablearr titleArr:mutabletitle height:_hight];
                _scroll.vDelegate = self;
                [self.view addSubview:_scroll];
            }
//            [self advertisingfontrequsturl];//广告文字
        }else if ([userinfo isEqualToString:@"req2"]){
            NSString *string=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
            _tickerStrings = [NSMutableArray new];
            if ([string isEqualToString:@"1"]) {
                
                for (int i=0; i<[[dic objectForKey:@"data"] count]; i++) {
                    NSString *NoticeInfo=[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"NoticeInfo"]];
                    if (!NoticeInfo) {
                        NoticeInfo=@"NULL";
                    }
                    [_tickerStrings addObject:NoticeInfo];
                }
                [_tickerStrings retain];
                //滚动label
                [_labelGPS setTickerStrings:_tickerStrings];//内容
                [_labelGPS start];//开始滚动字幕  一定要先给视图附值才能正常开始动画
                
            }else{
                NSLog(@"没数据");
            }
        }
        else if ([userinfo isEqualToString:@"req3"]){
            NSString *string=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
            if ([string isEqualToString:@"1"]) {
                for (int i=0; i<[[dic objectForKey:@"data"] count]; i++) {
                    _NoticeInfonumber=[[NSString alloc ]initWithFormat:@"%d",[[[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"UnReadSMSCounts"] intValue]];
                    NSLog(@"%@", _NoticeInfonumber);
                }
                
                [_tableView reloadData];
            }else{
                NSLog(@"连接数据有问题");
            }
        }else{
            NSLog(@"=返回数据不是JSON 字典=");
        }
    }
}
#pragma mark ====
//广告图片
-(void)advertisingrequsturl{
    NSString *userindex = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"]) {
        userindex=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];//用户
    }else{
        userindex=@"0"; //游客
    }
    encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    [encapsulation startRequstASIurl:@"InfoManage/SelectService.asmx/GetTopADData" andgroupindex:nil andsendinfo:nil userindex:userindex  addinfo:@"req1" andsitecode:nil];
}
//文字
-(void)advertisingfontrequsturl{
    NSString*url=[NSString stringWithFormat:@"InfoManage/SelectService.asmx/GetBottomADData"];
    NSString *userindex = nil;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"]) {
        userindex=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];//用户
    }else{
        userindex=@"0"; //游客
    }
    encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    [encapsulation startRequstASIurl:url andgroupindex:nil andsendinfo:nil userindex:userindex  addinfo:@"req2" andsitecode:nil];
}
//获取通知条数
-(void)notificationaction:(id)sender
{
    if([_IsLogin isEqualToString:@"1"]){
   
        NSString *userindex = [EncapsulationASI UserIndex];
        encapsulation=[EncapsulationASI new];
        encapsulation.delegate=self;
        [encapsulation startRequstASIurl:@"InfoManage/SelectService.asmx/GetUnreadPrivateSMSCounts" andgroupindex:nil andsendinfo:nil userindex:userindex addinfo:@"req3" andsitecode:nil];
//        _imagenaber=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"消息条数"]];
//        if (!iphone5) {
//            _imagenaber.frame=CGRectMake(8, 242, 25,25);
//        }else{
//            _imagenaber.frame=CGRectMake(8, 260, 25,25);
//        }
//        _imagenaber.hidden=YES;
//        [self.view addSubview:_imagenaber];
    }
}
#pragma mark alertView
-(void)alertviewmessage:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
#pragma mark =============
//登陆
-(void)loginaction:(UIButton *)sender
{
    if (sender.selected) {
        [self alertviewmessage:@"您已经登陆过了"];
    }else{
        Present=YES;
        LoginViewController *login=[[LoginViewController alloc]init];
        login.delegate=self;//代理传自己的对象 掉自己的方法
        [self presentModalViewController:login animated:YES];
        [login release];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark UpdateApp
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_tableView reloadData];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"insertcommunityname"]) {
        _choicename.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"insertcommunityname"];
    }else{
        _choicename.text=@"未选择小区";
    }
    //自动登陆
    if ([EncapsulationASI UserIndex]) {
        _IsLogin=@"1";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"audit"]) {
            _username.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"audit"]];
            _username.textColor=[UIColor redColor];
        }else{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *firstName = [defaults objectForKey:@"firstName"];
            _username.text=[NSString stringWithFormat:@"您是我们的第%@个注册用户",firstName];
            _username.textColor=[UIColor whiteColor];
        }
        _Login.hidden=YES;
    }else{
        _IsLogin=@"1000";
        _Login.hidden=NO;
        _username.text=@"游客，您好";
        _username.textColor=[UIColor whiteColor];
    }
    [self performSelector:@selector(notificationaction:) withObject:nil afterDelay:0];
  
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithContentsOfFile:path];
//    NSLog(@"==%@==",dic);
//    //获取应用程序沙盒的Documents 目录
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *plistPath1=[paths objectAtIndex:0];
//    NSDictionary *dicnotification=[[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"rid",@"22",@"sendinfo",@"222",@"titleinfo",@"22233",@"username",nil];
//    NSArray *arr=[[NSArray alloc]initWithObjects:dicnotification, nil];
//     [dic setObject:arr  forKey:@"1"];
//    //得到完整的文件名
//    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Notification.plist"];
//    //写入文件
//    [dic writeToFile:filename atomically:YES];
//  
//  
//    NSDictionary *dicnotification2=[[NSDictionary alloc]initWithObjectsAndKeys:@"1333",@"rid",@"22",@"sendinfo",@"222",@"titleinfo",@"22233",@"username",nil];
//    NSArray *arr2=[[NSArray alloc]initWithObjects:dicnotification2, nil];
//      [dic setObject:arr2  forKey:@"2"];
//    //得到完整的文件名
//    //写入文件
//    [dic writeToFile:[plistPath1 stringByAppendingPathComponent:@"Notification.plist"] atomically:YES];
//    NSLog(@"-----222%@====",[[NSMutableDictionary alloc]initWithContentsOfFile:filename]);

}
-(void)viewDidDisappear:(BOOL)animated
{
    [_imagenaber removeFromSuperview];
    
}
//检查是否有新的APP版本
-(void)GetUpdate
{
    [Harpy checkVersionupdate:YES];
}

@end
