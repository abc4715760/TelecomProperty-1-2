//
//  CommunityViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "CommunityViewController.h"
#import "GoodFriendViewController.h"
#import "People.h"
#import "DemoViewController.h"
#import "ChatViewController.h"
#import "Zhongwenpaixu.h"
#import "String.h"
#import "SectionABC.h"
#import "Section.h"

#import "Cell2.h"
#import "Cell1.h"
@interface CommunityViewController ()
@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *selectIndex;
@property (nonatomic,retain)NSArray *arr;
@end

@implementation CommunityViewController
@synthesize isOpen,selectIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    CusotomViewController *tabBarController = (CusotomViewController *)self.tabBarController;
    [tabBarController showTabBar]; //显示tabbar
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        backImage.frame=CGRectMake(0,0, 320, 480);
    }
    else
    {
        backImage.frame=CGRectMake(0,0, 320, 548);
    }
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"我的社区";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 44, 320, 40)];
    label.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:label];
    
    UIButton *recentlyBut=[UIButton buttonWithType:0];
    recentlyBut.frame=CGRectMake(0,44,80,40);
    [recentlyBut setTitle:@"最近" forState:UIControlStateNormal];
    [recentlyBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [recentlyBut addTarget:self action:@selector(Recently:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recentlyBut];
    
    
    UIButton *community=[UIButton buttonWithType:0];
    community.frame=CGRectMake(80+80,44,80,40);
    [community setTitle:@"小区群" forState:UIControlStateNormal];
     [community setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   [community addTarget:self action:@selector(communityaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:community];
       
    UIButton * Good=[UIButton buttonWithType:0];
    Good.frame=CGRectMake(80,44,80 ,40);
    [Good setTitle:@"好友" forState:UIControlStateNormal];
    [Good setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Good addTarget:self action:@selector(Goodaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Good];    
    UIButton *Group=[UIButton buttonWithType:0];
    Group.frame=CGRectMake(160+80, 44, 80, 40);
    [Group setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Group setTitle:@"添加群" forState:UIControlStateNormal];
    [Group addTarget:self action:@selector(groupaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Group];
    
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 84, 320, 460-44-44-40)];
    _scrollView.scrollEnabled=YES;//是否可以滚动
    _scrollView.indicatorStyle=UIScrollViewIndicatorStyleBlack;//设置滚动条的样式
    _scrollView.delegate=self;
    _scrollView.showsHorizontalScrollIndicator=YES;//显示水平滚动条
    _scrollView.showsVerticalScrollIndicator=NO;//不显示垂直滚动条
    _scrollView.bounces=YES;//滚动超出边界 反弹效果
    _scrollView.pagingEnabled=YES;//是否滚动到subview的边界 这个属性值也是设置划一屏
    _scrollView.contentSize=CGSizeMake(320*4, _scrollView.frame.size.height);//设置滚动视图的内容大小
    [self.view addSubview:_scrollView];
    
     //最近联系人显示视图
    _RecentlyTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, _scrollView.frame.size.height)];
    _RecentlyTable.dataSource=self;
    _RecentlyTable.delegate=self;
    _RecentlyTable.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_RecentlyTable];
    //小区显示视图
    _Tablecommunity=[[UITableView alloc]initWithFrame:CGRectMake(640, 0, 320, _scrollView.frame.size.height)];
    _Tablecommunity.dataSource=self;
    _Tablecommunity.delegate=self;
    _Tablecommunity.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_Tablecommunity];
    //好友显示视图
    _TableGoodfriend=[[UITableView alloc]initWithFrame:CGRectMake(320,0,320,_scrollView.frame.size.height) ];
    _TableGoodfriend.dataSource=self;
    _TableGoodfriend.delegate=self;
    _TableGoodfriend.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:_TableGoodfriend];
    //显示选着地址
    _picker=[[UIPickerView alloc]initWithFrame:CGRectMake(640+320, 59, 320, 216)];
    _picker.dataSource=self;
    _picker.delegate=self;
    _picker.showsSelectionIndicator=YES;
    [_scrollView addSubview:_picker];
    _lablecommuct=[[UILabel alloc]initWithFrame:CGRectMake(640+320, 5, 320, 40)];
    [_scrollView addSubview:_lablecommuct];

