//
//  MyDynamicViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "MyDynamicViewController.h"
#import "People.h"
#import "Cell2.h"
#import "Cell1.h"
#import "ResidentialIntroducedViewController.h"

@interface MyDynamicViewController ()

@end

@implementation MyDynamicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
    [super dealloc];
    _Tablecommunity=nil;//小区信息展示
   _Arraycommunity=nil;//存小区信息
    _arr=nil;//存小区的名字
   _search=nil;//显示所选的地址
    _selectIndex=nil;//选择的哪行
    _searchTable=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        higet=480;
    }
    else
    {
        higet=548;
    }
   [self.view addSubview:backImage];
    backImage.frame=CGRectMake(0,0, 320, higet);
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"小区介绍";
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
    
    [backImage release];
    [navigation release];
    [username release];
  
     //小区显示视图
    _Tablecommunity=[[UITableView alloc]initWithFrame:CGRectMake(0,44+37, 320, higet-88-30) style:UITableViewStyleGrouped];
    _Tablecommunity.dataSource=self;
    _Tablecommunity.delegate=self;
    [self.view addSubview:_Tablecommunity];
//     [self communityaction:nil];
    _array=[[NSMutableArray alloc]init];
	_arraycoumy=[[NSMutableArray alloc]init];
    _Community=[[NSMutableArray alloc]init];
//    [self loginrequeset:@"07"];
    _activityViewLoad = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityViewLoad.frame = CGRectMake(0, 0,20, 20);
    _activityViewLoad.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:_activityViewLoad];
    
    //小区显示视图
    _searchTable=[[UITableView alloc]initWithFrame:CGRectMake(0,44+35, 320, higet-88-30) style:UITableViewStyleGrouped];
    _searchTable.dataSource=self;
    _searchTable.delegate=self;
    _searchTable.hidden=YES;
    [self.view addSubview:_searchTable];
    
    _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0,80-44, 320, 44)];
    _search.barStyle=UIBarStyleBlackTranslucent;//设置样式
    _search.delegate=self;
    _search.placeholder=@"搜索你要找的小区名";
    [self.view addSubview:_search];
    [self mycommunity];//我的小区列表
}

#pragma mark ASIdelegate
-(void)request:(NSString*)strData andreqname:(NSString *)userinfo{
 
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSArray *arr=[dic objectForKey:@"data"] ;
        if ([userinfo isEqual:@"req1"]) {
            if ([[dic objectForKey:@"status"] intValue]==1) {
            _arraycoumy =[[NSMutableArray alloc]init];
            for (int i=0; i<[arr count]; i++) {
                UrlAddress *url=[UrlAddress new];
                url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
                url.groupname=[[arr objectAtIndex:i]objectForKey:@"groupname"];
                url.GroupImage=[[arr objectAtIndex:i]objectForKey:@"GroupImage"];
                [_arraycoumy addObject:url];
                [url release];
                
            }}else{
                NSLog(@"没有我的小区内容");
            }
            [self community];
        }else if ([userinfo isEqual:@"req2"]){
            _recommended=[NSMutableArray new];
            for (int i=0; i<[arr count]; i++) {
                UrlAddress *url=[UrlAddress new];
                url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
                url.groupname=[[arr objectAtIndex:i]objectForKey:@"groupname"];
                url.GroupImage=[[arr objectAtIndex:i]objectForKey:@"GroupImage"];
                [_recommended addObject:url];
                [url release];
            }
            [_Tablecommunity reloadData];
            [_activityViewLoad stopAnimating];
        }  else if([userinfo isEqualToString:@"req3"]){
            NSLog(@"%@=======",strData);
            NSDictionary *dic=[strData JSONValue];
            if ( [[dic objectForKey:@"status"]intValue]==1) {
                _Mycommunity=[NSMutableArray new];//初始化一个数组
                NSArray *arr=[dic objectForKey:@"data"];
                for (int i=0; i<[arr count]; i++) {
                    UrlAddress *url=[UrlAddress new];
                    url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
                    url.groupname=[[arr objectAtIndex:i] objectForKey:@"groupname"];
                    url.GroupImage=[[arr objectAtIndex:i] objectForKey:@"GroupImage"];
                    url.remark=[[arr objectAtIndex:i]objectForKey:@"remark"];
                    [_Mycommunity addObject:url];
                    [url release];
                    NSLog(@"%d",[_Mycommunity count]);
                }
                _searchTable.hidden=NO;
                [_searchTable reloadData];
            }else{
                
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该小区还没添加或用户输入错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    [alert release];
                _searchTable.hidden=YES;
                _Tablecommunity.hidden=NO;
                }
             [_activityViewLoad stopAnimating];
        }
    }
