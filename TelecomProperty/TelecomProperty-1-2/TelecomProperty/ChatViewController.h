
#import <UIKit/UIKit.h>
#import "PhraseViewController.h"
#import "HPGrowingTextView.h"


@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PhraseViewDelegate,HPGrowingTextViewDelegate> {
	NSString                   *_titleString;
	NSString                   *_messageString;
	NSString                   *_phraseString;
	NSMutableArray		       *_chatArray;
	NSMutableArray             *_deleteArrary;
	
	UITableView                *_chatTableView;
	BOOL                       _isFromNewSMS;
	PhraseViewController       *_phraseViewController;
  NSDate                     *_lastTime;
}

@property (nonatomic, retain) UITableView            *chatTableView;
@property(nonatomic,retain)HPGrowingTextView* messageTextField;
@property(nonatomic,retain)UIView *containerView;
@property (nonatomic, retain) NSString               *phraseString;
@property (nonatomic, retain) NSString               *titleString;
@property (nonatomic, retain) NSString               *messageString;
@property (nonatomic, retain) NSMutableArray		 *chatArray;
@property (nonatomic, retain) NSMutableArray		 *deleteArrary;

@property (nonatomic, assign) BOOL                   isFromNewSMS;
@property (nonatomic, retain) NSDate                 *lastTime;
@property(nonatomic,retain)NSString *strname;
@property(nonatomic,retain)UIButton *doneBtn;//按钮
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf;
@end
