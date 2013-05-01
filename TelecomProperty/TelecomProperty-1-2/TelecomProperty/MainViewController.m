//
//  MainViewController.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-3-10.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "MainViewController.h"
#import "GameTopUpViewController.h"//游戏充值
#import "WingToPayViewController.h"//翼支付
#import "NumberKnowledgeablePersonViewController.h"//号码百事通
#import "ReservationViewController.h"//飘雨预定
#import "SearthViewController.h"//搜索周边
#import "RestaurantViewController.h"//号百餐馆
#import "QueryViewController.h"//114查询
#import "PhysicalNavigationViewController.h"//天翼导航
#import "JSON.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma UIGridViewDelgate
-(CGFloat)gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    return 120;
}
-(CGFloat)gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return 98;
}
-(NSInteger)numberOfColumnsOfGridView:(UIGridView *)grid
{
    return 3;
}
-(UIGridViewCell *)gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    Cell *cell=(Cell *)[grid dequeueReusableCell];
    if (cell==nil) {
        cell=[[Cell alloc]init];
    }
    if (rowIndex==0&&columnIndex==0) {
        cell.label.text=@"天翼导航";
        cell.thumbnail.image=[UIImage imageNamed:@"nav.png"];
    }else if (rowIndex==0&&columnIndex==2){
        cell.label.text=@"总机服务";
        cell.thumbnail.image=[UIImage imageNamed:@"total.png"];
    }
    else if (rowIndex==0&&columnIndex==1){
        cell.label.text=@"114查号";
        cell.thumbnail.image=[UIImage imageNamed:@"call.png"];
    }else if (rowIndex==1&&columnIndex==0){
        
        cell.label.text=@"QQ充值";
        cell.thumbnail.image=[UIImage imageNamed:@"qbi.png"];
    }else if (rowIndex==1&&columnIndex==1){
        cell.label.text=@"黄金岛充值";
        cell.thumbnail.image=[UIImage imageNamed:@"gold.jpg"];

    }else if (rowIndex==1&&columnIndex==2){
        cell.label.text=@"号码百事通";
         cell.thumbnail.image=[UIImage imageNamed:@"hb.png"];
    }else if (rowIndex==2&&columnIndex==0){
//        cell.label.text=@"号百餐馆";
    }else if (rowIndex==2&&columnIndex==1){
//         cell.label.text=@"飘雨预订";
       }else if (rowIndex==2&&columnIndex==1){
        cell.label.text=@"待添加5";
    }else if (rowIndex==3&&columnIndex==0){
        cell.label.text=@"待添加6";
    }
    [grid setSeparatorColor:[UIColor clearColor]];//没个cell的分割线
    return [cell autorelease];
}
-(NSInteger)numberOfCellsOfGridView:(UIGridView *)grid
{
    return 6;
}
-(void)gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    if (rowIndex==0&&colIndex==0) {
        [self pageViewController:@"1"];
    }else if (rowIndex==0&&colIndex==1){
        [self pageViewController:@"2"];
    }else if (rowIndex==0&&colIndex==2){
        [self pageViewController:@"3"];
    }else if (rowIndex==1&&colIndex==0){
        [self  pageViewController:@"4"];
    }else if (rowIndex==1&&colIndex==1){
        [self  pageViewController:@"5"];
    }else if (rowIndex==1&&colIndex==2){
        [self  pageViewController:@"6"];
    }else if (rowIndex==2&&colIndex==0){
        [self  pageViewController:@"7"];
    }else if (rowIndex==2&&colIndex==1){
        [self pageViewController:@"8"];
    }else if (rowIndex==2&&colIndex==2){
//        [self  pageViewController:@"9"];
    }else if (rowIndex==3&&colIndex==0){
//        [self  pageViewController:@"10"];
    }
}
#pragma ViewController
-(void)pageViewController:(id)sender
{
    switch ([sender intValue]) {
        case 1:
        {  PhysicalNavigationViewController *Physical=[[PhysicalNavigationViewController alloc]init];
            [self.navigationController pushViewController:Physical animated:YES];
            [Physical release];
            break;
        }
        case 2:{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://114"]];
//            QueryViewController *query=[[QueryViewController alloc]init];
//            [self.navigationController pushViewController:query animated:YES];
            break;
        }
        case 3:
        {
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:@"tel://114"];// 貌似tel:// 或者 tel: 都行
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            //记得添加到view上
            [self.view addSubview:callWebview];
            [callWebview release];
//            RestaurantViewController *restaurant=[[RestaurantViewController alloc]init];
//            [self.navigationController pushViewController:restaurant animated:YES];
            break;
        }
        case 4:{
            WingToPayViewController *wingtopay=[[WingToPayViewController alloc]init];
            [self.navigationController pushViewController:wingtopay animated:YES];
            [wingtopay release];
            break;
        }
        case 5:{
            GameTopUpViewController *GameTopUp=[[GameTopUpViewController alloc]init];
            [self.navigationController pushViewController:GameTopUp animated:YES];
            [GameTopUp release];
                      break;
        }
        case 6:
        {
            NumberKnowledgeablePersonViewController *number=[[NumberKnowledgeablePersonViewController alloc]init];
            [self.navigationController pushViewController:number animated:YES];
            [number release];
            break;
        }
        case 8:{
            ReservationViewController *reservation=[[ReservationViewController alloc]init];
            [self.navigationController pushViewController:reservation animated:YES];
            [reservation release];
                break;
        }
        case 7:{
            SearthViewController *searth=[[SearthViewController alloc]init];
            [self.navigationController pushViewController:searth animated:YES];
            [searth release];
            break;
        }

        default:
            break;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"等待更新" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    self.navigationController.navigationBarHidden=YES;
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    if(!iphone5)
    {
        backImage.frame=CGRectMake(0,0, 320, 480);
    }
    else
    {
        backImage.frame=CGRectMake(0,0, 320, 548);
    }

    [self.view addSubview:backImage];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
 
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"便民服务";
    username.backgroundColor=[UIColor clearColor];
    username.textColor=[UIColor whiteColor];
    username.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:username];
    [username release];
    [navigation release];
    [backImage release];
    
    _tabel=[[UIGridView alloc]initWithFrame:CGRectMake(0,44, 320, 460-88) ];
    _tabel.uiGridViewDelegate=self;
    _tabel.backgroundColor=[UIColor clearColor];
    _tabel.scrollEnabled=NO;