else{
        NSLog(@"==后台返回数据问题==");
    }
    
}
#pragma mark SearchBar Delegate Methods
//点击将要开始编辑时进入代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"%s",__FUNCTION__);
    _Tablecommunity.userInteractionEnabled=NO;
    _searchTable.hidden=YES;
    _Tablecommunity.hidden=NO;
	searchBar.showsCancelButton = YES;//显示一个取消按钮
     [UIView animateWithDuration:0.3 animations:^{
         searchBar.frame=CGRectMake(0, 0,CGRectGetWidth(searchBar.frame), CGRectGetHeight(searchBar.frame));
         _Tablecommunity.frame=CGRectMake(0, 81-44, CGRectGetWidth(_Tablecommunity.frame), CGRectGetHeight(_Tablecommunity.frame));
     }];
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
      NSLog(@"%s",__FUNCTION__);
    _Tablecommunity.userInteractionEnabled=YES;
    searchBar.showsCancelButton=NO;//不显示取消按钮
    _Tablecommunity.hidden=NO;
    
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
      NSLog(@"%s",__FUNCTION__);
    _Tablecommunity.userInteractionEnabled=YES;
    [UIView animateWithDuration:0.3 animations:^{
        searchBar.frame=CGRectMake(0, 0+40,CGRectGetWidth(searchBar.frame), CGRectGetHeight(searchBar.frame));
        _Tablecommunity.frame=CGRectMake(0, 81, CGRectGetWidth(_Tablecommunity.frame), CGRectGetHeight(_Tablecommunity.frame));
    }];
 
    [_search resignFirstResponder];
    _search.text=@"";
    
}
//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
      NSLog(@"%s",__FUNCTION__);
     _Tablecommunity.userInteractionEnabled=YES;
    [searchBar resignFirstResponder];
    NSLog(@"dddd");
    [self searchcommunity:searchBar.text];
    
    [UIView animateWithDuration:0.3 animations:^{
        searchBar.frame=CGRectMake(0, 0+44,CGRectGetWidth(searchBar.frame), CGRectGetHeight(searchBar.frame));
        _Tablecommunity.frame=CGRectMake(0, 81, CGRectGetWidth(_Tablecommunity.frame), CGRectGetHeight(_Tablecommunity.frame));
        
    }];
  _Tablecommunity.hidden=YES;
    
}

//当searchBar里 的类容将要发生变化时调用该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  // called when text changes (including clear)
{
      NSLog(@"%s",__FUNCTION__);
    _Tablecommunity.userInteractionEnabled=YES;
    [searchBar resignFirstResponder];
    if ([searchText length] != 0) {
     [self searchcommunity:searchBar.text];
    }
    [UIView animateWithDuration:0.3 animations:^{
        searchBar.frame=CGRectMake(0, 0+44,CGRectGetWidth(searchBar.frame), CGRectGetHeight(searchBar.frame));
        _Tablecommunity.frame=CGRectMake(0,81, CGRectGetWidth(_Tablecommunity.frame), CGRectGetHeight(_Tablecommunity.frame));
        
    }];
    _Tablecommunity.hidden=YES;

}
#pragma mark =========
#pragma mark requset

