//
//  DiYuCell2.h
//  IYLM
//
//  Created by JianYe on 13-1-11.
//  Copyright (c) 2013年 Jian-Ye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface Cell2 : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *subtitle;
@property (retain, nonatomic) IBOutlet AsyncImageView *image;

@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@end
