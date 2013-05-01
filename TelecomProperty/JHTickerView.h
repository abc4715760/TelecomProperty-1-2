//
//  JHTickerView.h
//  Ticker
//
//  Created by Jeff Hodnett on 03/05/2011.
//  Copyright 2011 Applausible. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    JHTickerDirectionLTR,
    JHTickerDirectionRTL,
} JHTickerDirection;

@interface JHTickerView : UIView {
    
	// The ticker strings 股票行情自动收录器字符串
	NSArray *tickerStrings;
	
	// The current index for the string 当前索引的字符串
	int currentIndex;
	
	// The ticker speed 股票行情自动收录器速度
	float tickerSpeed;
	
	// Should the ticker loop 应该股票行情自动收录器循环
	BOOL loops;
	
	// The current state of the ticker 股票的当前状态
	BOOL running; //区分  开始循环 和视图切换时有无动画动画
	
	// The ticker label 
	UILabel *tickerLabel;
	
	// The ticker font
	UIFont *tickerFont;
}

@property(nonatomic, retain) NSArray *tickerStrings;
@property(nonatomic,assign) float tickerSpeed;
@property(nonatomic) BOOL loops;
@property(nonatomic) JHTickerDirection direction;

-(void)start;
//-(void)stop;
-(void)pause;
-(void)resume;

@end
