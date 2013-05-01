//
//  GoodFriendViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "GoodFriendViewController.h"
#import "DemoViewController.h"
#import "ChatViewController.h"
#import "Zhongwenpaixu.h"
#import "String.h"
#import "SectionABC.h"
#import "Section.h"
@interface GoodFriendViewController ()

@end

@implementation GoodFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"游客，您好";
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(5, 2, 80, 40);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
   _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44) style:UITableViewStyleGrouped];
    _table.dataSource=self;
    _table.delegate=self;
    _table.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_table];
    _MutableArray=[[NSMutableArray alloc]initWithObjects:@"付晓伟",@"邓成其",@"刘旺星",@"刘小三",@"付大白",@"白",@"孙", nil];
     _namearray=[[NSMutableArray alloc]init];//初始化一个数组
    for (int i=0; i<[_MutableArray count]; i++) {
        [_namearray addObject:((String *)[[Zhongwenpaixu zhongWenPaiXu:_MutableArray] objectAtIndex:i]).string];
  }
    for (int i=0;i<[_namearray count];i++) {
        NSLog(@"----%@--",[_namearray objectAtIndex:i]);
    }
   _pingfirst=[SectionABC zhongWenPaiXu:_namearray]; //取出对应的拼音首字母数组  赋值
     NSLog(@"===%@===",_pingfirst);
    for (NSString *str in _pingfirst) {
        NSLog(@"---=%@==",str);
    }
    _dictionary=[[NSMutableDictionary alloc]init];
    _dictionary=[Section SectionZiMu:_namearray];// 字典里存的K 是拼音的首字母 value是名字
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  _pingfirst;
  }
//多少块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [_pingfirst count];
  }
//块头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//设置每块section的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return  [_pingfirst objectAtIndex:section];
}
//每个cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 50;
}
//每块的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dictionary objectForKey:[_pingfirst objectAtIndex:section]] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *key=[_pingfirst objectAtIndex:indexPath.section];
    NSMutableArray  *array=[_dictionary objectForKey:key];
    cell.textLabel.text=[array objectAtIndex:indexPath.row];
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ChatModelViewController *chatmodel=[[ChatModelViewController alloc]init];
    NSString *key=[_pingfirst objectAtIndex:indexPath.section];
    NSMutableArray  *array=[_dictionary objectForKey:key];
    DemoViewController *demo=[[DemoViewController alloc]init];
    demo.strname=[array objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:demo animated:YES];
    
//    ChatViewController  *chatmodel=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
//     chatmodel.strname=[array objectAtIndex:indexPath.row];
//     [self.navigationController pushViewController:chatmodel animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
