//
//  GarageViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-17.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "GarageViewController.h"

@interface GarageViewController ()

@end

@implementation GarageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=self.view.frame;
    
    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
   
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"我的中心";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    [username release];
    [navigation release];
    [backImage release];
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 44,CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds) ) style:UITableViewStyleGrouped];
    _table.delegate=self;
    _table.dataSource=self;
    [self.view addSubview:_table];
    _mutableArray=[[NSMutableArray alloc]initWithObjects:@"更多", nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_mutableArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentify=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell==nil) {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify] autorelease];
    }
    cell.textLabel.text=[_mutableArray objectAtIndex:indexPath.section];
    return cell ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        MoreViewController *more=[[MoreViewController alloc]init];
        [self.navigationController pushViewController:more animated:YES];
    }
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
