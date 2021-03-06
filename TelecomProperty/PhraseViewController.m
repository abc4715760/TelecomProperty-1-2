

#import "PhraseViewController.h"
//#import "NewSMSViewController.h"
#import "ChatViewController.h"

@implementation PhraseViewController
@synthesize uiTableView = _uiTableView;
@synthesize phraseArray = _phraseArray;
//@synthesize newSMSViewController = _newSMSViewController;
@synthesize chatViewController = _chatViewController;
@synthesize isFromChatView = _isFromChatView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
-(void)backaction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"常用短语";
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    [username release];

    UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame=CGRectMake(5, 2, 80, 40);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
  
	NSMutableArray *temp = [[NSMutableArray alloc] init];
    [temp addObject:@"我等的花儿都谢了！"];
    [temp addObject:@"主公不给力啊！"];
    [temp addObject:@"反贼们，再不跳就没机会了！"];
    [temp addObject:@"小内，你在做啥！"];
    [temp addObject:@"小内，不要装了！"];
    [temp addObject:@"求桃！"];
    [temp addObject:@"再来一局！"];
    [temp addObject:@"杀!"];
    [temp addObject:@"烽火狼烟！"];
    [temp addObject:@"万箭齐发！"];
    [temp addObject:@"五谷丰登！"];
    [temp addObject:@"闪!"];
    [temp addObject:@"再杀！"];
    [temp addObject:@"再来一刀!"];
    [temp addObject:@"再闪！"];
    [temp addObject:@"我闪！"];
    [temp addObject:@"桃一个！"];
    [temp addObject:@"画地为牢！"];
    [temp addObject:@"无懈可击！"];
    [temp addObject:@"决斗！"];
    [temp addObject:@"探囊取物！"];
    [temp addObject:@"釜底抽薪！"];
	self.phraseArray = temp;
	[temp release];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_chatViewController release];

	[_phraseArray release];
	[_uiTableView release];
    [super dealloc];
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [self.phraseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] autorelease];
    }
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [self.phraseArray objectAtIndex:row];
	
    return cell;
	
}
#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate TheContent: [self.phraseArray objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self dismissModalViewControllerAnimated:YES];

}


@end
