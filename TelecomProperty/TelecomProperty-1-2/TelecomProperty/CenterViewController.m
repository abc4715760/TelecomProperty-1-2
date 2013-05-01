//
//  CenterViewController.m
//  WaterFlowViewDemo
//
//  Created by Smallsmall on 12-6-11.
//  Copyright (c) 2012年 activation group. All rights reserved.
//

#import "CenterViewController.h"

@implementation CenterViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)dealloc
{
    [super dealloc];
    arrayData=nil;
    _userimage=nil;
    waterFlow =nil;
    [arrayData release];

   
}
#pragma mark - requstImage

- (void)loadInternetData {  //

    EncapsulationASI *en=[EncapsulationASI new];
    en.delegate=self;
    [en startRequstASIurl:@"InfoManage/SelectService.asmx/GetPropertyImage" andgroupindex:@"073101010001" andsendinfo:nil userindex:nil addinfo:@"req1" andsitecode:nil];
}
-(void)request:(NSString *)strData andreqname:(NSString *)userinfo
{
    
    NSDictionary *dic=[strData JSONValue];
    if ([dic isKindOfClass:[NSDictionary class]] ) {
        if ([userinfo isEqualToString:@"req1"]) {
            if ([[dic objectForKey:@"status"] intValue]==1) {
                NSArray *arr=[dic objectForKey:@"data"];
                arrayData=[NSMutableArray new];
                for (int i=0; i<[arr count]; i++) {
                    [arrayData addObject:[arr objectAtIndex:i]];
                }
                [self dataSourceDidLoad];
            }
            else {
                [self dataSourceDidError];
            }}else{
                NSLog(@"返回数据问题");
            }
   }
    }
#pragma mark ====
- (void)dataSourceDidLoad {

    [waterFlow reloadData];
    self.view.userInteractionEnabled=YES;
}

- (void)dataSourceDidError {
    [waterFlow reloadData];
    self.view.userInteractionEnabled=YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
     self.view.userInteractionEnabled=NO;
    [super viewDidLoad];
    _userimage=[UIImageView new];
    arrayData = [[NSMutableArray alloc] init];
    //背景图片
    UIImageView *backImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backimage.png"]];
    backImage.frame=CGRectMake(0,0, 320,self.view.bounds.size.height);
    [self.view addSubview:backImage];
    [backImage release];
    //导航条
    UIImageView *navigation=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"顶部2.png"]];
    navigation.frame=CGRectMake(0, 0, 320, 44);
    navigation.userInteractionEnabled=YES;
    [self.view addSubview:navigation];
    [navigation release];
    UILabel *username=[[UILabel  alloc]init];
    username.frame=CGRectMake(0,0,320,44);
    username.text=@"小区实景";
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
    
    UIButton *upload=[UIButton buttonWithType:0];
    upload.frame=CGRectMake(320-60, 6, 60, 30);
    [upload setTitle:@"相片" forState:UIControlStateNormal];
    [upload setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [upload setBackgroundImage:[UIImage imageNamed:@"按钮右"] forState:UIControlStateNormal];
    [upload addTarget:self action:@selector(tapuserimageaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upload];
   
    waterFlow = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 43, 320,CGRectGetHeight(self.view.frame))];
    waterFlow.waterFlowViewDelegate = self;
    waterFlow.waterFlowViewDatasource = self;
    waterFlow.backgroundColor = [UIColor redColor];
    [self.view addSubview:waterFlow];
     [self loadInternetData];
   

}

-(void)backaction:(id)sender
{
      [self.navigationController popViewControllerAnimated:YES];
}
//显示更多
-(void)loadMore{
    [self loadInternetData];//加载
}

#pragma mark WaterFlowViewDataSource
- (NSInteger)numberOfColumsInWaterFlowView:(WaterFlowView *)waterFlowView{

    return 3;
}
- (NSInteger)numberOfAllWaterFlowView:(WaterFlowView *)waterFlowView{

    return [arrayData count];
}
//每个单元格显示的内容视图
- (UIView *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(IndexPath *)indexPath{
    ImageViewCell *view = [[ImageViewCell alloc] initWithIdentifier:nil];
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, 30)];
    l.textColor=[UIColor redColor];
      l.text=[NSString stringWithFormat:@"%@",[[arrayData objectAtIndex:(waterFlowView.columnCount *indexPath.row+indexPath.column)] objectForKey:@"iid"]];
    l.backgroundColor=[UIColor clearColor];
    [view addSubview:l];
    return view;
}

