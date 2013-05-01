//
//  SecondViewController.m
//  Test04
//
//  Created by HuHongbing on 9/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize tableView = _tableView;
@synthesize headViewArray;

-(void)dealloc{
    [super dealloc];
   _search =nil;
    headViewArray=nil;
_tableView=nil;//显示公告的tabel
   _message=nil;//小区公告信息
 _array=nil;//显示城市数组
   _arraycoumy=nil;//显示城市区数组
  _Community=nil;//存放社区名字
  _activityViewLoad=nil;
   _ddList=nil;//搜索条时出现的小tableview
   _searchStr=nil;
}
#pragma mark  search下提示框
- (void)setDDListHidden:(BOOL)hidden {
	NSInteger heightone = hidden ? 0 : 180;//如果为假就 高度为0；如果为真就为180
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.2];
	[_ddList.view setFrame:CGRectMake(30, 36+40, 200, heightone)];
	[UIView commitAnimations];
}
#pragma mark PassValue protocol
- (void)passValue:(NSString *)value andaddress:(UrlAddress *)address{
	if (value) {
//		_search.text = value;
//		[self searchBarSearchButtonClicked:_search];
        _search.text= address.groupname;
        NSString *STR=[value substringFromIndex:1];
        [self requestannouncement:STR andsearch:YES];
	}
	else {
		NSLog(@"=代理==传值失败");
	}
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
  
    [self setDDListHidden:YES];
    [_search resignFirstResponder];
    _search.text=@"";
    
}
//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self setDDListHidden:YES];
//	_searchStr = [searchBar text];
	[searchBar resignFirstResponder];
    [searchBar resignFirstResponder];
    
}

//当searchBar里 的类容将要发生变化时调用该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%s",__FUNCTION__);
	if ([searchText length] != 0) {
         [self searchcommunity:searchBar.text];
				
	}
	else {
		[self setDDListHidden:YES];
	}
    
}
//搜索小区请求
-(void)searchcommunity:(NSString *)search{
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetPropertyAllForName"];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:search forKey:@"strName"];
    PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req5" forKey:@"name"];
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
}

