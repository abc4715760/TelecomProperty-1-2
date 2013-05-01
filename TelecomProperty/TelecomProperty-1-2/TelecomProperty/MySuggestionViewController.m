//
//  MySuggestionViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-11.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "MySuggestionViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MySuggestionViewController ()

@end

@implementation MySuggestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark ASIencapsulation delegate
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    NSLog(@"ddddd");
   NSDictionary *dic= [strData JSONValue];
//   NSLog(@"%@",[strData  JSONValue]);
    if ([userinfo isEqualToString:@"req1"] ) {
        if ([[dic objectForKey:@"status"]intValue]==1) {
            [EncapsulationASI alertView:nil andmessage:@"建议提交成功"];
        }else{
         [EncapsulationASI alertView:nil andmessage:@"建议提交失败"];
        }
    }
}
#pragma mark --==-===
-(void)dealloc
{
    [super dealloc];
    _labelword=nil;//显示还能输入多少个字
   _backImage=nil;
    _textview=nil;
    _search=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //背景图片
    _backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        height=480;
    }
    else
    {
        height=548;
    }_backImage.frame=CGRectMake(0,0, 320, height);
    _backImage.userInteractionEnabled=YES;
    [self.view addSubview:_backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    [navigation release];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"小区建议";
    username.textColor=[UIColor whiteColor];
    username.backgroundColor=[UIColor clearColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    [username release];
    UIButton *but=[UIButton buttonWithType:0];
    but.frame=CGRectMake(10, 6, 60, 30);
    [but setTitle:@"返回" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [but setBackgroundImage:[UIImage imageNamed:@"按钮左"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
  
    UIImageView*imgv=[[UIImageView alloc]initWithFrame:CGRectMake(30, 100+88-10, 260,120+80)];
    imgv.image=[UIImage imageNamed:@""];
    imgv.userInteractionEnabled=YES;
     _textview=[[NoteView alloc]initWithFrame:CGRectMake(0, 2, 260, 118+80)];
    _textview.delegate=self;
//    [_textview becomeFirstResponder];
    [_textview.layer setCornerRadius:5.0f];
	[_textview.layer setBorderWidth:2.0f];
	[_textview.layer setBorderColor:[UIColor blackColor].CGColor];
   _textview.returnKeyType=UIReturnKeyGo;
    _textview.font=[UIFont systemFontOfSize:14.0f];
    _textview.backgroundColor=[UIColor whiteColor];//颜色
    [imgv addSubview:_textview];
    [_backImage addSubview:imgv];
    _search=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 40, 320, 40)];
    _search.barStyle=UIBarStyleBlackTranslucent;//设置样式
    _search.delegate=self;
    _search.placeholder=@"搜索你要提意见的小区名";
    [self.view addSubview:_search];
    //小区显示视图
    _searchTable=[[UITableView alloc]initWithFrame:CGRectMake(0,44+35, 320, height-88-30) style:UITableViewStyleGrouped];
    _searchTable.dataSource=self;
    _searchTable.delegate=self;
    _searchTable.hidden=YES;
    [self.view addSubview:_searchTable];

    UILabel *caget=[[UILabel alloc]initWithFrame:CGRectMake(40, 90+30, 320-80,40)];
    caget.text=@"建议 我的小区";
    caget.tag=1;
    caget.textAlignment=UITextAlignmentCenter;
    [caget.layer setCornerRadius:5.0f];
	[caget.layer setBorderWidth:2.0f];
	[caget.layer setBorderColor:[UIColor blackColor].CGColor];
    [_backImage addSubview:caget];
    [caget release];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(30, 70+88-10, 80, 40)];
    label1.backgroundColor=[UIColor clearColor];
    label1.text=@"建议内容";
    [_backImage addSubview:label1];
    [label1 release];
    
    _labelword=[[UILabel alloc]initWithFrame:CGRectMake(130, 70+88-10, 200, 40)];
    _labelword.backgroundColor=[UIColor clearColor];
    _labelword.text=[NSString stringWithFormat:@"还可以输入500字"];
    _labelword.textColor=[UIColor lightGrayColor];
    [_backImage addSubview:_labelword];
 
    //在键盘上添加一个按钮 用于回收键盘
    UIBarButtonItem *bar1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *Bar2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"jianpan.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(RecoveryOfTheKeyboard:)] ;
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    NSArray *array=[[NSArray alloc]initWithObjects:bar1,Bar2, nil];
    toolbar.items=array;
    toolbar.barStyle=UIBarStyleBlackTranslucent;//透明
    _textview.inputAccessoryView=toolbar;
    UIButton *completebut=[UIButton buttonWithType:0];
    completebut.frame=CGRectMake(320-65, 6, 60, 30);
    [completebut setTitle:@"提交" forState:UIControlStateNormal];
    [completebut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [completebut addTarget:self action:@selector(feedbackaction:) forControlEvents:UIControlEventTouchUpInside];
    [completebut setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    [self.view addSubview:completebut];
    _activityViewLoad = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityViewLoad.frame = CGRectMake(0, 0,20, 20);
    _activityViewLoad.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:_activityViewLoad];
   }

//将要开始编辑进的代理
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //添加动画
    [UIView animateWithDuration:0.4 animations:^{
        _backImage.frame=CGRectMake(0,0-40, 320, 480);
        
    }];
    
    return YES;
}
//回收键盘
-(void)RecoveryOfTheKeyboard:(id)sender
{
    [_textview resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        _backImage.frame=CGRectMake(0, 0, 320, 480);}];
   }
