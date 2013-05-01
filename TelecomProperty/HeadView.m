//
//  HeadView.m
//  Test04
//
//  Created by HuHongbing on 9/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView
@synthesize delegate = _delegate;
@synthesize section,open,backBtn,backImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        open = NO;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, 0, 340, 45.5);
        btn.titleLabel.textColor=[UIColor redColor];
        [btn addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;//设置文字位置，现设为居左，默认的是居中
        btn.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);//但是问题又出来，此时文字会紧贴到做边框，我们可以设置  使文字距离做边框保持13个像素的距离。
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_on"] forState:UIControlStateHighlighted];
        [self addSubview:btn];//添加视图上
        self.backBtn = btn;
        UIImageView *Imagv=[UIImageView new];
        [Imagv setFrame: CGRectMake(320-40, 5, 25, 25)];
       Imagv.image=[UIImage imageNamed:@"DownAccessory"];
        [self addSubview:Imagv];
        self.backImage=Imagv;
     }
    return self;
}

-(void)doSelected{
    //    [self setImage];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedWith:)]){
     	[_delegate selectedWith:self];
    }
}
@end
