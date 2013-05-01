//
//  CommunityListViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-22.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "CommunityListViewController.h"
#import "ChineseToPinyin.h"
#import "pinyin.h"
@interface CommunityListViewController ()

@end

@implementation CommunityListViewController

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
    _Community=nil;
    _communityobject=nil;
    _table=nil;
    encapsulation=nil;
    _SectionMutableAry=nil;
    _SectionDict=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
      backImage.frame=CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, self.view.bounds.size.width, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,self.view.bounds.size.width,44);
    username.text=_communityobject.cityname;
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10,6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but.titleLabel.font=[UIFont systemFontOfSize:15.f];//字体
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0,85-44, 320, 40)];
    _search.barStyle=UIBarStyleBlackTranslucent;//设置样式
    _search.delegate=self;
    _search.placeholder=@"搜索您要的小区";
    [self.view addSubview:_search];

    _table=[[UITableView alloc]initWithFrame:CGRectMake(0,44+40,self.view.bounds.size.width, self.view.bounds.size.height-95)];
    _table.dataSource=self;
    _table.delegate=self;
    [self.view addSubview:_table];
    [self community:_communityobject.sitecode];
	
}
//获取小区列表
-(void)community:(NSString *)community{

    encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    [encapsulation startRequstASIurl:@"InfoManage/SelectService.asmx/GetPropertyData" andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req1" andsitecode:community];
}

#pragma mark ======encdelegate
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    NSDictionary *dic=[strData  JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]]) {
   if([userinfo isEqualToString:@"req1"]){
       _Community=[NSMutableArray new];
        if ([[dic objectForKey:@"status"] intValue]==1) {
            NSArray *arr= [dic objectForKey:@"data"];
            for (int i=0; i<[arr count]; i++) {
                UrlAddress *url=[UrlAddress new];
                url.sitecode= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
                url.cityname=[[arr objectAtIndex:i]objectForKey:@"groupname"];
                url.NameFirstLetter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([url.cityname characterAtIndex:0])] uppercaseString];  /*
                                                                                                                                      取出名字的首字母转化为大写 */
                url.NameLetter = [ChineseToPinyin pinyinFromChiniseString:url.cityname]; //把中文名字转化为拼音
                [ _Community addObject:url];
             
            } 
        }else {
            UrlAddress *url=[UrlAddress new];
            url.cityname=@"待添加";
            url.NameFirstLetter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([url.cityname characterAtIndex:0])] uppercaseString];  /*
                                                                                                                                              取出名字的首字母转化为大写 */
            url.NameLetter = [ChineseToPinyin pinyinFromChiniseString:url.cityname]; //把中文名字转化为拼音
            [_Community addObject:url];
        }
      [self tableviewdatasource:_Community];//排序
       NSLog(@"%d",[_Community count]);
   }else if ([userinfo isEqualToString:@"req2"]){
       NSLog(@"%@",dic);
       NSString *string=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
       if ([string intValue]==0) {
           [self alertView:@"想加入该小区请您输入手机号码审核" clicked:YES];
       }else if ([string intValue]==1){
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"匹配成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
           [alert show];
           [alert release];
           
       }else if ([string intValue]==9){
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"小区存在" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
           [alert show];
           [alert release];
           
       }

   }else if ([userinfo isEqualToString:@"req3"]){
       NSLog(@"%@",dic);
       if ([[dic objectForKey:@"status"]intValue]==1) {
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"申请成功" message:@"待物业审核" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
           alert.tag=200;
           [alert show];
           [alert release];
       }else{
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"申请失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
           [alert show];
           [alert release];
       }
//       [_activityViewLoad stopAnimating];//停止
   }
  }else{
        NSLog(@"===返回的数据类型不是字典");
    }
    
//    [_activityViewLoad stopAnimating];
}