//+(BOOL)setpredicate:(NSString *)sender //设定邮箱验证 信息
//{
//    NSString *match = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"; //注意\d正则法则在OC中表达式\\d
//    
//    NSPredicate *result = [NSPredicate predicateWithFormat:@"SELF matches %@",match];//用谓词过滤
//    return  [result evaluateWithObject:sender];//用通过谓词对象 判断传进来的参数是否符合 是BOOL值
//}
-(void)feedbackaction:(id)sender
{
   if ([self textLength:_textview.text]<1) {  //没有内容
        _textview.text=@"";
       [self AlertViewAction:nil];
   }
   else   //内容不为空
      {
          [_textview resignFirstResponder];
          EncapsulationASI *en=[[EncapsulationASI alloc]init];
          en.delegate=self;
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
          NSString *firstName = [defaults objectForKey:@"firstName"];
          [en  startRequstASIurl:@"InfoManage/InsertService.asmx/InsertUserAdvise" andgroupindex:@"0711111" andsendinfo:_textview.text userindex:firstName addinfo:@"req1" andsitecode:nil];
          _textview.text=@"";
         [self RecoveryOfTheKeyboard:nil];
       }

}
//    else
//    {
//      if (![MySuggestionViewController  setpredicate: _textfild.text] ) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确邮箱 格式应为任意字母数字 +@在任意字母数字 + 一个小数点 +2个或3个大小字母组成" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//        
//    }
//    else
//    {
//
//           [self outemail:[NSString stringWithFormat:@"%@\n发邮件者:%@",_textview.text,_textfild.text]];
//        [self RecoveryOfTheKeyboard:nil];
//    }
//    }
//}
-(void)AlertViewAction:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入改善意见" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];

}
#pragma mark 字符串长度
//计算字符串长度
- (int)textLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}
#pragma mark TextDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    //    label2.text=[[NSNumber numberWithUnsignedInteger:textView.text.length]stringValue];//显示输入多少个字;
    _labelword.text=[NSString stringWithFormat:@"还可以输入%@字",[[NSNumber numberWithUnsignedInteger:500- textView.text.length]stringValue]];//显示还能输入多少个字
    //该判断用于联想输入限制输入最大的字数
    if (textView.text.length >500)
    {
        textView.text = [textView.text substringToIndex:500];//字符串取前300个字符
    }
  
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   // 用的比较多少的是把return设问回收键盘
    if ([text isEqualToString:@"\n"])  //判断输入的字符是不是 return键
    {
        if ([self textLength:_textview.text]<1) {
            _textview.text=@"";
            [self AlertViewAction:nil];
        }
        else
        {
            [self feedbackaction:nil];
            [self RecoveryOfTheKeyboard:nil];
        }
        
}
  return YES;
}
#pragma mark SearchBar Delegate Methods
//点击将要开始编辑时进入代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	searchBar.showsCancelButton = YES;//显示一个取消按钮
	for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            
        }
    }
	return YES;
}
//编辑将要结束时进入代理
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton=NO;//不显示取消按钮
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_search resignFirstResponder];
    _search.text=@"";
    _searchTable.hidden=NO;
    
}
//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if (searchBar.text) {
        [self searchcommunity:searchBar.text];
    }

}

