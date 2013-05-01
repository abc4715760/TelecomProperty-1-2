//
//  Cell.m
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"
#import <QuartzCore/QuartzCore.h> 

@implementation Cell


@synthesize thumbnail;
@synthesize label,number;


- (id)init {
	
    if (self = [super init]) {
		
//        self.frame = CGRectMake(0, 0, 80, 80);
		[[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
	   [self addSubview:self.view];
//		self.thumbnail.frame=CGRectMake(0, 0, 80,80);
//		self.thumbnail.layer.cornerRadius = 33.0;
//        self.thumbnail.layer.cornerRadius=17.0;
//		self.thumbnail.layer.masksToBounds = YES;
//		self.thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
//		self.thumbnail.layer.borderWidth = 1.0;
//        number.backgroundColor=[UIColor redColor];
        number.textColor=[UIColor whiteColor];
        number.hidden=YES;
        _NotifictionNumber.hidden=YES;
	}
	
    return self;
	
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/



- (void)dealloc {
    
    [_NotifictionNumber release];
    [super dealloc];
}
@end