#pragma mark ====
- (void)viewDidLoad
{
     c=0;

    [super viewDidLoad];

     //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        height=460;
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
    username.text=@"小区公告";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadModel];    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(-10,44+35,340,height-88-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    [self loadMoreFooterInit];//添加上提视图
    [self EGORefreshloadMoreFooterInit];//添加下拉刷新
    _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 80-40, 320, 40)];
    _search.barStyle=UIBarStyleBlackTranslucent;//设置样式
    _search.delegate=self;
    _search.placeholder=@"搜索你要的小区公告";
    [self.view addSubview:_search];
      [self loginrequeset:@"07"];
    _activityViewLoad = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityViewLoad.frame = CGRectMake(0, 0,20, 20);
    _activityViewLoad.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:_activityViewLoad];
    _array=[[NSMutableArray alloc]init];
	_arraycoumy=[[NSMutableArray alloc]init];
    _Community=[[NSMutableArray alloc]init];
    _message=[[NSMutableArray alloc]init];
    [backImage release];
    [navigation release];
    [username release];
    
	_ddList = [[DDList alloc] initWithStyle:UITableViewStylePlain];
	_ddList._delegate = self;
	[self.view addSubview:_ddList.view];
	[_ddList.view setFrame:CGRectMake(30, 40+40, 200, 0)];//seachbar下面的tabelview 是自定义的

    //小区显示视图
    _searchTable=[[UITableView alloc]initWithFrame:CGRectMake(0,44+35, 320, height-88-30) style:UITableViewStyleGrouped];
    _searchTable.dataSource=self;
    _searchTable.delegate=self;
    _searchTable.hidden=YES;
    [self.view addSubview:_searchTable];

}
#pragma mark ASIHTTPDelegate
//获取市区列表请求
-(void)loginrequeset:(NSString *)str{
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetCityData"];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:str forKey:@"sitecode"];
    PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req1" forKey:@"name"];
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
}
//区县请求
-(void)AreaCounty:(NSString *)community{
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetAreaData"];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:community forKey:@"sitecode"];
    PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req2" forKey:@"name"];
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
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
//请求每个区里的详细公告
-(void)requestannouncement:(NSString *)sender andsearch:(BOOL *)search
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetUserPublicInfo"]];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:sender forKey:@"groupindex"];
//    NSLog(@"[[[[[[[[%@",sender);
    NSString *strreq=nil;
    if (search) {
        strreq=@"req6";
//        NSLog(@"[[[[[[[[%@",sender); //73101010001
    }else{

        strreq=@"req4";
       }
    PostRequst.userInfo=[NSDictionary dictionaryWithObject:strreq forKey:@"name"];//传一个字典用于标示是区分结果是这个请求发送的
    PostRequst .delegate=self;
    [PostRequst  startAsynchronous];
    [PostRequst release];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [_activityViewLoad startAnimating];//开始
    NSString *strData=[[NSString alloc]initWithData:   [request responseData] encoding:NSUTF8StringEncoding];
     NSDictionary *dic=[strData JSONValue];
    
    NSLog(@"---33333--------");
     if ([dic isKindOfClass:[NSDictionary class]] ) {
    if ([[request.userInfo objectForKey:@"name"] isEqualToString:@"req1"]) {
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
            NSLog(@"%s",__FUNCTION__);
        }
    }else if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req2"]){
        [_arraycoumy removeAllObjects];
        [_Community removeAllObjects];
        if ([[dic objectForKey:@"status"] intValue]==1) {
            //            NSLog(@"===%@===",dic);
            NSArray *arr= [dic objectForKey:@"data"];
            for (int i=0; i<[arr count]; i++) {
                UrlAddress *url=[UrlAddress new];
                url.sitecode= [[arr objectAtIndex:i] objectForKey:@"sitecode"];
                url.cityname=[[arr objectAtIndex:i]objectForKey:@"areaname"];
                [_arraycoumy addObject:url];
            }NSLog(@"%d=====",[_arraycoumy count]);
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
    } else if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req3"]){
        [_Community removeAllObjects];
        if ([[dic objectForKey:@"status"] intValue]==1) {
        //    NSLog(@"===%@===",dic);
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
          _currentRow = -1;
          
            headViewArray = [[NSMutableArray alloc]init ];
          for (int i=0; i<[_Community count]; i++) {
              HeadView* headview = [[HeadView alloc] init];
           headview.delegate = self;
     		headview.section = i;
            headview.backBtn.titleLabel.text =(( UrlAddress *)[_Community objectAtIndex:i]).cityname;
           [headview.backBtn setTitle:headview.backBtn.titleLabel.text forState:UIControlStateNormal];
         headview.backImage.image=[UIImage imageNamed:@"DownAccessory"];
            [self.headViewArray addObject:headview];
            }
        [_activityViewLoad stopAnimating];
        [_tableView reloadData];
    }else  if ([[request.userInfo objectForKey:@"name"] isEqualToString:@"req4"]){
//        NSLog(@"----------66666-");
        NSLog(@"%@",dic);
        NSArray *arr= [dic objectForKey:@"data"];
        _Mycommunity=[NSMutableArray new];
        for (int i=0; i<[arr count]; i++) {
            UrlAddress *url=[UrlAddress new];
            url.sitecode= [[arr objectAtIndex:i] objectForKey:@"titleinfo"];
            url.cityname=[[arr objectAtIndex:i]objectForKey:@"infoclass"];
            [_message addObject:url];
            [_Mycommunity addObject:url];
        }
        [_activityViewLoad stopAnimating];
            _tableView.hidden=NO;
            [_tableView reloadData];
    }else   if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req5"]){
        NSLog(@"%@=======",strData);
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
                _ddList._resultList = _Mycommunity; //给下拉框附值 数组存的对象
                [_ddList updateData];//刷新表视图
                [self setDDListHidden:NO];//不隐藏
                 [_activityViewLoad stopAnimating];
            }
        }else{
            [self setDDListHidden:YES];//隐藏
          }
    }else  if ([[request.userInfo objectForKey:@"name"] isEqualToString:@"req6"]) {
         NSArray *arr= [dic objectForKey:@"data"];
        NSLog(@"-==-=-=data%@",dic);
         _Mycommunity=[NSMutableArray new];
         for (int i=0; i<[arr count]; i++) {
             UrlAddress *url=[UrlAddress new];
             url.sitecode= [[arr objectAtIndex:i] objectForKey:@"titleinfo"];
             url.cityname=[[arr objectAtIndex:i]objectForKey:@"infoclass"];
             [_Mycommunity addObject:url];
         }
        NSLog(@"================%d",[_Mycommunity count]);
         [_activityViewLoad stopAnimating];
         _tableView.hidden=YES;
         _searchTable.hidden=NO;
         [_searchTable reloadData];
    }}
    else{
         NSLog(@"返回数据类型");
     }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark ---

-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadModel{
//    _currentRow = -1;
//    NSArray *arr=[[NSArray alloc]initWithObjects:@"雨花区",@"芙蓉区", nil];
//    headViewArray = [[NSMutableArray alloc]init ];
//    for (int i=0; i<2; i++) {
//        HeadView* headview = [[HeadView alloc] init];
//        headview.delegate = self;
//		headview.section = i;
//       headview.backBtn.titleLabel.text =[arr objectAtIndex:i];
//        [headview.backBtn setTitle:headview.backBtn.titleLabel.text forState:UIControlStateNormal];
//         headview.backImage.image=[UIImage imageNamed:@"DownAccessory"];
//        [self.headViewArray addObject:headview];
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _tableView= nil;
}

