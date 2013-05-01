//
//  WaterFlowView.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-11.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "WaterFlowView.h"

#define TABLEVIEWTAG 1000
#define CELLSUBVIEWTAG 10000

@implementation WaterFlowView
@synthesize columnCount = _columnCount, cellsTotal = _cellsTotal,cellWidth = _cellWidth;
@synthesize waterFlowViewDelegate = _waterFlowViewDelegate,waterFlowViewDatasource = _waterFlowViewDatasource;

-(void)dealloc{
   
    self.waterFlowViewDelegate = nil;
    self.waterFlowViewDatasource = nil;
    tableviews=nil;
    _progressBox=nil;
    [super dealloc]; // arc开启 加上就会崩溃 待解决
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _progressBox = [[MBProgressHUD alloc] initWithView:self];
        [_progressBox setYOffset:-50];
        
        [self addSubview:_progressBox];
//        3、开始旋转，例如你正在请求时
        [_progressBox setLabelText:@"正在加载"];
        [_progressBox show:YES];
        self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)+1);
    }
    return self;
}

-(void)layoutSubviews{ //自动调用
    
    [self relayoutDisplaySubviews];
    for (UITableView *tableview in tableviews) {
         [tableview setFrame:CGRectMake(tableview.frame.origin.x, self.contentOffset.y, CGRectGetWidth(tableview.frame), CGRectGetHeight(tableview.frame))];
        [tableview setContentOffset:self.contentOffset animated:NO];
    }
    [super layoutSubviews];
}
-(void)relayoutDisplaySubviews{

    self.columnCount = [self.waterFlowViewDatasource numberOfColumsInWaterFlowView:self];  
    self.cellsTotal = [self.waterFlowViewDatasource numberOfAllWaterFlowView:self];
    
    if (_cellsTotal == 0 || _columnCount == 0) {
        
        return;
    }
    
    self.cellWidth = CGRectGetWidth(self.frame)/_columnCount; //每列的宽度
    
    if (!tableviews) {
         tableviews = [[NSMutableArray alloc] initWithCapacity:_columnCount];
        for (int i = 0; i < _columnCount; i++) {
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(_cellWidth*i, 0, _cellWidth, CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tag = i + TABLEVIEWTAG; //保存列号
            tableView.showsVerticalScrollIndicator = NO;
            tableView.scrollEnabled = NO;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.backgroundColor = [UIColor blueColor];
            [self addSubview:tableView];
            [tableviews addObject:tableView];
            [tableView release];
        }
    }
}

-(void)setWaterFlowViewDatasource:(id<WaterFlowViewDataSource>)waterFlowViewDatasource{

    _waterFlowViewDatasource = waterFlowViewDatasource;
}

-(void)setWaterFlowViewDelegate:(id<WaterFlowViewDelegate>)waterFlowViewDelegate{

    _waterFlowViewDelegate = waterFlowViewDelegate;
  
}
- (void)myProgressTask {
    // This just increases the progress indicator in a loop
   
}
- (void)reloadData{
    //        4、停止旋转
    //        
    if (_progressBox) {
       [_progressBox hide:YES];
    }
    [self relayoutDisplaySubviews];
    
    float contenSizeHeight = 0.0f;
    
    for (UITableView *tabelview in tableviews) {
        
         [tabelview reloadData];
        if (contenSizeHeight < tabelview.contentSize.height) {
            contenSizeHeight = tabelview.contentSize.height;
        }
    }
    
    contenSizeHeight = contenSizeHeight < CGRectGetHeight(self.frame)?CGRectGetHeight(self.frame)+1:contenSizeHeight;
    self.contentSize = CGSizeMake(self.contentSize.width, contenSizeHeight);
}


- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumn:(NSInteger)colunm{
    
    if (waterFlowView.cellsTotal -(colunm + 1) < 0) {
        return 0;
    }else{
        return (waterFlowView.cellsTotal -(colunm + 1))/waterFlowView.columnCount+1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self waterFlowView:self numberOfRowsInColumn:tableView.tag - TABLEVIEWTAG];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
    CGFloat cellHeight = [self.waterFlowViewDelegate waterFlowView:self heightForRowAtIndexPath:_indextPath];
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    NSString *cellIndetify = [NSString stringWithFormat:@"cell%d",tableView.tag -TABLEVIEWTAG];
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndetify];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
        UIView *cellSub =  [self.waterFlowViewDatasource waterFlowView:self cellForRowAtIndexPath:_indextPath];
        [cell.contentView addSubview:cellSub];
        [cellSub release];
        cellSub.tag = CELLSUBVIEWTAG;
    }
    
    IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
    CGFloat cellHeight = [self.waterFlowViewDelegate waterFlowView:self heightForRowAtIndexPath:_indextPath];
    CGRect cellRect = CGRectMake(0, 0, _cellWidth, cellHeight);
    [[cell viewWithTag:CELLSUBVIEWTAG] setFrame:cellRect];
    
    [self.waterFlowViewDatasource waterFlowView:self relayoutCellSubview:[cell viewWithTag:CELLSUBVIEWTAG] withIndexPath:_indextPath]; //调取

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 //获取当前点击的cell
  
    IndexPath *_indextPath = [IndexPath initWithRow:indexPath.row  withColumn:tableView.tag - TABLEVIEWTAG];
    [self.waterFlowViewDelegate waterFlowView:self didSelectRowAtIndexPath:_indextPath];
}

@end