//    _tablegroup=[[UITableView alloc]initWithFrame:CGRectMake(640+320,0,320,_scrollView.frame.size.height)];
//    _tablegroup.dataSource=self;
//    _tablegroup.delegate=self;
//    [_scrollView addSubview:_tablegroup];
//    _tablegroup.backgroundColor=[UIColor clearColor];
//    _ArrayGroup=[[NSMutableArray alloc]initWithObjects:@"116小区",@"18890小区",@"电信小区",nil];
//    _namearray=[[NSMutableArray alloc]init];//初始化一个数组
//    for (int i=0; i<[_MutableArray count]; i++) {
//        [_namearray addObject:((String *)[[Zhongwenpaixu zhongWenPaiXu:_MutableArray] objectAtIndex:i]).string];
//    }
//   _pingfirst=[SectionABC zhongWenPaiXu:_namearray]; //取出对应的拼音首字母数组  赋值
//   
//    for (NSString *str in _pingfirst) {
//        NSLog(@"---=%@==",str);
//    }
//    _dictionary=[[NSMutableDictionary alloc]init];
//    _dictionary=[Section SectionZiMu:_namearray];// 字典里存的K 是拼音的首字母 value是名字
  _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,_scrollView.frame.origin.y-5,80,4)];
    _imageView.image=[UIImage imageNamed:@"内线"];
    [self.view addSubview:_imageView];
    
    [self Recently:nil];//开始进来默认调用最近联系人的信息
}

#pragma mark UIPickerViewDataSource pickerView的几个协议

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 3;
	}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
	if (component==0) {
		return [[_MutableDict objectForKey:@"city"] count];
//        NSLog(@"-------%d=======",[[_MutableDict objectForKey:@"city"] count]);
	} else if (component==1) {
       return  [[_MutableDict objectForKey:@"county"] count];
		//划分picker中有多少行
	}else if (component==2) {
//        NSLog(@"]]]]]]]]]]]]]]]]]]%d",[[_MutableDict objectForKey:_strcity] count]);
//        NSLog(@"%@=",_strcity);
       return [[_MutableDict objectForKey:_strcity] count];
	}
	return	YES;

}
//在picker中输出内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	if (component==0) {
        
        return [[_MutableDict objectForKey:@"city"] objectAtIndex:row]; //取出第一项的内容
	}else if (component==1) {
      	 return  [[_MutableDict objectForKey:@"county"] objectAtIndex:row];
	}else if (component==2)
	{
         return  [[_MutableDict objectForKey:_strcity] objectAtIndex:row];
    }
	
	return nil;
	
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if (component==0) {
//        NSLog(@"%@====",[self  pickerView:pickerView titleForRow:row forComponent:component]);
        _strcity0=[self  pickerView:pickerView titleForRow:row forComponent:component];
        
        _strcity=[[_MutableDict objectForKey:@"county"] objectAtIndex:0];//当第一项改变时，第二项始终取数组的第一位
            _strcity1=[[_MutableDict objectForKey:_strcity] objectAtIndex:0];//当第2项改变时第3项始终取该数组的第一位
        [pickerView selectRow:0 inComponent:1 animated:YES];//指定第2项第一行
         [pickerView reloadComponent:1];//更新
        [pickerView selectRow:0 inComponent:2 animated:YES];//指定第3项第一行
        [pickerView reloadComponent:2];//更新
    }else if (component==1) {
          
        _strcity=[self  pickerView:pickerView titleForRow:row forComponent:component];
        _strcity1=[[_MutableDict objectForKey:_strcity] objectAtIndex:0];//当第2项改变时第3项始终取该数组的第一位
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];

    }else if(component==2){
        _strcity1=[self  pickerView:pickerView titleForRow:row forComponent:component];
//        NSLog(@"str2===%@",_strcity1);
    }
    _lablecommuct.text=[NSString stringWithFormat:@"地址 :%@ -%@ -%@",_strcity0,_strcity,_strcity1];

}