#pragma mark - TableViewdelegate&&TableViewdataSource

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_searchTable) {
        return 80;
    }else{
    if (indexPath.row==[_message count]) {
        return 40;
    }else{
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    return headView.open?80:0;
    }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_searchTable) {
        return nil;
    }else
    return [self.headViewArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_searchTable){
        return [_Mycommunity count];
    }else{
    HeadView* headView = [self.headViewArray objectAtIndex:section];
        return headView.open?[_message count]+1:0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_searchTable==tableView) {
        return 1;
    }else{
    return [self.headViewArray count];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==_searchTable){
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
    label.text=url.sitecode;
    UILabel *label1=(UILabel*)[Cell viewWithTag:2];
    label1.text=url.cityname;
    //       UILabel *label2=(UILabel*)[Cell viewWithTag:3];
    ////       label.text=url.group;
    AsyncImageView *asy =(AsyncImageView*)[Cell viewWithTag:4];
    asy.urlString=url.GroupImage;
    return Cell;
}else{
    static NSString *indentifier = @"cell";
    static NSString *celldictabc=@"cell2";
    if([indexPath row] == ([_message count])) {
        
         UITableViewCell *loadMoreCell=[tableView dequeueReusableCellWithIdentifier:celldictabc];
        if (loadMoreCell==nil) {
            loadMoreCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celldictabc];
        }
        loadMoreCell.textLabel.text=@"点击加载更多";
        loadMoreCell.textLabel.textAlignment=UITextAlignmentCenter;
        return loadMoreCell;
    }else{
        UITableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:indentifier ];
        if (Cell==nil) {
            Cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier ];
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
            label1.numberOfLines=2;
            label1.backgroundColor=[UIColor clearColor];
            [Cell.contentView addSubview:label1];
            //时间
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(320-80,62,80, 20)];
            label2.tag=3;
            label2.font=[UIFont systemFontOfSize:14];
            label2.backgroundColor=[UIColor clearColor];
            [Cell.contentView addSubview:label2];
