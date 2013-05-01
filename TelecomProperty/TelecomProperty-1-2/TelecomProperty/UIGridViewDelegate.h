//
//  UIGridViewDelegate.h
//  foodling2
//
//  Created by Tanin Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIGridViewDelegate


@optional
- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)columnIndex;//点击一个griview 进入方法


@required
- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex;//每个cell宽度
- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex;//cell高度

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid;//多少块
- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid;//多少行

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex;//格式

@end

