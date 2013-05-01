//
//  CusotomViewController.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-7.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusotomViewController : UITabBarController
{
@private
    UIImageView *_selectView;
    UIImageView *_tabBarBG;
    float yorgert;
    
}

- (void)showTabBar;

- (void)hiddenTabBar;

@end