//            UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0,20,40, 40)];
//            imagev.image=[UIImage imageNamed:@"文件"];
//            [Cell.contentView addSubview:imagev];
            UIView *view=[UIView new];
            view.backgroundColor=[UIColor grayColor];
            view.frame=CGRectMake(0, label1.frame.size.height+label2.frame.size.height, 340, 1);
            [Cell.contentView addSubview:view];
        }
        UILabel *label= (UILabel*) [Cell viewWithTag:1];
        NSLog(@"%d",[_message count]);
        label.text=((UrlAddress *)[_message objectAtIndex:indexPath.row]).sitecode;
       UILabel *label1=(UILabel*)[Cell viewWithTag:2];
       label1.text=((UrlAddress *)[_message objectAtIndex:indexPath.row]).cityname;
  //    Cell.selectionStyle=UITableViewCellEditingStyleNone; 没有点击效果
          UIView *viewback =[[UIView new]autorelease];
        [viewback setBackgroundColor:[UIColor whiteColor]];
        Cell.backgroundView=viewback;
        UIView  *view=[[UIView new] autorelease];
        view.backgroundColor=[UIColor lightGrayColor];
           Cell.selectedBackgroundView=view;
   //-(void)prepareForReuse 去重用
        return Cell;
    }}
       return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];//选中有背景颜色 离开后背景消失
    if (indexPath.row==[_message count]) {
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        [_tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }else{
        UrlAddress *url=nil;
        if (_searchTable==tableView) {
              url=(UrlAddress *)[_Mycommunity objectAtIndex:indexPath.row];
        }else{
           url=(UrlAddress *)[_message objectAtIndex:indexPath.row];
        }
        DetailViewController *detail=[[DetailViewController alloc]init];
        detail.titleStr=url.sitecode;
        detail.DetailsubtitlStr=url.cityname;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
#pragma mark ---
#pragma mark more
-(NSMutableArray*)reqesttype:(NSString *)string andpage:(NSString*)page
{
    NSString *str=[NSString stringWithFormat:@"http://123.139.154.21/test/getCommunityInformation.aspx?page=%@&cid=%d",page,_currentSection];
    NSURL *url=[NSURL URLWithString:str];//组装成URL
    NSURLRequest *request=[NSURLRequest requestWithURL:url];//发送请求
    NSData *reledata=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSMutableString *JSONStr=[[NSMutableString alloc]initWithData:reledata encoding:NSUTF8StringEncoding];
    return  [JSONStr JSONValue];
}

//加载数据的方法:
-(void)loadMore
{
    //    c++;
//    loadMoreFooterVIew.hidden=YES;//隐藏
//    NSMutableArray *more=[self reqesttype:nil andpage:[NSString stringWithFormat:@"%d",c]];//    NSLog(@"asfdasf%@",more);
////加载你的数据
//[self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO];
}//添加数据到列表:
-(void) appendTableWith:(NSMutableArray *)data
{    
//    for (int i=0;i<[data count];i++) {
//        [_titlArray addObject:[data objectAtIndex:i]];
//    }
//    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc]init];
//    for (int ind = 0; ind < [data count]; ind++) {
//        NSIndexPath    *newPath =  [NSIndexPath indexPathForRow:[_titlArray indexOfObject:[data objectAtIndex:ind]] inSection:_currentSection];
//        [insertIndexPaths addObject:newPath];
//    }
//    [_tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    [_tableView reloadData];
    
}
#pragma mark --
#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
     NSLog(@"=====ssssss======");
    _currentRow = -1;
    if (view.open) { //如果视图有展开
        for(int i = 0;i<[self.headViewArray count];i++)
        {
            HeadView *head = [self.headViewArray objectAtIndex:i];
            head.open = NO;
            head.backImage.image=[UIImage imageNamed:@"DownAccessory"];
             }
        [_message removeAllObjects];//删除数组里的元素
        [_tableView setSeparatorColor:[UIColor clearColor]];//隐藏分割线
        NSLog(@"============");
        [_tableView reloadData];
        return;
    }
    _currentSection = view.section;
    [self reset];//没展开
    
}

//界面重置
- (void)reset
{
     c=1;
    for(int i = 0;i<[headViewArray count];i++)
    {
        HeadView *head = [self.headViewArray objectAtIndex:i];
        if(head.section == _currentSection)
        {
            head.open = YES; //点的当前的块头处于打开  显示子菜单里的内容
             head.backImage.image=[UIImage imageNamed:@"UpAccessory"];
            NSString *str=[((UrlAddress *)[_Community objectAtIndex:head.section]).sitecode substringFromIndex:0];
            [self requestannouncement:str andsearch:NO];//点击按钮加载该小区的信息
            
        }else {
              head.open = NO; //块头先处于关闭
             head.backImage.image=[UIImage imageNamed:@"DownAccessory"];
        }
        NSLog(@"=======22222=====");
    }
    [_tableView reloadData];
}
#pragma mark  ---
-(void)loadMoreFooterInit{
    
    if (loadMoreFooterVIew == nil) {
        LoadMoreTableFooterView *FooterView =[[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0.0f,_tableView.contentSize.height, _tableView.frame.size.width, _tableView.bounds.size.height)];
        FooterView .delegate=self;
        [_tableView addSubview:FooterView];
        loadMoreFooterVIew=FooterView;
}
    
}
#pragma mark Data Source Loading / Reloading Methods
-(void)reloadTableViewDataSource
{
    //应该调用你的tableviews数据源模型来加载
    //把这里只是为了演示
    reloading=YES;
}
-(void)doneLoadingTableViewData
{//模型应该调用这个当其加载完成
    [self loadMore];
    reloading=NO;
    [loadMoreFooterVIew loadMoreScrollViewDataSourceDidFinishedLoading: _tableView];
 }
#pragma mark -
#pragma mark UIScrollViewDelegate Methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{ 
    [loadMoreFooterVIew loadMoreScrollViewDidScroll:scrollView];
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];

    [loadMoreFooterVIew loadMoreScrollViewDidEndDragging: scrollView];
}
#pragma mark -
#pragma mark LoadMoreTableFooterDelegate Methods
-(void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view
{
    
    [self reloadTableViewDataSource];
    if ([_Community count]>0) {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
      }
        
}
-(BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view
{    

    return reloading;
}


#pragma mark ---
//下拉刷新
-(void)EGORefreshloadMoreFooterInit{
if (refreshHeaderView==nil) {
    EGORefreshTableHeaderView *view1=[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, 0.0f-_tableView.bounds.size.height, self.view.frame.size.width,_tableView.bounds.size.height)];
    view1.delegate=self;//设置代理
    [_tableView addSubview:view1];
    refreshHeaderView=view1;
  }
}
#pragma mark EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self egoRefreshreloadTableViewDataSource];
    [self performSelector:@selector(egoRefreshdoneLoadingTableViewData) withObject:nil afterDelay:3.0];//延迟调用
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return reloading;
}
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}
#pragma mark Data Source Loading / Reloading Methods
-(void)egoRefreshreloadTableViewDataSource
{
    NSLog(@"==开始加载数据");
    reloading=YES;
    [self requestannouncement:nil andsearch:NO];// 发起请求
}
-(void)egoRefreshdoneLoadingTableViewData
{
  
    NSLog(@"===加载完数据");
    reloading=NO;
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
}

@end
