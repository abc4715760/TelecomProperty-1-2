//
//  CusotomViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-7.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "CusotomViewController.h"
#import "MainViewController.h"
#import "MoreViewController.h"
#import "CommunityViewController.h"
#import "InformationViewController.h"

@interface CusotomViewController ()

@end

@implementation CusotomViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)loadViewControllers
{
    /*
     * 1. 创建若干个子视图控制器（它们是并列的关系）
     *  1.1 创建UITabBarItem实例，赋值给相应的子视图控制器（有可能是导航控制器）
     * 2. 创建一个数组，将已创建的子视图控制器，添加到数组中
     * 3. 创建UITabBarController实例
     * 4. tabBarController.viewControllers = viewControllers;
     * 5. 添加到window的rootViewController中
     */
    
    // 首页
     InformationViewController*vc1 = [[InformationViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:vc1];
//    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
//    vc1.tabBarItem = homeItem;

    /*
     NSLog(@"vc1 barButtonItem : %p", vc1.navigationItem.leftBarButtonItem);
     NSLog(@"vc1 tabBarItem : %p", vc1.tabBarItem);
     */
    // 我的小区
    CommunityViewController *vc2 = [[CommunityViewController alloc] init];
    UINavigationController *msgNav = [[UINavigationController alloc] initWithRootViewController:vc2];

//    UITabBarItem *msgItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:2];
//    vc2.tabBarItem = msgItem;
    //天翼生活
    MainViewController *vc3 = [[MainViewController alloc] init];
    UINavigationController *searchNav = [[UINavigationController alloc] initWithRootViewController:vc3];
 
//    UITabBarItem *searchItem = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"alarm"] tag:3];
//    vc3.tabBarItem = searchItem;
   // 设置页
    MoreViewController *vc4 = [[MoreViewController alloc] init];
    UINavigationController *setNav = [[UINavigationController alloc] initWithRootViewController:vc4];
//    UITabBarItem *setItem = [[UITabBarItem alloc] initWithTitle:@"草莓" image:[UIImage imageNamed:@"Strawberry"] tag:4];
//    vc4.tabBarItem = setItem;
  
    // 将视图控制器添加至数组中
    NSArray *viewControllers = @[homeNav, msgNav, searchNav, setNav];
    [self setViewControllers:viewControllers animated:YES];
}

- (void)loadCustomTabBarView
{
    if (!iphone5) {
        yorgert=480;
    }else{
        yorgert=568;
    }
    /*
     * 层次：背景（最下）、选中图片（中间）、按钮（最上）
     */
    
    // 初始化自定义TabBar背景
    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, yorgert-49, 320,49)];
    _tabBarBG.userInteractionEnabled = YES;
    _tabBarBG.image = [UIImage imageNamed:@"底条"];
    [self.view addSubview:_tabBarBG];
    
    // 初始化自定义选中背景
    _selectView = [[UIImageView alloc] init ];
//    [_selectView setFrame:CGRectMake(10, 49.0/2 - 45.0/2, 53, 45)];
    _selectView.frame=CGRectMake(0, 3, 320/4, 43);
    _selectView.image = [UIImage imageNamed:@"按下1.png"];
    [_tabBarBG addSubview:_selectView];
    
    // 初始化自定义TabBarItem -> UIButton
    float coordinateX = 0;
    for (int index = 0; index < 4; index++) {
        UIButton *button = [UIButton buttonWithType:0];
        button.tag = index;
        button.frame = CGRectMake(0+coordinateX+19, 6, 320/4-30-10, 60-25);
        NSString *imageName = [NSString stringWithFormat:@"小首页%d", index+1];
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_tabBarBG addSubview:button];
        [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
        coordinateX += 80;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self loadViewControllers];
    [self loadCustomTabBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.34];
    _tabBarBG.frame = CGRectMake(0, yorgert-49, 320, 49);
    [UIView commitAnimations];
}

- (void)hiddenTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35];
    _tabBarBG.frame = CGRectMake(-320, yorgert-49, 320, 49);
    [UIView commitAnimations];
}
- (void)changeViewController:(UIButton *)button
{

     self.selectedIndex = button.tag;
    [UIView beginAnimations:nil context:NULL];
//    _selectView.frame = CGRectMake(10 + button.tag*62, 49.0/2 - 45.0/2, 53, 45);
    _selectView.frame=CGRectMake(button.tag*80, 3,80, 43);
    [UIView commitAnimations];
}

@end