//搜索小区请求
-(void)searchcommunity:(NSString *)search{
    EncapsulationASI *en=[EncapsulationASI new];
    en.delegate=self;
    en.selectname=search;
    [en startRequstASIurl:@"InfoManage/SelectService.asmx/GetPropertyAllForName" andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req3" andsitecode:nil];
    [_activityViewLoad startAnimating];
}
//推荐小区请求
-(void)community{
    EncapsulationASI *en=[EncapsulationASI new];
    en.delegate=self;
    [en startRequstASIurl:@"InfoManage/SelectService.asmx/GetTopPropertyInfo" andgroupindex:nil andsendinfo:nil userindex:nil addinfo:@"req2" andsitecode:nil];
    [_activityViewLoad startAnimating];
}
 //我的小区列表请求
-(void)mycommunity{
    
    EncapsulationASI *asi=[[EncapsulationASI alloc]init];
    asi.delegate=self;
    NSString *url=@"InfoManage/SelectService.asmx/GetUserPropertyInfo";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"];
    [asi startRequstASIurl:url andgroupindex:nil andsendinfo:nil userindex:firstName addinfo:@"req1" andsitecode:nil];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
      
//    [_activityViewLoad startAnimating];//开始
//    NSString *strData=[[NSString alloc]initWithData:   [request responseData] encoding:NSUTF8StringEncoding];
//     NSDictionary *dic=[strData JSONValue];
//     if ([dic isKindOfClass:[NSDictionary class]] ) {
//    if ([[request.userInfo objectForKey:@"name"] isEqualToString:@"req1"]) {
//        NSArray *arr= [dic objectForKey:@"data"];
//        for (int i=0; i<[arr count]; i++) {
//            UrlAddress *url=[UrlAddress new];
//            url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
//            url.cityname=[[arr objectAtIndex:i]objectForKey:@"cityname"];
//            [_array addObject:url];
//        }
//        if (_array) {
////            NSString *str=((UrlAddress *)[_array objectAtIndex:0]).sitecode;
////            [self AreaCounty: str];
//            NSLog(@"%s",__FUNCTION__);
//        }
//    }else if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req2"]){
//        [_arraycoumy removeAllObjects];
//        [_Community removeAllObjects];
//        if ([[dic objectForKey:@"status"] intValue]==1) {
////            NSLog(@"===%@===",dic);
//            NSArray *arr= [dic objectForKey:@"data"];
//            for (int i=0; i<[arr count]; i++) {
//                UrlAddress *url=[UrlAddress new];
//                url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
//                url.cityname=[[arr objectAtIndex:i]objectForKey:@"areaname"];
//                [_arraycoumy addObject:url];
//            }
//            if (_arraycoumy) {
//                NSString *str=((UrlAddress *)[_arraycoumy objectAtIndex:0]).sitecode;
////                [self  community: str];
//            }
//             [_Tablecommunity reloadData];//刷新
//        }else{
//            NSLog(@"00000");
//            UrlAddress *url=[UrlAddress new];
//            url.cityname=@"待添加";
//            [_arraycoumy addObject:url];
//            [_Community addObject:url];
//        }
//    } else if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req3"]){
//        [_Community removeAllObjects];
//        if ([[dic objectForKey:@"status"] intValue]==1) {
//            NSArray *arr= [dic objectForKey:@"data"];
//            for (int i=0; i<[arr count]; i++) {
//                UrlAddress *url=[UrlAddress new];
//                url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
//                url.groupname=[[arr objectAtIndex:i]objectForKey:@"groupname"];
//                if ([[arr objectAtIndex:i] objectForKey:@"GroupImage"]==NULL) {
//                     url.GroupImage=@"http://222.247.37.152/photofile/0731/07310101/0731010100100001.jpg";
//                    
//                }
//                else{
//                   url.GroupImage=[[arr objectAtIndex:i] objectForKey:@"GroupImage"];}
//                NSLog(@"==%@===%@",url.GroupImage,[[arr objectAtIndex:i] objectForKey:@"GroupImage"]);
//                [ _Community addObject:url];
//            }
//        }else {
//            UrlAddress *url=[UrlAddress new];
//            url.cityname=@"待添加";
//            [_Community addObject:url];
//        }
//        [_activityViewLoad stopAnimating];
//        [_Tablecommunity reloadData];
//    }else if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req4"]){
//      NSLog(@"%@=======",strData);
//        NSDictionary *dic=[strData JSONValue];
//         [_activityViewLoad stopAnimating];
//        if ( [[dic objectForKey:@"status"]intValue]==1) {
//            _Mycommunity=[NSMutableArray new];//初始化一个数组
//            NSArray *arr=[dic objectForKey:@"data"];
//            for (int i=0; i<[arr count]; i++) {
//                 UrlAddress *url=[UrlAddress new];
//               url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
//                url.groupname=[[arr objectAtIndex:i] objectForKey:@"groupname"];
//                url.GroupImage=[[arr objectAtIndex:i] objectForKey:@"GroupImage"];
//                url.remark=[[arr objectAtIndex:i]objectForKey:@"remark"];
//                [_Mycommunity addObject:url];
//                [url release];
//                NSLog(@"%d",[_Mycommunity count]);
//            }
//            _searchTable.hidden=NO;
//            [_searchTable reloadData];}else{
//                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该小区还没添加或用户输入错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
//                [alert release];
//            }
//    }else if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req5"]){
//
//        if ( [[dic objectForKey:@"status"]intValue]==1) {
//            _recommended=[NSMutableArray new];//初始化一个数组
//            NSArray *arr=[dic objectForKey:@"data"];
//            for (int i=0; i<[arr count]; i++) {
//                UrlAddress *url=[UrlAddress new];
//                url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
//                url.groupname=[[arr objectAtIndex:i] objectForKey:@"groupname"];
//                url.GroupImage=[[arr objectAtIndex:i] objectForKey:@"GroupImage"];
//                url.remark=[[arr objectAtIndex:i]objectForKey:@"remark"];
//                [_recommended addObject:url];
//                [url release];
//               
//            } NSLog(@"%d===",[_recommended count]);
//                [_Tablecommunity reloadData];
//                [_activityViewLoad stopAnimating];
//        }
//    }
//     }else{
//         NSLog(@"返回数据类型问题");
//     }
//    
}

#pragma mark =======
-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ====tableView
//块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    if (tableView==_Tablecommunity) {

        return 2;
    }else{
        return 1;
    }
       return nil;
}
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return 0;
}