-(void)segmentaction:(UISegmentedControl*)sender
{
    UISegmentedControl *segmet=(UISegmentedControl*)sender;
    switch (segmet.selectedSegmentIndex) {
        case 0:{
       [self  Recently:nil];
        }
            break;
        case 1:{
            [self Goodaction:nil];
            
        }
             break;
        case 2:{
            [ self  communityaction:nil];
        }
            break;
        case 3:{
            [self groupaction:nil];
        }
            break;
      
        default:
            break;
    }
}
#pragma mark four pages methods
-(void)Recently:(id)sender
{
     _imageView.frame=CGRectMake(0,_imageView.frame.origin.y ,_imageView.frame.size.width ,_imageView.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(0, 0)animated:YES];
    _RecentlyArray=[[NSMutableArray alloc]init];
    NSArray *arrayname=[[NSArray alloc]initWithObjects:@"邓成其",@"付小伟",@"刘旺星",nil];
    NSArray *arraysignature=[[NSArray alloc]initWithObjects:@"一直走，不回头，我却不知不觉弄丢了你。",@"我说过，都是我自己的事情，所以你只要知道就好。",@"我只是想说出自己的心情、并不是为了要别人评论。",nil];
    NSArray *imageArray=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"deng.png"],[UIImage imageNamed:@"fu.png"],[UIImage imageNamed:@"liu.png"], nil];
    for (int i=0; i<3; i++) {
        People  *people=[[People alloc]init];
        people.name=[arrayname objectAtIndex:i];
        people.signature=[arraysignature objectAtIndex:i];
        people.image=[imageArray objectAtIndex:i];
        [_RecentlyArray addObject:people];
//        NSLog(@"%d------",[_RecentlyArray count]);
    }
 
    [_RecentlyTable reloadData];
}
-(void)communityaction:(id)sender
{
   _imageView.frame=CGRectMake(80*2,_imageView.frame.origin.y ,_imageView.frame.size.width ,_imageView.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(640,0) animated:YES];
    _RecentlyArray=[[NSMutableArray alloc]init];
    NSArray *arrayname=[[NSArray alloc]initWithObjects:@"邓成其",@"付小伟",@"刘旺星",nil];
    NSArray *arraysignature=[[NSArray alloc]initWithObjects:@"一直走，不回头，我却不知不觉弄丢了你。",@"我说过，都是我自己的事情，所以你只要知道就好。",@"我只是想说出自己的心情、并不是为了要别人评论。",nil];
    NSArray *imageArray=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"deng.png"],[UIImage imageNamed:@"fu.png"],[UIImage imageNamed:@"liu.png"], nil];
    for (int i=0; i<3; i++) {
        People  *people=[[People alloc]init];
        people.name=[arrayname objectAtIndex:i];
        people.signature=[arraysignature objectAtIndex:i];
        people.image=[imageArray objectAtIndex:i];
        [_RecentlyArray addObject:people];
       
    }
   _Arraycommunity=[[NSMutableArray alloc]init];
    _arr=[[NSArray alloc]initWithObjects:@"雨花区0",@"雨花区1", nil];
    
    for (int i=0; i<[_arr  count]; i++) {
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:_RecentlyArray forKey:[_arr objectAtIndex:i]];
        [_Arraycommunity addObject:dict];
    }
  
    [_Tablecommunity reloadData];
}
-(void)groupaction:(id)sender
{
    NSArray *city=[[NSArray alloc]initWithObjects:@"长沙市", nil];
    NSArray *county=[[NSArray alloc]initWithObjects:@"芙蓉区",@"天心区",@"雨花区", nil];
    NSArray *community1=[[NSArray alloc]initWithObjects:@"滩头坪社区服务中心",@"五里牌社区服务中心 ",@"马王堆街道",@"荷晏社区服务中心" ,nil];
    NSArray *community2=[[NSArray alloc]initWithObjects:@"吴家坪社区服务中心",@"青园街道友谊社区居委会 ",@"仰天湖社区" ,nil];
     NSArray *community3=[[NSArray alloc]initWithObjects:@"雨花区社区学院",@"韶山路 ",@"长塘里" ,nil];
    _MutableDict=[[NSMutableDictionary alloc]init];
    [_MutableDict setObject:city forKey:@"city"];
    [_MutableDict setObject:county forKey:@"county"];
    NSArray *arr=[[NSArray alloc]initWithObjects:community1,community2,community3, nil];

    for (int i=0; i<[[_MutableDict  objectForKey:@"county" ] count]; i++) {
        [_MutableDict  setObject:[arr objectAtIndex:i] forKey:[[_MutableDict  objectForKey:@"county" ]  objectAtIndex:i]];
    }
    _strcity=[[_MutableDict objectForKey:@"county"]objectAtIndex:0];//设一个全局的字符串，用来pickView第一次运行 第3三取值
    
    _imageView.frame=CGRectMake(80*3,_imageView.frame.origin.y ,_imageView.frame.size.width ,_imageView.frame.size.height);//按钮下面的线随点击的按钮位置移动
    
    [_scrollView setContentOffset:CGPointMake(640+320,0) animated:YES];
    [_picker reloadAllComponents];//更新
    _strcity0=[[_MutableDict objectForKey:@"city"] objectAtIndex:0];
    _lablecommuct.text=[NSString stringWithFormat:@"地址 :%@ -%@ -%@",_strcity0,_strcity,[[ _MutableDict objectForKey: _strcity]objectAtIndex:0]];
//   NSLog(@"=================%@",[[ _MutableDict objectForKey: _strcity]objectAtIndex:0]);
}
-(void)Goodaction:(id)sender
{
   _imageView.frame=CGRectMake(80,_imageView.frame.origin.y ,_imageView.frame.size.width ,_imageView.frame.size.height);
    [_scrollView  setContentOffset:CGPointMake (320,0) animated:YES];
  
    _MutableArray=[[NSMutableArray alloc]init];
    NSArray *arrayname1=[[NSArray alloc]initWithObjects:@"付晓伟",@"邓成其",@"刘旺星",@"刘小三",@"付大白",@"白航明", nil];
    NSArray *arraysignature1=[[NSArray alloc]initWithObjects:@"一直走，不回头，我却不知不觉弄丢了你。",@"我说过，都是我自己的事情，所以你只要知道就好。",@"我只是想说出自己的心情、并不是为了要别人评论。",@"无",@"如果我说我现在很好，你是不是可以不要在出现。",@"有些东西，让它一直保留在心里，待到白发苍苍，才能感受它的存在",nil];
    NSArray *imageArray1=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"deng.png"],[UIImage imageNamed:@"fu.png"],[UIImage imageNamed:@"liu.png"],[UIImage imageNamed:@"liu.png"],[UIImage imageNamed:@"liu.png"],[UIImage imageNamed:@"liu.png"], nil];
    for (int i=0; i<6; i++) {
        People  *people=[[People alloc]init];
        people.name=[arrayname1 objectAtIndex:i];
        people.signature=[arraysignature1 objectAtIndex:i];
        people.image=[imageArray1 objectAtIndex:i];
        [_MutableArray addObject:people];
        
    }
    
    [_TableGoodfriend reloadData];

}
#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (tableView==_Tablecommunity) {
//        return [_Arraycommunity count];
//    }else if (tableView==_tablegroup) {
//        return [_ArrayGroup count];
//    }else if (tableView==_TableGoodfriend){
//        return  [_pingfirst count];
//    }
    if (tableView==_Tablecommunity) {
        return [_arr count];
    }
    return 1;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    if (tableView==_TableGoodfriend) {
//         return  _pingfirst;
//    }
    return 0;
}

