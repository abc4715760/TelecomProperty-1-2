//
//  DDList.h
//  DropDownList
//
//  Created by kingyee on 11-9-19.
//  Copyright 2011 Kingyee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UrlAddress.h"
@protocol PassValueDelegate;

@interface DDList : UITableViewController {
	NSString		*_searchText;
	NSString		*_selectedText;
	NSMutableArray	*_resultList;
	id <PassValueDelegate>	_delegate;
}

//@property (nonatomic, copy)NSMutableArray*_searchText;//存下拉框的数据
//@property (nonatomic, copy)NSString		*_selectedText;
@property (nonatomic, retain)NSMutableArray	*_resultList;
@property (assign) id <PassValueDelegate> _delegate;

- (void)updateData;

@end