//块头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==_Tablecommunity) {
        if (section==0||section==1) {
         return 30;
    }
        return 5;
    }else{
        return 0;
    }
    return 0;
}
//设置每块section的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
      if (tableView==_Tablecommunity) {
    if (section==0) {
        return @"我的小区";
    } else if (section==1){
    return @"推荐小区";
    }
   else{
        return nil;
   }}
    return nil;
}
//每个cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
         return 80;
  
}
//每块的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_Tablecommunity) {
        if (section==0) {
            return [_arraycoumy count];
        }else if (section==1)
        {
            return [_recommended count];
        }
        return 1;
  }
else if (tableView==_searchTable){
        return [_Mycommunity count];
    }
    return 1;
 
}
//每个cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (tableView==_Tablecommunity) {
            static NSString *CellIdentifier = @"Cell1";
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell =[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
                //头名
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40,0,320-60,30)];
                label.font=[UIFont systemFontOfSize:15];
                label.backgroundColor=[UIColor clearColor];
                label.tag=1;
                [cell.contentView addSubview:label];
                //内容
                UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40,20, 320-60,60)];
                label1.tag=2;
                label1.font=[UIFont systemFontOfSize:14];
                //            label1.lineBreakMode=UILineBreakModeWordWrap;
                label1.numberOfLines=2;
                label1.backgroundColor=[UIColor clearColor];
                [cell.contentView addSubview:label1];
                //时间
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(320-80,62,80, 20)];
                label2.tag=3;
                label2.font=[UIFont systemFontOfSize:14];
                label2.backgroundColor=[UIColor clearColor];
                [cell.contentView addSubview:label2];
                AsyncImageView *imagev=[[AsyncImageView alloc]initWithFrame:CGRectMake(0,20,40, 40)];
                imagev.tag=4;
                [cell.contentView addSubview:imagev];
                [imagev release];
                [label release];
                [label1 release];
                [label2 release];
            }
       if (indexPath.section==0) {
            UrlAddress *url=(UrlAddress*)[_arraycoumy objectAtIndex:indexPath.row];
           UILabel *label= (UILabel*) [cell viewWithTag:1];
           label.text=url.groupindex;
           UILabel *label1=(UILabel*)[cell viewWithTag:2];
           label1.text=url.groupname;
           AsyncImageView *asy =(AsyncImageView*)[cell viewWithTag:4];
           asy.urlString=url.GroupImage;
        return cell;
       }else if (indexPath.section==1){
           UrlAddress *url=(UrlAddress*)[_recommended objectAtIndex:indexPath.row];
           UILabel *label= (UILabel*) [cell viewWithTag:1];
           label.text=url.groupindex;
           UILabel *label1=(UILabel*)[cell viewWithTag:2];
           label1.text=url.groupname;
           AsyncImageView *asy =(AsyncImageView*)[cell viewWithTag:4];
           asy.urlString=url.GroupImage;
           return cell;
       }
            return cell;
        
   }else if(tableView ==_searchTable){

       static NSString *CellIdentifier = @"Cell2";
       UITableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (Cell==nil) {
           Cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
           //头名
           UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40,0,320-60,30)];
           label.font=[UIFont systemFontOfSize:15];
           label.backgroundColor=[UIColor clearColor];
           label.tag=1;
           [Cell.contentView addSubview:label];
           //内容
           UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40,20, 320-60,60)];
           label1.tag=2;
           label1.font=[UIFont systemFontOfSize:14];
           //            label1.lineBreakMode=UILineBreakModeWordWrap;
           label1.numberOfLines=2;
           label1.backgroundColor=[UIColor clearColor];
           [Cell.contentView addSubview:label1];
           //时间
           UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(320-80,62,80, 20)];
           label2.tag=3;
           label2.font=[UIFont systemFontOfSize:14];
           label2.backgroundColor=[UIColor clearColor];
           [Cell.contentView addSubview:label2];
           AsyncImageView *imagev=[[AsyncImageView alloc]initWithFrame:CGRectMake(0,20,40, 40)];
           imagev.tag=4;
           [Cell.contentView addSubview:imagev];
       }
       UrlAddress *url=((UrlAddress *)[_Mycommunity objectAtIndex:indexPath.row]);
       UILabel *label= (UILabel*) [Cell viewWithTag:1];
       label.text=url.groupindex;
       UILabel *label1=(UILabel*)[Cell viewWithTag:2];
       label1.text=url.groupname;
         AsyncImageView *asy =(AsyncImageView*)[Cell viewWithTag:4];
         asy.urlString=url.GroupImage;
       return Cell;
   }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ResidentialIntroducedViewController *demo=[[ResidentialIntroducedViewController alloc]init];
     if (tableView==_Tablecommunity) {
         if (indexPath.section==0) {//我的小区
               demo.strname=[_arraycoumy objectAtIndex:indexPath.row];//传对象
         }else if (indexPath.section==1)//推荐小区
         {
          demo.strname=[_recommended objectAtIndex:indexPath.row];//传对象
         }
       
        }
     else if (tableView==_searchTable){
      demo.strname=[_Mycommunity objectAtIndex:indexPath.row];//传对象
     }
    [self.navigationController pushViewController:demo animated:YES];//push 下一个页面
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    
//    self.isOpen = firstDoInsert;
//    Cell1 *cell = (Cell1 *)[_Tablecommunity cellForRowAtIndexPath:self.selectIndex];
//    [cell changeArrowWithUp:firstDoInsert];
//    [_Tablecommunity beginUpdates];
//    int section = self.selectIndex.section;
//   /*
//    请求点击cell数据
//    */
//    NSString *str=((UrlAddress *)[_arraycoumy objectAtIndex:section]).sitecode;
//     NSLog(@"%@===1=sitecode",str);
//    [self  community: str];
//    int contentCount = [_Community count];
//   	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];//创建一个容器
//    NSLog(@"%d===",contentCount);
//	for (NSUInteger i = 1; i < contentCount + 1; i++) {
//		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
//		[rowToInsert addObject:indexPathToInsert]; 
//	}
//	if (firstDoInsert)
//    {
//         NSLog(@"firstDoInsert=yes");
//        [_Tablecommunity insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationLeft];
//    }
//	else
//    {    NSLog(@"firstDoInsert=no");
//       
//        [_Tablecommunity deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationRight]; //删除
//        [_Community removeAllObjects];
//    }
//	[_Tablecommunity endUpdates];
//    if (nextDoInsert) {
//        NSLog(@"nextDoInsert=yes");
//        self.isOpen = YES;
//        [_Community removeAllObjects];
//        self.selectIndex = [_Tablecommunity indexPathForSelectedRow];
//        [self didSelectCellRowFirstDo:YES nextDo:NO];
//    }
//    if (self.isOpen) [_Tablecommunity scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end