//块头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 return 0;
}
//设置每块section的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if (tableView==_TableGoodfriend) {
//        return  [_pingfirst objectAtIndex:section];}
    return nil;
}
//每个cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//每块的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_Tablecommunity) {
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return [[[_Arraycommunity objectAtIndex:section] objectForKey:[_arr objectAtIndex:section]] count]+1;;
            }
        }
        return 1;

    }else if (tableView==_TableGoodfriend){
//        return  [[_dictionary objectForKey:[_pingfirst objectAtIndex:section]]count];
        return [_MutableArray count];
    }else if(tableView==_RecentlyTable)
    {
        return [_RecentlyArray count];
    }
//    else if (tableView==_tablegroup){
//        return [_ArrayGroup count];
//    }
    return 0;
    
}
//每个cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_Tablecommunity) {
        
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {//打开时显示每个区的详细内容
            NSLog(@"cell2=====");
            static NSString *CellIdentifier = @"Cell2";
            Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            }
            NSArray *list = [[_Arraycommunity objectAtIndex:self.selectIndex.section] objectForKey:[_arr objectAtIndex:indexPath.section]];
           
            cell.titleLabel.text =( (People *)[list objectAtIndex:indexPath.row-1]).name;
            cell.subtitle.text =( (People *)[list objectAtIndex:indexPath.row-1]).signature;
            cell.image.image =( (People *)[list objectAtIndex:indexPath.row-1]).image;
            return cell;
        }else
        {   //关闭时显示小区
             NSLog(@"cell1=====");
            static NSString *CellIdentifier = @"Cell1";
            Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
            }
            NSString *name = [_arr objectAtIndex:indexPath.section];
            cell.titleLabel.text = name;
            [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
            return cell;
        }
        return nil;
    }else{
    static NSString *Identifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
    }
    if (tableView==_Tablecommunity) {
    cell.textLabel.text=[_Arraycommunity objectAtIndex:indexPath.row];
    } else if (tableView==_TableGoodfriend){
//        NSString *key=[_pingfirst objectAtIndex:indexPath.section];
//        NSMutableArray  *array=[_dictionary objectForKey:key];
//        cell.textLabel.text=[array objectAtIndex:indexPath.row];
        People *ple=(People *)[_MutableArray objectAtIndex:indexPath.row];
        cell.textLabel.text=ple.name;
      
        cell.detailTextLabel.text=ple.signature;
        cell.imageView.image=ple.image;
    }
    else if (tableView==_RecentlyTable){
     
        People *ple=(People *)[_RecentlyArray objectAtIndex:indexPath.row];
        cell.textLabel.text=ple.name;
        cell.detailTextLabel.text=ple.signature;
        cell.imageView.image=ple.image;
    }
        return cell;}
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *demo=[[ChatViewController alloc]init];//初始化一个对像

    if (tableView==_Tablecommunity) {
        if (indexPath.row == 0) { //点击第一行
            if ([indexPath isEqual:self.selectIndex]) {
                self.isOpen = NO;
                [self didSelectCellRowFirstDo:NO nextDo:NO];
                self.selectIndex = nil;
                
            }else
            {
                if (!self.selectIndex) {
                    self.selectIndex = indexPath;
                    [self didSelectCellRowFirstDo:YES nextDo:NO];
                    
                }else
                {
                   [self didSelectCellRowFirstDo:NO nextDo:YES];
                }
            }
        }else  //内容
        {
            NSDictionary *dic = [_Arraycommunity objectAtIndex:indexPath.section];
            NSArray *list = [dic objectForKey:[_arr objectAtIndex:indexPath.section]];
            NSLog(@"%d===",[list count]);
            NSString *item = ( (People *)[list objectAtIndex:indexPath.row-1]).name;
            demo.strname=item;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:item message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
//            [alert show];
            demo.hidesBottomBarWhenPushed=YES;//影藏tabar
            CusotomViewController *cusotom=(CusotomViewController *)self.tabBarController;
            [cusotom hiddenTabBar];//影藏tabar
            [self.navigationController pushViewController:demo animated:YES];//push 下一个页面
            }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    } else if (tableView==_TableGoodfriend) {
//      NSString *key=[_pingfirst objectAtIndex:indexPath.section];
//    NSMutableArray  *array=[_dictionary objectForKey:key];
//    DemoViewController *demo=[[DemoViewController alloc]init];
//        demo.hidesBottomBarWhenPushed=YES;
//    demo.strname=[array objectAtIndex:indexPath.row];
//   [self.navigationController pushViewController:demo animated:YES];
        People *ple=(People *)[_MutableArray objectAtIndex:indexPath.row]; //取出点击哪行的对象
        demo.strname=ple.name; //属性传参
        demo.hidesBottomBarWhenPushed=YES;//影藏tabar
        CusotomViewController *cusotom=(CusotomViewController *)self.tabBarController;
        [cusotom hiddenTabBar];//影藏tabar
        [self.navigationController pushViewController:demo animated:YES];//push 下一个页面
   }
    else if (tableView==_RecentlyTable){
        People *people=(People *)[_RecentlyArray objectAtIndex:indexPath.row];
        demo.strname=people.name;
        demo.hidesBottomBarWhenPushed=YES;//影藏tabar
        CusotomViewController *cusotom=(CusotomViewController *)self.tabBarController;
        [cusotom hiddenTabBar];//影藏tabar
        [self.navigationController pushViewController:demo animated:YES];//push 下一个页面
    } 
  
}
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    Cell1 *cell = (Cell1 *)[_Tablecommunity cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    [_Tablecommunity beginUpdates];
    int section = self.selectIndex.section;
    NSLog(@"%d======",section);
    NSLog(@"%@===-----",_Arraycommunity  );
       int contentCount = [[[_Arraycommunity objectAtIndex:section] objectForKey:[NSString stringWithFormat:@"雨花区%d",section] ] count];
  
   	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSLog(@"%d===",contentCount);
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [_Tablecommunity insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [_Tablecommunity deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
   
	[_Tablecommunity endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [_Tablecommunity indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [_Tablecommunity scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{//再执行滚动  反复执行
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{//最先执行拖拽
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{ //结束滚动
    NSLog(@"%f-------------------",scrollView.contentOffset.x) ;//滚动内容的偏移量的横坐标
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    NSInteger currentPage = (offset+(width/2))/width;
    NSLog(@"%f,%f,%d",offset,width,currentPage);
     int index=(int)scrollView.contentOffset.x/320;
     if (index==1)
    {   
        NSLog(@"好友11");
          [self Goodaction:nil];
      } else if(index==0)
    {
  
            if (scrollView==_Tablecommunity) {
            NSLog(@"小区");
            [self communityaction:nil];
        }else if (scrollView==_TableGoodfriend)
        {
            NSLog(@"好友2222");
            [self Goodaction:nil];
        } else
        {
            NSLog(@"最近");
            [self Recently:nil];
        }
        
    }else if (index==2)
    {
        NSLog(@"小区");
          [self communityaction:nil];
    }else if (index==3)
    {
        NSLog(@"添加");
        [self groupaction:nil];
    }
}
- (void)didReceiveMemoryWarning
{ 
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
