//
//  CharacterSetViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "CharacterSetViewController.h"
#import "InformDetailsViewController.h"//通知详情界面
@interface CharacterSetViewController ()

@end

@implementation CharacterSetViewController

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
   _NoticeTable=nil;
    _MutableDic=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0,0, self.view.bounds.size.width,self.view.bounds.size.height);
      [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    username.textColor=[UIColor whiteColor];
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

    _NoticeTable=[[UITableView alloc]initWithFrame:CGRectMake(0,44, 320,460) style:UITableViewStylePlain];
    _NoticeTable.delegate=self;
    _NoticeTable.backgroundView=nil;
    _NoticeTable.backgroundColor=[UIColor clearColor];
     _NoticeTable.separatorColor=[UIColor clearColor];
    _NoticeTable.dataSource=self;
    [self.view addSubview:_NoticeTable];
       [backImage release];
    [navigation release];
    [username release];
    [self requestURL];//获取通知条数详情
    UIButton *but1=[UIButton buttonWithType:0];
    but1.frame=CGRectMake(320-80, 6, 60, 30);
    [but1 setTitle:@"编辑" forState:UIControlStateNormal];
    [but1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but1 setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    but1.selected=NO;
    [but1 addTarget:self action:@selector(editingaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
  
}
-(void)editingaction:(UIButton *)sender{
    if (sender.selected) {
        sender.selected=NO;
        _NoticeTable.editing=NO;
    }else{
        _NoticeTable.editing=YES;
        sender.selected=YES;
    }
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
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
     NSDictionary *dic= [strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]]) {
         if ([userinfo isEqualToString:@"req1"]) {
             NSString *status=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
             if ([status intValue]==1) {
                 NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
                 NSString *filePath = [self datafilePath];
                 if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])//如果沙盒不存在就copy到路径到沙盒文件里真运行必须要
                 {
                     [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
                 }
                 _MutableDic=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
                 NSArray *arr= [dic objectForKey:@"data"] ;
                 NSMutableArray *mutable=[[NSMutableArray alloc]init];
                 NSString *string=[[NSString alloc]init];
                 for (int i=0; i<[arr count]; i++) {
                     NSMutableDictionary *mutabledic=[[NSMutableDictionary alloc]init];
                     [mutabledic setObject:[[arr objectAtIndex:i] objectForKey:@"sendinfo"] forKey:@"sendifo"];
                     [mutabledic setObject: [[arr objectAtIndex:i] objectForKey:@"sendtime"] forKey:@"sendtime"];
                     [mutabledic setObject: [[arr objectAtIndex:i] objectForKey:@"titleinfo"] forKey:@"titleinfo"];
                     [mutabledic setObject:[[arr objectAtIndex:i] objectForKey:@"username"] forKey:@"username"];
                     [mutabledic setObject:[[arr objectAtIndex:i] objectForKey:@"rid"] forKey:@"rid"];
                     [mutabledic setObject:@"0" forKey:@"read"];
                     if ([_MutableDic objectForKey:firstName]) {
                         NSLog(@"====有数据===");
                         [[_MutableDic objectForKey:firstName] addObject:mutabledic];
                     }else{
                         [mutable addObject:mutabledic];
                     }
                     [mutabledic release];
                     string = [string stringByAppendingFormat:@"%@,",[[arr objectAtIndex:i]objectForKey:@"rid"]];
                     NSLog(@"==%@",string);
                 }
                 if ([_MutableDic objectForKey:firstName]) {
                     NSLog(@"==有数据===");
                 }else{
                     NSLog(@"没数据");
                     [_MutableDic setObject:mutable forKey:firstName];
                     [mutable release];
                 }
                 [_MutableDic writeToFile:filePath atomically:YES];
                 [self uploadingNotifiction:string];
                 [_NoticeTable reloadData];
             }else{
                 NSLog(@"没数据");
             }}else if ([userinfo isEqualToString:@"req2"]){
                 NSLog(@"--%@--",[dic objectForKey:@"status"]);
             }
    }else{
        NSLog(@"==返回数据问不是字典==");
    }
}
-(void)uploadingNotifiction:(NSString *)rid{
    EncapsulationASI *encap=[[EncapsulationASI alloc]init];
    encap.delegate=self;
    encap.NotifictionID=rid;
    [encap  startRequstASIurl:@"InfoManage/UpdateService.asmx/UpdatePrivateInfoState" andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req2" andsitecode:nil];
}
//获取通知信息的内容
-(void)requestURL
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"];
// ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
//   [PostRequst setPostValue:firstName forKey:@"userindex"];
//   PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req1" forKey:@"name"];
//  PostRequst.delegate=self;
//  [PostRequst startAsynchronous];//发起异步请求
    EncapsulationASI *encap=[[EncapsulationASI alloc]init];
    encap.delegate=self;
    [encap  startRequstASIurl:@"InfoManage/SelectService.asmx/GetUserPrivateInfo" andgroupindex:nil andsendinfo:nil userindex:firstName addinfo:@"req1" andsitecode:nil];
}
-(NSString *)datafilePath//返回数据文件的完整路径名。
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docPath stringByAppendingPathComponent:@"Notification.plist"];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
//    NSString *strData=[[NSString alloc]initWithData: [request responseData]encoding:NSUTF8StringEncoding];
//    NSDictionary *dic=[strData JSONValue];
//     if ([dic isKindOfClass:[NSDictionary class]] ) {
//         if ([[request.userInfo objectForKey:@"name"] isEqualToString:@"req1"] ) {
//    NSString *status=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
//    if ([status intValue]==1) {
//        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
//        NSString *filePath = [self datafilePath];
//        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])//如果沙盒不存在就copy到路径到沙盒文件里真运行必须要
//        {
//            [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
//        }
//        _MutableDic=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
//        NSArray *arr= [dic objectForKey:@"data"] ;
//            NSMutableArray *mutable=[[NSMutableArray alloc]init];
//        for (int i=0; i<[arr count]; i++) {
//            NSMutableDictionary *mutabledic=[[NSMutableDictionary alloc]init];
//            [mutabledic setObject:[[arr objectAtIndex:i] objectForKey:@"sendinfo"] forKey:@"sendifo"];
//            [mutabledic setObject: [[arr objectAtIndex:i] objectForKey:@"sendtime"] forKey:@"sendtime"];
//            [mutabledic setObject: [[arr objectAtIndex:i] objectForKey:@"titleinfo"] forKey:@"titleinfo"];
//            [mutabledic setObject:[[arr objectAtIndex:i] objectForKey:@"username"] forKey:@"username"];
//            [mutabledic setObject:[[arr objectAtIndex:i] objectForKey:@"rid"] forKey:@"rid"];
//            [mutabledic setObject:@"0" forKey:@"read"];
//            if ([_MutableDic objectForKey:firstName]) {
//                NSLog(@"====有数据%@===",[_MutableDic objectForKey:firstName]);
//                [[_MutableDic objectForKey:firstName] addObject:mutabledic];
//            }else{
//                [mutable addObject:mutabledic];
//               }
//        [mutabledic release];
//        }
//        if ([_MutableDic objectForKey:firstName]) {
//                NSLog(@"有数据%@===",[_MutableDic objectForKey:firstName]);
//            }else{
//                NSLog(@"没数据");
//                [_MutableDic setObject:mutable forKey:firstName];
//                [mutable release];
//            }
//            [_MutableDic writeToFile:filePath atomically:YES];
//
//         [_NoticeTable reloadData];
//    }else{
//        NSLog(@"没数据");
//    }}
//     }else{
//         NSLog(@"返回数据问题");
//     }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"失败");
}
#pragma mark TableViewdelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (Cell==nil) {
        Cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //头名
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40,0,320-60,30)];
        label.font=[UIFont systemFontOfSize:20];
        label.backgroundColor=[UIColor clearColor];
        label.tag=1;
        [Cell.contentView addSubview:label];
        //内容
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40,20, 320-60,60)];
        label1.tag=2;
        label1.font=[UIFont systemFontOfSize:14];
        //label1.lineBreakMode=UILineBreakModeWordWrap;
        label1.numberOfLines=2;
        label1.backgroundColor=[UIColor clearColor];
        [Cell.contentView addSubview:label1];
        //时间
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(320-120,62,120, 20)];
        label2.tag=3;
        label2.font=[UIFont systemFontOfSize:14];
        label2.backgroundColor=[UIColor clearColor];
        [Cell.contentView addSubview:label2];
        //分割线
        UIView *view=[UIView new];
        view.backgroundColor=[UIColor grayColor];
        view.frame=CGRectMake(0, label1.frame.size.height+label2.frame.size.height, 340, 1);
        [Cell.contentView addSubview:view];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
    //获取应用程序沙盒的Documents 目录
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
    NSString *filePath = [self datafilePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
    }

    _MutableDic=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    NSArray *array=[_MutableDic objectForKey:firstName];
    NSDictionary *dicnotifiction=[array objectAtIndex:indexPath.row];
    UILabel *label= (UILabel*) [Cell viewWithTag:1];
           label.text=[dicnotifiction objectForKey:@"titleinfo"];
    UILabel *label1=(UILabel*)[Cell viewWithTag:2];
    label1.text=[dicnotifiction objectForKey:@"sendifo"];
    UILabel *label2=(UILabel*)[Cell viewWithTag:3];
    label2.text=[dicnotifiction objectForKey:@"sendtime"];
      if ([[dicnotifiction objectForKey:@"read"] intValue]==1) {
          label.textColor=[UIColor lightGrayColor];
           label1.textColor=[UIColor lightGrayColor];
           label2.textColor=[UIColor lightGrayColor];
      } else{
          label.textColor=[UIColor blackColor];
          label1.textColor=[UIColor blackColor];
          label2.textColor=[UIColor blackColor];
      }
    UIView  *view=[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    Cell.selectedBackgroundView=view;
    Cell.selectionStyle=UITableViewCellEditingStyleNone;
  return Cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
    //获取应用程序沙盒的Documents 目录
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
    NSString *filePath = [self datafilePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])//真机必须加上这句
    {
        [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
    }
    _MutableDic=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    return [[_MutableDic objectForKey:firstName] count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
    NSString *filePath = [self datafilePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])//如果沙盒不存在就copy到路径到沙盒文件里真运行必须要
    {
        [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
    }
    
    if ([[[[_MutableDic objectForKey:firstName] objectAtIndex:indexPath.row] objectForKey:@"read"] intValue]==0) {
        [[[_MutableDic objectForKey:firstName] objectAtIndex:indexPath.row] setObject:@"1" forKey:@"read"];
        [_MutableDic writeToFile:filePath atomically:YES];
    }
    [tableView reloadData];
    InformDetailsViewController *informDetails=[[InformDetailsViewController alloc]init];
   informDetails.Notife=[[_MutableDic objectForKey:firstName] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:informDetails animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark editing Delegate
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_NoticeTable setEditing:editing animated:animated];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
 return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *firstName = [defaults objectForKey:@"firstName"]; //获取登陆用户的ID
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
        NSString *filePath = [self datafilePath];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])//如果沙盒不存在就copy到路径到沙盒文件里真运行必须要
        {
            [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
        }
            [[_MutableDic objectForKey:firstName] removeObjectAtIndex:indexPath.row];
           [_MutableDic writeToFile:filePath atomically:YES];
         [_NoticeTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}
#pragma mark =====
@end