// 找到每张图片的对应的连接地址  发送请求
-(void)waterFlowView:(WaterFlowView *)waterFlowView  relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath{
    //arrIndex是某个数据在总数组中的索引 
    int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;//waterFlowView.columnCount 是分多少列 indexPath.column是这个图在哪一列  indexPath.row 是在哪一行
   NSDictionary *object = [arrayData objectAtIndex:arrIndex] ;
    ImageViewCell *imageViewCell = (ImageViewCell *)view;
    imageViewCell.indexPath = indexPath;
    imageViewCell.columnCount = waterFlowView.columnCount;
     [imageViewCell relayoutViews];
    [(ImageViewCell *)view setImageWithURL:[NSString stringWithFormat:@"%@",[object objectForKey:@"Imageurl"]]];

}


#pragma mark WaterFlowViewDelegate
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(IndexPath *)indexPath{
/*
    设置每个cell的高度适应内容高度
 */
//    int arrIndex = indexPath.row * waterFlowView.columnCount + indexPath.column;
//    NSDictionary *dict = [arrayData objectAtIndex:arrIndex];
//
//    float width = 0.0f;
//    float height = 0.0f;
//    if (dict) {
//        width = [[dict objectForKey:@"width"] floatValue]; 
//        height = [[dict objectForKey:@"height"] floatValue];
//        /*
//         字典取出的高度 或宽带有可能为0  要设为1  不然除就会蹦
//         */
//        if (width==0) {
//            width=1.f;
//        }if (height==0) {
//            height=1.f;
//        }
//    }
//    return waterFlowView.cellWidth * (height/width);
    return 100;
}

- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(IndexPath *)indexPath{

    NSLog(@"%@===%d", [arrayData objectAtIndex:(waterFlowView.columnCount *indexPath.row+indexPath.column)],(waterFlowView.columnCount *indexPath.row+indexPath.column));
    AsyncImageView *asyimage=[AsyncImageView new];
    asyimage.urlString= [[arrayData objectAtIndex:(waterFlowView.columnCount *indexPath.row+indexPath.column)] objectForKey:@"Imageurl"];
    [self buttonDown:[ RTImage ImageWithImageSimple:asyimage.image scaledToSize:CGSizeMake(asyimage.image.size.width/2,asyimage.image.size.height/2)]];

    
}
- (void)buttonDown:(UIImage *)image
{
    waterFlow.userInteractionEnabled=NO;
    label=[[UILabel alloc]initWithFrame:CGRectMake(00, 0, 320, 580)];
    label.backgroundColor=[UIColor lightGrayColor];
    label.alpha=0.5;
    label.tag=1;
    [self.view addSubview:label];
    
    AsyncImageView *contentView=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 300,300)];
    contentView.center=self.view.center;
    contentView.image=image;
    contentView.userInteractionEnabled=YES;
    [contentView addTarget:self action:@selector(viewDismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:contentView];
    [contentView release];

}
-(void)viewDismiss:(AsyncImageView*)sender
{
    waterFlow.userInteractionEnabled=YES;
    //删除图片
    [sender removeFromSuperview];
    label.alpha=0;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)tapuserimageaction:(id)sender
{
    UIActionSheet *Sheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"相册" otherButtonTitles:@"照相", nil];
    [Sheet addButtonWithTitle:@"取消"];
    Sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;//设置样式
    [Sheet   showInView:[UIApplication sharedApplication].keyWindow];
    /*
     注意事项，在开发过程中，发现有时候UIActionSheet的最后一项点击失效，点最后一项的上半区域时有效，这是在特定情况下才会发生，这个场景就是试用了UITabBar的时候才有。解决办法：
     在 showView时这样使用，[actionSheet showInView: [UIApplication sharedApplication].keyWindow];或者[sheet showInView: [AppDelegate sharedDelegate].tabBarController.view];这样就不会发生遮挡现象了。
     */
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if (buttonIndex==0) {
        [self fromPhotoes];
    }else if(buttonIndex==1){
        [self fromcamare:nil];
    }
}
-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{

}
#pragma mark  相册
-(void)fromPhotoes//相册
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//判断设备是否支持相册功能
    {
        UIImagePickerController *imagePickerC=[[UIImagePickerController alloc]init];
        imagePickerC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary; 
        imagePickerC.allowsEditing=YES;//是否对图片进行编辑
        imagePickerC.delegate=self;
        [self performSelector:@selector(performView:) withObject:imagePickerC afterDelay:0]; 
        
    }else{
        [self alertaction:@"该设备不支持相册"];
    }
    
}
-(void)performView:(UIImagePickerController*)imagePickerC
{
  [self presentViewController:imagePickerC animated:YES completion:^{
    
} ];//推出照片选择的页面

}
-(void)alertaction:(NSString *)sender{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:sender delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//回调方法：当选择一个相片后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    [self requestImage:[info valueForKey:@"UIImagePickerControllerOriginalImage"]];

    
    [picker dismissViewControllerAnimated:NO completion:^{
//        [NSThread detachNewThreadSelector:@selector(requestImage:) toTarget:self withObject:[info valueForKey:UIImagePickerControllerEditedImage]];//分一条线程
        if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
             [self requestImage:[info valueForKey:UIImagePickerControllerEditedImage]];

        }else{
            [self requestImage:[info valueForKey:UIImagePickerControllerOriginalImage]];

        }
           }]; //关闭照片选择页面
}

