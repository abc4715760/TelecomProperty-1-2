//
//  CPTextViewPlaceholder.h
//  Cassius Pacheco
//
//  Created by Cassius Pacheco on 30/01/13.
//  Copyright (c) 2013 Cassius Pacheco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTextViewPlaceholder : UITextView{
NSString *placeholder;
UIColor *placeholderColor;

@private
UILabel *placeHolderLabel;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
