

#import <UIKit/UIKit.h>

@class NewSMSViewController;
@class ChatViewController;

@protocol  PhraseViewDelegate <NSObject>

-(void)TheContent:(NSString *)sender;

@end

@interface PhraseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	UITableView               *_uiTableView;
	NSMutableArray            *_phraseArray;
	ChatViewController        *_chatViewController;
	BOOL                      _isFromChatView;

}
@property (nonatomic, retain) IBOutlet UITableView      *uiTableView;
@property (nonatomic, retain) NSMutableArray            *phraseArray;
@property (nonatomic, retain) ChatViewController        *chatViewController;
@property (nonatomic, assign) BOOL                      isFromChatView;
@property(nonatomic,assign)id<PhraseViewDelegate>delegate;
-(IBAction)dismissMyselfAction:(id)sender;

@end