-(void)tableviewdatasource:(NSMutableArray*)community
{
    _Community=[NSMutableArray new];
    _SectionDict = [NSMutableDictionary new];//开辟新空间
    _SectionMutableAry = [NSMutableArray new];
    _Community=community;
   _Community = (NSMutableArray *)[_Community sortedArrayUsingComparator:^NSComparisonResult(UrlAddress *obj1,UrlAddress *obj2) {
        return [obj1.NameFirstLetter compare:obj2.NameFirstLetter];
    }];//取对象按两个属性 排序 块语法
    
    for (UrlAddress * contactModel in  _Community) {
        NSMutableArray* section = [_SectionDict objectForKey:contactModel.NameFirstLetter];
        if (!section) {
            section = [NSMutableArray array];
            [_SectionDict setObject:section forKey:contactModel.NameFirstLetter];
            [_SectionMutableAry addObject:contactModel.NameFirstLetter];
        }
        [section addObject:contactModel];
    }
    NSLog(@"%@=====%@",_SectionDict,_SectionMutableAry);
    [_table reloadData];
}
-(void)alertView:(NSString *)string  clicked:(BOOL)cancl
{   NSString *str=nil;
    if(cancl){
        str=@"取消";
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:string delegate:self cancelButtonTitle:str otherButtonTitles:@"申请", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    alert.tag=1;
    [alert show];
    [alert release];
}
#pragma mark alertdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            [self MyinsertCommunity:[alertView textFieldAtIndex:nil].text];//传送号码
        }else  if(buttonIndex==0){
            
        }
    }else if (alertView.tag==200){
        if(buttonIndex==0){
            [[NSUserDefaults standardUserDefaults] setObject:@"小区待审核" forKey:@"audit"];
            [self.navigationController popToRootViewControllerAnimated:YES];}
    }else if (alertView.tag==100){
        if(buttonIndex==1){
            LoginViewController*login=[LoginViewController new];
            [self  presentViewController:login animated:YES completion:^{
                
            } ];
            [login release];
        }else if(buttonIndex==0){
        
        }
        
    }
    
}
-(void)insertaction:(id)sender
{
//    NSString *userID= [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
//    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
//    if (str) {
//        NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/InsertService.asmx/InsertUserForGroup"];
//        ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
//        NSLog(@"_groupindex==%@",_groupindex);
//        [PostRequst setPostValue:_groupindex forKey:@"groupindex"];//小区ID
//        [PostRequst setPostValue:str forKey:@"userindex"];//用户注册账号
//        [PostRequst setPostValue:userID forKey:@"telephone"];//手机号码
//        PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req4" forKey:@"name"];
//        PostRequst.delegate=self;
//        [PostRequst startAsynchronous];//发起异步请求
//    }else{
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"添加小区需要用户登陆" message:@"您是否现在注册" delegate:self cancelButtonTitle:str otherButtonTitles:@"确定", nil];
//        alert.tag=100;
//        [alert show];
//        [alert release];
//
//    }
}
//警告视图点击确定用户申请加入小区
-(void)MyinsertCommunity:(NSString *)sender
{
    NSString *userindex=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    encapsulation.Telephone=sender;
    [encapsulation startRequstASIurl:@"InfoManage/InsertService.asmx/InsertUserBeGroup" andgroupindex:_groupindex andsendinfo:@"我是该小区的业主,请物业审核" userindex:userindex addinfo:@"req3" andsitecode:nil];
    
}
-(void)insertCommunityuserindex:(NSString*)sender andusertelephone:(NSString*)usertelephone andgroupindex:(NSString*)groupindex
{
   encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    encapsulation.Telephone=usertelephone;
    [encapsulation startRequstASIurl:@"InfoManage/InsertService.asmx/InsertUserForGroup" andgroupindex:groupindex andsendinfo:nil userindex:usertelephone addinfo:@"req2" andsitecode:nil];

}
#pragma mark Tabledelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr=[_SectionDict objectForKey:[_SectionMutableAry objectAtIndex:indexPath.section]];
    UrlAddress *url=[arr objectAtIndex:indexPath.row];
    _groupindex=url.sitecode;

    NSString *usertelephone= [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];//用户注册账号
    NSString *userindex=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];//用户唯一标示
    if (userindex&&usertelephone) {
//        [self insertCommunityuserindex:userindex andusertelephone:usertelephone andgroupindex:_groupindex];
        NSUserDefaults *userdic=[NSUserDefaults standardUserDefaults];
        [userdic setObject:url.cityname forKey:@"insertcommunityname"];
        NSLog(@"%@",url.cityname);
       
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        NSLog(@"没有登陆用户");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"添加小区需要用户登陆" message:@"您是否现在登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=100;
        [alert show];
        [alert release];

    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifrecell=@"cell";
    UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:Identifrecell];
    if (!cell) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifrecell] autorelease];
    }
    NSLog(@"%@===",[_SectionMutableAry objectAtIndex:indexPath.section]);
    NSArray *arr=[_SectionDict objectForKey:[_SectionMutableAry objectAtIndex:indexPath.section]];
    
    UrlAddress *url=[arr objectAtIndex:indexPath.row];
    cell.textLabel.text=url.cityname;
    return cell;
}

//每块的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * sectionInfoAry = [_SectionDict objectForKey:[_SectionMutableAry objectAtIndex:section]];
    
    return [sectionInfoAry count];
}
//多少块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[_SectionDict allKeys] count];
}
//块的名字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_SectionMutableAry objectAtIndex:section];
}
//右边的收缩条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _SectionMutableAry;
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
