

#import "ChatViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChatCustomCell.h"


#define TOOLBARTAG		200
#define TABLEVIEWTAG	300

@implementation ChatViewController
@synthesize titleString = _titleString;
@synthesize chatArray = _chatArray;
@synthesize chatTableView = _chatTableView;

@synthesize messageString = _messageString;
@synthesize phraseString = _phraseString;
@synthesize lastTime = _lastTime;
@synthesize messageTextField=_messageTextField;
@synthesize deleteArrary = _deleteArrary;
@synthesize isFromNewSMS = _isFromNewSMS;


-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark Keynotification
-(id)init
{
	self = [super init];
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillHide:)
													 name:UIKeyboardWillHideNotification
												   object:nil];
	}
	
	return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
       self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
    NSLog(@"%s",__FUNCTION__);
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(OthersAirBubbles) userInfo:nil repeats:YES];//定时器
    
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        backImage.frame=CGRectMake(0,0, 320, 480);
    }
    else
    {
        backImage.frame=CGRectMake(0,0, 320, 548);
    }

    [self.view addSubview: backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    [navigation release];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    if (_strname) {
        username.text=[NSString stringWithFormat:@"正与 %@ 通话",_strname];
    }else{
        username.text=@"游客，您好";
    }
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];

    UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
    but.frame=CGRectMake(5, 2, 60, 40);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [self.view addSubview:but];
	
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.chatArray = tempArray;
	[tempArray release];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	self.deleteArrary = array;
	[array release];
	
	NSDate   *tempDate = [[NSDate alloc] init];
	self.lastTime = tempDate;
	[tempDate release];

    _chatTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,44, 320, 460-88)];
	_chatTableView.backgroundColor=[UIColor clearColor];
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//自定义分割线
    _chatTableView.dataSource=self;
    _chatTableView.delegate=self;
    
    [self.view addSubview:_chatTableView];
  
    self.view.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
	
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, 320, 40)];
    
	_messageTextField = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    _messageTextField.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
	_messageTextField.minNumberOfLines = 1;
	_messageTextField.maxNumberOfLines = 6;
	_messageTextField.returnKeyType = UIReturnKeyGo; //just as an example
	_messageTextField.font = [UIFont systemFontOfSize:15.0f];
	_messageTextField.delegate = self;
    _messageTextField.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    _messageTextField.backgroundColor = [UIColor whiteColor];
    // textView.text = @"test\n\ntest";
	// textView.animateHeightChange = NO; //turns off animation
    [self.view addSubview:_containerView];
	
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[[UIImageView alloc] initWithImage:entryBackground] autorelease];
    entryImageView.frame = CGRectMake(5, 0, 248, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:background] autorelease];
    imageView.frame = CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _messageTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [_containerView addSubview:imageView];
    [_containerView addSubview:_messageTextField];
    [_containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButtonPressed.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
	_doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	_doneBtn.frame = CGRectMake(_containerView.frame.size.width - 69, 8, 63, 27);
    _doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
   	[_doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    
    [_doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    _doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    _doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _doneBtn.selected=YES;
    [_doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
    [_doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
     [_doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
 
	[_containerView addSubview:_doneBtn];
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  
}
-(void)TheContent:(NSString *)sender
{
    self.phraseString=sender;
}
-(void)viewWillAppear:(BOOL)animated{
    
	[super viewWillAppear:YES];
    NSLog(@"%s",__FUNCTION__);
    	[_messageTextField setText:self.phraseString];
    [self.chatTableView reloadData];
}

-(void)initChatInfoFromNewSMS:(NSString *)message
{
	[self sendMassage:message];
}
-(void)resignTextView
{
    NSString *messageStr = self.messageTextField.text;
	[self sendMassage:messageStr];
    _messageTextField.text=nil;
    [_messageTextField resignFirstResponder];
}
#pragma mark HPGrowingTextViewDelegate
- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    NSLog(@"sdfsdfs");
    if ([growingTextView.text length]==0 ) {
        _doneBtn.selected=YES;
        [_doneBtn setBackgroundImage:[[UIImage imageNamed:@"MessageEntrySendButtonPressed.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateSelected];
        [_doneBtn removeTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    }else{
        _doneBtn.selected=NO;
        [_doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
        [_doneBtn setBackgroundImage:[[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    }
}

////发送消息
//-(void)sendMessage_Click:(id)sender
//{	
//	NSString *messageStr = self.messageTextField.text;
//	[self sendMassage:messageStr];
//	self.messageTextField.text = @"";
//	[_messageTextField resignFirstResponder];
//    [self moveViewDown];
//
//}
//发送消息
-(void)sendMassage:(NSString *)message
{  
    NSLog(@"%@====",message);
    NSDate *nowTime = [NSDate date];//获取系统时间
	NSMutableString *sendString=[NSMutableString stringWithCapacity:100];
	[sendString appendString:message];
   if ([self.chatArray lastObject] == nil) {
		self.lastTime = nowTime;
		[self.chatArray addObject:nowTime];
	}
	
	NSTimeInterval timeInterval = [nowTime timeIntervalSinceDate:self.lastTime];
	if (timeInterval >5) {
		self.lastTime = nowTime;
		[self.chatArray addObject:nowTime];
	}
	
	UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@%@", NSLocalizedString(@"",nil), message]
								   from:YES]; //显示自己发送的用户名和信息内容
    
	[self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:message, @"text", @"self", @"speaker", chatView, @"view", nil]];
	
	[self.chatTableView reloadData];
	[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0] 
							  atScrollPosition:UITableViewScrollPositionBottom 
									  animated:YES];
 //    [self OthersAirBubbles];//显示接受的信息内容
}
//选择常用消息短语
//-(IBAction)showPhraseInfo:(id)sender
//{
//	[self.messageTextField resignFirstResponder];
//	if (self.phraseViewController == nil) {
//		PhraseViewController *temp = [[PhraseViewController alloc] initWithNibName:@"PhraseViewController" bundle:nil];
//		self.phraseViewController = temp;
//		[temp release];
//	}
//    self.phraseViewController.delegate=self;
//	self.phraseViewController.isFromChatView = YES;
//	[self presentModalViewController:self.phraseViewController animated:YES];
//}
/*
 生成泡泡UIView
 */
#pragma mark -
#pragma mark Table view methods
- (UIView *)bubbleView:(NSString *)text from:(BOOL)fromSelf {
	// build single chat bubble cell with given text
	UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
	returnView.backgroundColor = [UIColor clearColor];
	UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"messageBubbleBlue":@"messageBubbleGray" ofType:@"png"]];//选取图片
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:20 topCapHeight:14]];
	
	UIFont *font = [UIFont systemFontOfSize:14];
	CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(150.0f, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
	
	UILabel *bubbleText = [[UILabel alloc] initWithFrame:CGRectMake(21.0f+44, 14.0f, size.width+10, size.height+10)];
	bubbleText.backgroundColor = [UIColor clearColor];
	bubbleText.font = font;
	bubbleText.numberOfLines = 0;
	bubbleText.lineBreakMode = UILineBreakModeWordWrap;
	bubbleText.text = text;
	bubbleImageView.frame = CGRectMake(0.0f+44, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
    UIImageView *UserImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Icon22.png"]];
    
	if(fromSelf){
        //显示自己发的内容 位置
        UserImage.frame=CGRectMake(bubbleText.frame.size.width,bubbleText.frame.size.height-9, 44, 50);
        bubbleImageView.frame = CGRectMake(0.0f-30, 14.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+20.0f);
        bubbleText.frame=CGRectMake(0-20, bubbleText.frame.origin.y+9,bubbleText.frame.size.width-10,bubbleText.frame.size.height-10);
        
		returnView.frame = CGRectMake(290.0f-bubbleText.frame.size.width-44, 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
        
    }
	else{
        //显示别人发的内容图片 位置
        UserImage.frame=CGRectMake(0,bubbleText.frame.size.height-9, 44, 50);
		returnView.frame = CGRectMake(0.0f, 0.0f, bubbleText.frame.size.width+30.0f, bubbleText.frame.size.height+30.0f);
	    }
    [returnView addSubview: UserImage];//添加用户图片
    
	[returnView addSubview:bubbleImageView];
	[bubbleImageView release];
	[returnView addSubview:bubbleText];
	[bubbleText release];
	return [returnView autorelease];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
	self.isFromNewSMS = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)dealloc {
	[_deleteArrary release];
	[_lastTime release];
    _lastTime=nil;
	[_phraseString release];
    _phraseString=nil;
	[_messageString release];
    _messageString=nil;
	[_messageTextField release];
    _messageTextField=nil;
	[_chatArray release];
	[_titleString release];
    _titleString=nil;
	[_chatTableView release];
    _containerView=nil;
    _deleteArrary=nil;
    [super dealloc];
}
#pragma mark Others air bubbles
/*
 显示别人发的内容气泡
 */
-(void)OthersAirBubbles
{
//	NSString *info=[[[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding] autorelease];
    NSDate *nowTime = [NSDate date];//获取系统时间
	if ([self.chatArray lastObject] == nil) {
		self.lastTime = nowTime;
		[self.chatArray addObject:nowTime];
	}
	
	NSTimeInterval timeInterval = [nowTime timeIntervalSinceDate:self.lastTime];
	if (timeInterval >5) {
		self.lastTime = nowTime;
		[self.chatArray addObject:nowTime];
	}
	NSString *info=@"\n你好";
    UIView *chatView = [self bubbleView:[NSString stringWithFormat:@"%@", info]
								   from:NO]; //显示接受到的用户名和信息内容
    
	[self.chatArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:info, @"text", @"other", @"speaker", chatView, @"view", nil]];
	
	[self.chatTableView reloadData];
	[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0]
							  atScrollPosition:UITableViewScrollPositionBottom
									  animated:YES];
	//已经处理完毕
}
#pragma mark -

#pragma mark Table View DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.chatArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([[self.chatArray objectAtIndex:[indexPath row]] isKindOfClass:[NSDate class]]) {
		return 30;
	}else {
		UIView *chatView = [[self.chatArray objectAtIndex:[indexPath row]] objectForKey:@"view"];
		return chatView.frame.size.height+10;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CommentCellIdentifier = @"CommentCell";
	ChatCustomCell *cell = (ChatCustomCell*)[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
	if (cell == nil) {
		cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatCustomCell" owner:self options:nil] lastObject];
	}
	
	if ([[self.chatArray objectAtIndex:[indexPath row]] isKindOfClass:[NSDate class]]) {
		// Set up the cell...
		NSDateFormatter  *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yy-MM-dd HH:mm"];
		NSMutableString *timeString = [NSMutableString stringWithFormat:@"%@",[formatter stringFromDate:[self.chatArray objectAtIndex:[indexPath row]]]];
		[formatter release];
		
        [cell.dateLabel setText:timeString];
        
		cell.deleteButton.hidden = YES;

	}else {
		
		NSDictionary *chatInfo = [self.chatArray objectAtIndex:[indexPath row]];
		UIView *chatView = [chatInfo objectForKey:@"view"];
		cell.deleteButton.tag = [indexPath row];
		cell.deleteButton.frame = CGRectMake(20.0f, chatView.center.y - 10.0f, 29.0f, 29.0f);
		[cell.deleteButton addTarget:self action:@selector(deleteItemAction:) forControlEvents:UIControlEventTouchUpInside];
		
		[cell.contentView addSubview:chatView];
//
//		if (self.isEdit) {
//			if ([chatInfo objectForKey:@"speaker"] == @"other")
//				chatView.frame = CGRectMake(50.0f, 0.0f,  chatView.frame.size.width, chatView.frame.size.height);
//			cell.deleteButton.hidden = NO;
//		}else {
//			if ([chatInfo objectForKey:@"speaker"] == @"other")
//				chatView.frame = CGRectMake(0.0f, 0.0f,  chatView.frame.size.width, chatView.frame.size.height);
//			cell.deleteButton.hidden = YES;
//		}

	}
    cell.selectionStyle=UITableViewCellAccessoryNone;//点击没用颜色
    tableView.separatorColor=[UIColor redColor];
    return cell;
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark key show and hide
//当键盘出现时候上移坐标
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = _containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	_containerView.frame = containerFrame;
    
	_chatTableView.frame = CGRectMake(0.0f, 0.0+44.0f, 320.0f, 160.0f);
	if([self.chatArray count])
		[self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chatArray count]-1 inSection:0]
								  atScrollPosition:UITableViewScrollPositionBottom
										  animated:YES];

	// commit animations
	[UIView commitAnimations];
}
//当键盘消失时候下移坐标

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	// get a rect for the textView frame
	CGRect containerFrame = _containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	_containerView.frame = containerFrame;
    _chatTableView.frame = CGRectMake(0.0f, 0.0+44.0f, 320.0f, 460.0f-44-44);

	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = _containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	_containerView.frame = r;
}

@end
