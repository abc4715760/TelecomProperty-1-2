//
//  DemoViewController.m
//  Messages
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@end
@implementation DemoViewController

-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = _strname;
    //背景图片
//    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
//    backImage.frame=CGRectMake(0,0, 320, 480);
//    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=[NSString stringWithFormat:@"与 %@ 对话",_strname];
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(5, 2, 80, 40);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     @"我\nTesting some messages here.",
                     @"\nThis work is based on Sam Soffes' SSMessagesViewController.",
                     @"This is a complete re-write and refactoring.",
                     @"It's easy to implement. Sound effects and images included. Animations are smooth and messages can be of arbitrary size!",
                     nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Messages view controller
- (BubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_messages) {
          return BubbleMessageStyleOutgoing;
    }else {
            return  BubbleMessageStyleIncoming;
    }
    NSLog(@"%d",indexPath.row %2);
//    return (indexPath.row % 2) ? BubbleMessageStyleIncoming : BubbleMessageStyleOutgoing;
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}

- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    [self.messages addObject:[NSString stringWithFormat:@"%@",text]];
    
    if((self.messages.count - 1) % 2)
        [MessageSoundEffect playMessageSentSound];
    else
        [MessageSoundEffect playMessageReceivedSound];
    [self finishSend];
}

@end