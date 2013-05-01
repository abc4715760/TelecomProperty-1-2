//
//  MyBusinessCardViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "MyBusinessCardViewController.h"

@interface MyBusinessCardViewController ()

@end

@implementation MyBusinessCardViewController

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
    _tableView=nil;
    _array=nil;
    _arraycoumy=nil;
    _Community=nil;
    _strcity0=nil;
    _strcity1=nil;
    _strcity=nil;
    _picker=nil;
    _groupindex=nil;
    encapsulation=nil;
}
#pragma mark SearchBar Delegate Methods
//点击将要开始编辑时进入代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	searchBar.showsCancelButton = YES;//显示一个取消按钮
	for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            
        }
    }
	return YES;
}
//编辑将要结束时进入代理
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton=NO;//不显示取消按钮
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  
    [_search resignFirstResponder];
    _search.text=@"";
   
}
//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}

//当searchBar里 的类容将要发生变化时调用该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  // called when text changes (including clear)
{
//    table.hidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        height=480;
    }
    else
    {
        height=548;
    }
    backImage.frame=CGRectMake(0,0, 320, height);
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"选择小区";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    but.titleLabel.font=[UIFont systemFontOfSize:15.f];//字体
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
//    UIButton *but1=[UIButton buttonWithType:0];
//    but1.frame=CGRectMake(320-70, 6, 60, 30);
//    [but1 setTitle:@"添加" forState:UIControlStateNormal];
//    [but1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [but1 setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
//    [but1 addTarget:self action:@selector(insertaction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:but1];
//    _picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 460-44, 320, 216)];
//    _picker.hidden=YES;
//    [UIView animateWithDuration:0.5 animations:^{
//        _picker.hidden=NO;
//        _picker.frame=CGRectMake(0, 59+80, 320, 216);
//    }];
//    _picker.dataSource=self;
//    _picker.delegate=self;
//    _picker.showsSelectionIndicator=YES;
//    [self.view addSubview:_picker];
    _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 5+80-44, 320, 40)];
     _search.barStyle=UIBarStyleBlackTranslucent;//设置样式
    _search.delegate=self;
    _search.placeholder=@"搜索您要的小区";
    [self.view addSubview:_search];
     _array=[[NSMutableArray alloc]init];
	_arraycoumy=[[NSMutableArray alloc]init];
    _Community=[[NSMutableArray alloc]init];
    _activityViewLoad = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityViewLoad.frame = CGRectMake(0, 0,20, 20);
    _activityViewLoad.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:_activityViewLoad];
    [backImage release];
    [username release];
    [navigation release];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, 88, 100,self.view.bounds.size.height-88-44-5) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.backgroundView=nil;
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(self.view.bounds.origin.x+110, self.view.bounds.origin.y+90, self.view.bounds.size.width-115, self.view.bounds.size.height-120);
    imageView.image=[UIImage imageNamed:@"map.png"];
    [self.view addSubview:imageView];
     [self loginrequeset:@"07"];
}
#pragma mark encapsulation delegate
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    [_activityViewLoad startAnimating];//开始
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
        if ([[dic objectForKey:@"status"]intValue]==1) {
        if ([userinfo isEqualToString:@"req1"]) {
            NSArray *arr= [dic objectForKey:@"data"];
            for (int i=0; i<[arr count]; i++) {
                UrlAddress *url=[UrlAddress new];
                url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
                url.cityname=[[arr objectAtIndex:i]objectForKey:@"cityname"];
                [_array addObject:url];
            }
            if (_array) {
                NSString *str=((UrlAddress *)[_array objectAtIndex:0]).sitecode;
                [self AreaCounty: str];
            }
        }else if([userinfo isEqualToString:@"req2"]){
            [_arraycoumy removeAllObjects];
            [_Community removeAllObjects];
            NSLog(@"====%@=====",dic);
                NSArray *arr= [dic objectForKey:@"data"];
                for (int i=0; i<[arr count]; i++) {
                    UrlAddress *url=[UrlAddress new];
                    url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
                    url.cityname=[[arr objectAtIndex:i]objectForKey:@"areaname"];
                    [_arraycoumy addObject:url];
                }
                if (_arraycoumy) {
//                    NSString *str=((UrlAddress *)[_arraycoumy objectAtIndex:0]).sitecode;
            }else{
                UrlAddress *url=[UrlAddress new];
                url.cityname=@"待添加";
                [_arraycoumy addObject:url];
            }
            [_tableView reloadData];
        }
        }else{
            NSLog(@"==该请求返回数据为空");
        }
    }else{
        NSLog(@"==返回数据类型不是字典==");
    }
}
#pragma mark ASIHTTpRequstDelegate
-(void)requestFailed:(ASIHTTPRequest *)request
{
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [_activityViewLoad startAnimating];//开始
    NSString *reqname=[request.userInfo objectForKey:@"name"];
    NSString *strData=[[NSString alloc]initWithData:  [request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
          if ([reqname isEqualToString:@"req1"]) {
        NSArray *arr= [dic objectForKey:@"data"];
       for (int i=0; i<[arr count]; i++) {
       UrlAddress *url=[UrlAddress new];
       url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
       url.cityname=[[arr objectAtIndex:i]objectForKey:@"cityname"];
        [_array addObject:url];
    }
          if (_array) {
         NSString *str=((UrlAddress *)[_array objectAtIndex:0]).sitecode;
         [self AreaCounty: str];
    }
     }else if([reqname isEqualToString:@"req2"]){
         [_arraycoumy removeAllObjects];
         [_Community removeAllObjects];
           if ([[dic objectForKey:@"status"] intValue]==1) {
//               NSLog(@"====%@=====",dic);
       NSArray *arr= [dic objectForKey:@"data"];
        for (int i=0; i<[arr count]; i++) {
            UrlAddress *url=[UrlAddress new];
            url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
            url.cityname=[[arr objectAtIndex:i]objectForKey:@"areaname"];
            [_arraycoumy addObject:url];
        }
         if (_arraycoumy) {
             NSString *str=((UrlAddress *)[_arraycoumy objectAtIndex:0]).sitecode;
           [self  community: str];
         }
           }else{
               NSLog(@"00000");
                 UrlAddress *url=[UrlAddress new];
                 url.cityname=@"待添加";
               [_arraycoumy addObject:url];
               [_Community addObject:url];
           }
     } else if([reqname isEqualToString:@"req3"]){
          [_Community removeAllObjects];
            if ([[dic objectForKey:@"status"] intValue]==1) {
                NSLog(@"====%@=====",dic);
        NSArray *arr= [dic objectForKey:@"data"];
         for (int i=0; i<[arr count]; i++) {
             UrlAddress *url=[UrlAddress new];
             url.sitecode= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
             url.cityname=[[arr objectAtIndex:i]objectForKey:@"groupname"];
             [ _Community addObject:url];
         }
         }else {
             UrlAddress *url=[UrlAddress new];
             url.cityname=@"待添加";
             [_Community addObject:url];
         }
         [_activityViewLoad stopAnimating];
         _strcity0=((UrlAddress *)[_array  objectAtIndex:0]).cityname;
         _strcity=((UrlAddress *)[_arraycoumy  objectAtIndex:0]).cityname;//当第一项改变时，第二项始终取数组的第一位
         _strcity1=((UrlAddress *)[_Community  objectAtIndex:0]).cityname;//当第2项改变时第3项始终取该数组的第一位
         _groupindex= ((UrlAddress *)[_Community objectAtIndex:0]).sitecode;
         _search.text=[NSString stringWithFormat:@"地址 :%@ -%@ -%@",_strcity0,_strcity,_strcity1];
     }else if ([reqname isEqual:@"req4"]){
         NSLog(@"%@",dic);
         NSString *string=[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
         if ([string intValue]==0) {
             [self alertView:@"请您输入手机号码审核" clicked:YES];
         }else if ([string intValue]==1){
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"匹配成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             [alert release];

         }else if ([string intValue]==9){
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"小区存在" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alert show];
             [alert release];

         }
          [_activityViewLoad stopAnimating];//停止
     }else if ([reqname isEqual:@"req5"]){
         NSLog(@"==%@",dic);
         if ([[dic objectForKey:@"status"]intValue]==1) {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"申请成功" message:@"待物业审核" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             alert.tag=200;
             [alert show];
             [alert release];
         }else{
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"申请失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             //             [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
             [alert show];
             [alert release];
         }[_activityViewLoad stopAnimating];//停止

     }
     [_picker reloadAllComponents];//更新
    }else{
        NSLog(@"数据返回问题");
    }
}
-(void)alertView:(NSString *)string  clicked:(BOOL)cancl
{   NSString *str=nil;
    if(cancl){
           str=@"取消";
           }
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:string delegate:self cancelButtonTitle:str otherButtonTitles:@"确定", nil];
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
        if(buttonIndex==0){
            LoginViewController*login=[LoginViewController new];
            [self  presentViewController:login animated:YES completion:^{
                
            } ];
            [login release];
        }
            
    }

   }