//回调方法：当取消选择照片后调用
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)myProgressTask {
    // This just increases the progress indicator in a loop
//    sleep(5550);
}
#pragma mark ======
#pragma mark====loadimage
-(void)requestImage :(UIImage*)image //上传图片
{
    _userimage.image=[RTImage ImageWithImageSimple:image scaledToSize:CGSizeMake(image.size.width,image.size.height)];
    DescriptionphotoViewController *description=[[DescriptionphotoViewController alloc]init];
    description.photo=_userimage.image;
    [self.navigationController pushViewController:description animated:YES];
    
//    //分界线的标识符
//    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
//    //根据url初始化request
//    NSString *url=@"http://222.247.37.152/WebUpImage.aspx";
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]       cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                       timeoutInterval:10];
//    //分界线 --AaB03x
//    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//    //结束符 AaB03x--
//    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
//    //要上传的图片
//    UIImage *myImage=_userimage.image;
//    //得到图片的data
//    
//    NSData* data =UIImageJPEGRepresentation(myImage, 0.1);
//    //http body的字符串
//    NSMutableString *body=[[NSMutableString alloc]init];
//    //添加分界线，换行
//    [body appendFormat:@"%@\r\n",MPboundary];
//    //声明pic字段，文件名为boris.png
//    [body appendFormat:@"Content-Disposition: form-data; name=\"FileName\"; filename=\"073101010001#15#正问#.png\"\r\n"]; 
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"]);
//    //声明上传文件的格式
//    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
//    //声明结束符：--AaB03x--
//    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
//    //声明myRequestData，用来放入http body
//    NSMutableData *myRequestData=[NSMutableData data];
//    //将body字符串转化为UTF8格式的二进制
//    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//    //将image的data加入
//    [myRequestData appendData:data];
//    //加入结束符--AaB03x--
//    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//    //设置HTTPHeader中Content-Type的值
//    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
//    //设置HTTPHeader
//    [request setValue:content forHTTPHeaderField:@"Content-Type"];
//    //设置Content-Length
//    [request setValue:[NSString stringWithFormat:@"%d",[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
//    //设置http body
//    [request setHTTPBody:myRequestData];
//    //http method
//    [request setHTTPMethod:@"POST"];
//    [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    Data=[[NSMutableData alloc]init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[Data appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSString *strdata=[[NSString alloc]initWithData:Data encoding:NSUTF8StringEncoding];
//    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//    HUD.mode = MBProgressHUDModeCustomView;
//    NSString *str=[strdata substringToIndex:13];
// if ([[str  JSONValue] isKindOfClass:[NSDictionary class]]) {
//        if ( [[[str JSONValue] objectForKey:@"status"] intValue]==1) {
//        HUD.labelText=@"完成";
//    }else{
//      HUD.labelText=@"上传失败";
//    }
//        }
//    if (HUD) {
//        [HUD hide:YES afterDelay:1];
//    }
     [self loadInternetData];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.labelText=@"失败";
//    if (HUD) {
//    [HUD hide:YES afterDelay:1];
//     [self loadInternetData];
//    }
 [self loadInternetData];
}
//判断是否是真机
-(void)fromcamare:(id)sender{
    
    if ([UIImagePickerController  isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])//判断该机器是否支持相机
    {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;//照相机源代码
        [self presentModalViewController:picker animated:YES];
        
    }
    else
    {
        [self alertaction:@"该设备无法使用，没有照相机设备"];
        NSLog(@"无法使用，没有照相机设备");
    }
}

@end