//当searchBar里 的类容将要发生变化时调用该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  // called when text changes (including clear)
{
    if (searchText.length>0) {
          [self searchcommunity:searchBar.text];
    }
    
    //    table.hidden=YES;
}
//搜索小区请求
-(void)searchcommunity:(NSString *)search{
    NSURL *url=[NSURL URLWithString:@"http://222.247.37.152/InfoManage/SelectService.asmx/GetPropertyAllForName"];
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:search forKey:@"strName"];
    PostRequst.userInfo=[NSDictionary dictionaryWithObject:@"req4" forKey:@"name"];
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
    EncapsulationASI *en=[EncapsulationASI new];
    en.delegate=self;

}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    [_activityViewLoad startAnimating];//开始
    NSString *strData=[[NSString alloc]initWithData:   [request responseData] encoding:NSUTF8StringEncoding];
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
      if([[request.userInfo objectForKey:@"name"] isEqualToString:@"req4"]){
            NSLog(@"%@=======",strData);
            NSDictionary *dic=[strData JSONValue];
            [_activityViewLoad stopAnimating];
            if ( [[dic objectForKey:@"status"]intValue]==1) {
                _Mycommunity=[NSMutableArray new];//初始化一个数组
                NSArray *arr=[dic objectForKey:@"data"];
                for (int i=0; i<[arr count]; i++) {
                    UrlAddress *url=[UrlAddress new];
                    url.groupindex= [[arr objectAtIndex:i] objectForKey:@"groupindex"];
                    url.groupname=[[arr objectAtIndex:i] objectForKey:@"groupname"];
                    url.GroupImage=[[arr objectAtIndex:i] objectForKey:@"GroupImage"];
                    url.remark=[[arr objectAtIndex:i]objectForKey:@"remark"];
                    [_Mycommunity addObject:url];
                    [url release];
                    NSLog(@"%d",[_Mycommunity count]);
                }
                _searchTable.hidden=NO;
                [_searchTable reloadData];}else{
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该小区还没添加或用户输入错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    [alert release];
                }
        }
    }else{
        NSLog(@"返回数据类型问题");
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)backaction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ===Tableview 
//块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
       return 1;
  
}
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return 0;
}

//块头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return  30;
}
//设置每块section的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
         
            return @"您是否对下面小区提建议";
  
}
//每个cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}
//每块的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_searchTable){
        return [_Mycommunity count];
    }
    return 1;
    
}
//每个cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ if(tableView ==_searchTable){
        
        static NSString *CellIdentifier = @"Cell2";
        UITableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (Cell==nil) {
            Cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
            //头名
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40,0,320-60,30)];
            label.font=[UIFont systemFontOfSize:15];
            label.backgroundColor=[UIColor clearColor];
            label.tag=1;
            [Cell.contentView addSubview:label];
            //内容
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40,20, 320-60,60)];
            label1.tag=2;
            label1.font=[UIFont systemFontOfSize:14];
            //            label1.lineBreakMode=UILineBreakModeWordWrap;
            label1.numberOfLines=2;
            label1.backgroundColor=[UIColor clearColor];
            [Cell.contentView addSubview:label1];
            //时间
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(320-80,62,80, 20)];
            label2.tag=3;
            label2.font=[UIFont systemFontOfSize:14];
            label2.backgroundColor=[UIColor clearColor];
            [Cell.contentView addSubview:label2];
            AsyncImageView *imagev=[[AsyncImageView alloc]initWithFrame:CGRectMake(0,20,40, 40)];
            imagev.tag=4;
            [Cell.contentView addSubview:imagev];
        }
        UrlAddress *url=((UrlAddress *)[_Mycommunity objectAtIndex:indexPath.row]);
        UILabel *label= (UILabel*) [Cell viewWithTag:1];
        label.text=url.groupindex;
        UILabel *label1=(UILabel*)[Cell viewWithTag:2];
        label1.text=url.groupname;
        //       UILabel *label2=(UILabel*)[Cell viewWithTag:3];
        ////       label.text=url.group;
        AsyncImageView *asy =(AsyncImageView*)[Cell viewWithTag:4];
        asy.urlString=url.GroupImage;
        return Cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UrlAddress *url= (UrlAddress *)[_Mycommunity objectAtIndex:indexPath.row];
    UILabel *labe=(UILabel*)[_backImage viewWithTag:1];
    labe.text=[NSString stringWithFormat:@"建议 %@ 小区",url.groupname];
    _searchTable.hidden=YES;
    [_search resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