#pragma mark requset==
//获取市区列表请求
-(void)loginrequeset:(NSString *)str{
//    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetCityData"];
    encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    [encapsulation startRequstASIurl:@"InfoManage/SelectService.asmx/GetCityData" andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req1" andsitecode:str];

}
//区县请求
-(void)AreaCounty:(NSString *)community{

    encapsulation=[EncapsulationASI new];
    encapsulation.delegate=self;
    [encapsulation startRequstASIurl:@"InfoManage/SelectService.asmx/GetAreaData" andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req2" andsitecode:community];
  }
//小区请求
-(void)community:(NSString *)community{
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetPropertyData"];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:community forKey:@"sitecode"];
    PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req3" forKey:@"name"];
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
}
#pragma mark ========
//申请匹配添加
-(void)insertaction:(id)sender
{
//   NSString *userID= [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
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
//用户申请加入小区
-(void)MyinsertCommunity:(NSString *)sender
{
//    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
//    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/InsertService.asmx/InsertUserBeGroup"];
//    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
//    NSLog(@"_groupindex==%@",_groupindex);
//    [PostRequst setPostValue:_groupindex forKey:@"groupindex"];//小区ID
//    [PostRequst setPostValue:str forKey:@"userindex"];//用户注册账号
//    [PostRequst setPostValue:sender forKey:@"telephone"];//手机号码
//    [PostRequst setPostValue:@"申请该小区" forKey:@"sendinfo"];//发送信息 默认
//    PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req5" forKey:@"name"];
//    PostRequst.delegate=self;
//    [PostRequst startAsynchronous];//发起异步请求
}
-(void)groupaction:(id)sender
{

}
#pragma mark UIPickerViewDataSource pickerView的几个协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 3;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
     if (component==0) {
      return [_array count];
	} else if (component==1) {
        return  [_arraycoumy  count];
		//划分picker中有多少行
	}else if (component==2) {
        return [_Community count];
	}
	return	YES;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==0) {
        return 100;
    }else if (component==1){
        return 100;
    }else
        return 150;
}
//在picker中输出内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if (component==0) {
          return ((UrlAddress *)[_array objectAtIndex:row]).cityname;
	}else if (component==1) {
        
        return  ((UrlAddress *)[_arraycoumy  objectAtIndex:row]).cityname;
	}else if (component==2)
	{
        return  ((UrlAddress *)[_Community  objectAtIndex:row]).cityname;
    }
	return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if (component==0) {
        [self AreaCounty:((UrlAddress *)[_array objectAtIndex:row]).sitecode];//获取小区选择数据
          _strcity0=[self  pickerView:pickerView titleForRow:row forComponent:component];
        _strcity=((UrlAddress *)[_arraycoumy  objectAtIndex:0]).cityname;//当第一项改变时，第二项始终取数组的第一位
        _strcity1=((UrlAddress *)[_Community  objectAtIndex:0]).cityname;//当第2项改变时第3项始终取该数组的第一位
          _groupindex= ((UrlAddress *)[_Community objectAtIndex:0]).sitecode;
        [pickerView selectRow:0 inComponent:1 animated:YES];//指定第2项第一行
        [pickerView reloadComponent:1];//更新
        [pickerView selectRow:0 inComponent:2 animated:YES];//指定第3项第一行
        [pickerView reloadComponent:2];//更新
    }else if (component==1) {
        NSLog(@"%@====",((UrlAddress *)[_arraycoumy objectAtIndex:row]).cityname);
        [self community:((UrlAddress *)[_arraycoumy objectAtIndex:row]).sitecode];//获取社区选择数据
        _strcity=[self  pickerView:pickerView titleForRow:row forComponent:component];
        _strcity1=((UrlAddress *)[_Community  objectAtIndex:0]).cityname;//当第2项改变时第3项始终取该数组的第一位
         _groupindex= ((UrlAddress *)[_Community objectAtIndex:0]).sitecode;
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
        
    }else if(component==2){
        _groupindex= ((UrlAddress *)[_Community objectAtIndex:row]).sitecode;
        _strcity1=[self  pickerView:pickerView titleForRow:row forComponent:component];
      
    }
    _search.text=[NSString stringWithFormat:@"地址 :%@ -%@ -%@",_strcity0,_strcity,_strcity1];
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
#pragma mark Tabledelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityListViewController *list=[CommunityListViewController new];
    list.communityobject=[_arraycoumy objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:list animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arraycoumy count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifrecell=@"cell";
    UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:Identifrecell];
    if (!cell) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifrecell] autorelease];
    }
    UrlAddress *url=(UrlAddress*)[_arraycoumy objectAtIndex:indexPath.section];
    cell.textLabel.text=url.cityname;
    return cell;
}
//每块的头高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }else{
        return 5;
    }
}
@end