//    _tabel.backgroundView=[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"yueyangjingqu"]];
    [self.view addSubview:_tabel];
    [_tabel reloadData];
    
//    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(33, 33, 40, 30)];
//    label1.text=@"账号:";
//    [self.view addSubview:label1];
//    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(75, 33, 100,30 )];
//    field.placeholder=@"输入账号";
//    field.borderStyle=UITextBorderStyleLine;
//    field.delegate=self;
//    [self.view addSubview:field];
//    
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(33, 70, 40, 30)];
//    label2.text=@"信息:";
//    [self.view addSubview:label2];
//    _label3=[[UILabel alloc]initWithFrame:CGRectMake(75, 70, 320, 30)];
//     [self.view addSubview:_label3];
//    
//    UIButton *but1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    but1.frame=CGRectMake( 0,100,100,40);
//    [but1 setTitle:@"天翼导航" forState:UIControlStateNormal];
//    [self.view addSubview:but1];
    
    [self request:@"all"];
   
	// Do any additional setup after loading the view.
}
-(void)request:(id)sender
{
////    NSString *str=sender;
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://58.20.32.202:8090/InfoManage/SelectService.asmx/GetAreaData?sitecode=0101"]];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
////    [request setHTTPMethod:@"POST"];
////    NSString *parmas=[NSString stringWithFormat:@"UserName=%@",str];//13873109251
////    NSData *postdata=[parmas dataUsingEncoding:NSUTF8StringEncoding];
////    [request setHTTPBody:postdata];
//    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self request:textField.text];
    [textField resignFirstResponder];
    return YES;
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data=[[NSMutableData alloc]init];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSLog(@"--%@-----",_data);
    NSString *string=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
            NSLog(@"====%@====",string);
    
    [string  JSONValue];
//    NSLog(@"%@",[string JSONValue]);
    //创建解析的文档对象
//    GDataXMLDocument *doc=[[GDataXMLDocument alloc]initWithXMLString:string options:0 error:nil];
//    //获取要解析文档的root元素
//    GDataXMLElement *root=doc.rootElement;
//    NSArray *stuary=[root children];
//    NSString *stringelement;
//    GDataXMLElement *e=[stuary objectAtIndex:1];
//    NSLog(@"%@=%@",e.name,e.stringValue);
//    _label3.text=e.stringValue;
    
//    GDataXMLDocument *doc=[[GDataXMLDocument alloc]initWithXMLString:string options:1 error:nil];
//    GDataXMLElement * root=doc.rootElement;
////    NSLog(@"%@",root);
//    NSArray *docfirst=[root elementsForName:@"UserTemp"];
//    //    NSLog(@"%@",docfirst);
//    GDataXMLElement * docelement=[docfirst objectAtIndex:3];
//    //      NSLog(@"%@",[docelement stringValue]);
//    NSArray *two=[docelement children];
//    NSLog(@"===%@==",[two objectAtIndex:3]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
