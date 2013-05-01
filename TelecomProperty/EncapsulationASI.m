//
//  EncapsulationASI.m
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-17.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import "EncapsulationASI.h"

@implementation EncapsulationASI
-(void)startRequstASIurl:(NSString *)url andgroupindex:(NSString *)groupindex andsendinfo:(NSString*)info userindex:(NSString*)userindex addinfo:(NSString*)dic andsitecode:(NSString*)sitecode
{

    _sendinfo=info;
    _stringURL=url;
    _groupindex=groupindex;
    _dic=dic;
    _userID=userindex;
    _code=sitecode;
    [self requestURL];

}
-(void)requestURL
{
  
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://222.247.37.152/%@",_stringURL]];
    NSLog(@"=====%@====",url);
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    if (_userID) {
         [PostRequst setPostValue:_userID forKey:@"userindex"];
    }
    if (_groupindex) {
      
         [PostRequst setPostValue:_groupindex forKey:@"groupindex"];

    }if (_sendinfo) {
        [PostRequst setPostValue:_sendinfo forKey:@"sendinfo"];
    }if (_code) {
        [PostRequst setPostValue:_code forKey:@"sitecode"];
    }
    if (_Telephone) {
         [PostRequst setPostValue:_code forKey:@"telephone"];
    }
    if (_selectname) {
          [PostRequst setPostValue:_selectname forKey:@"strName"];
    }
    if (_NotifictionID) {
        [PostRequst setPostValue:_NotifictionID forKey:@"StrRid"];
    }
    NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:_dic,@"name", nil];
    PostRequst.userInfo= dictionary;
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
    [dictionary release];
    [PostRequst release];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString *strData=[[NSString alloc]initWithData: [request responseData]encoding:NSUTF8StringEncoding];
    [self.delegate request:strData andreqname:[request.userInfo objectForKey:@"name"]];
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败");
}
+(void)alertView:(NSString *)title andmessage:(NSString *)message
{
UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
     [alert show];
    [alert release];}
-(void)ASIRequstuserindex:(NSString* )userindex andnickname:(NSString *)nickname andrealname:(NSString *)realname andsexuality:(NSString *)sexuality andbirthday:(NSString *)birthday andage: (NSString *)age andbornanimal:(NSString *)bornanimal andconstellation:(NSString *)constellation andbloodtype:(NSString *)bloodtype andjob:(NSString *)job andeducational:(NSString *)educational andschool:(NSString *)school andmailbox:(NSString *)mailbox andbirthplace:(NSString *)birthplace andlocation:(NSString *)location andaddress:(NSString *)address andremark:(NSString *)remark andurl:(NSString*)strurl anddic:(NSString *)dic andsigninfo:(NSString*)signinfo {
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://222.247.37.152/%@",strurl]];
    NSLog(@"%@==%@===%@",url,userindex,nickname);
    ASIFormDataRequest *PostRequst=[[ASIFormDataRequest alloc]initWithURL:url];
    [PostRequst setPostValue:userindex forKey:@"userindex"];
   [PostRequst setPostValue:nickname forKey:@"nickname"];
    [PostRequst setPostValue:realname forKey:@"realname"];
    [PostRequst setPostValue:sexuality forKey:@"sexuality"];
    [PostRequst setPostValue:sexuality forKey:@"birthday"];
    [PostRequst setPostValue:age forKey:@"age"];
    [PostRequst setPostValue:bornanimal forKey:@"bornanimal"];
    [PostRequst setPostValue:constellation forKey:@"constellation"];
    [PostRequst setPostValue:bloodtype forKey:@"bloodtype"];
    [PostRequst setPostValue:job forKey:@"job"];
    [PostRequst setPostValue:educational forKey:@"educational"];
    [PostRequst setPostValue:school forKey:@"school"];
    [PostRequst setPostValue:mailbox forKey:@"mailbox"];
    [PostRequst setPostValue:birthday forKey:@"birthplace"];
    [PostRequst setPostValue:location forKey:@"location"];
    [PostRequst setPostValue:address forKey:@"address"];
    [PostRequst setPostValue:remark forKey:@"remark"];
     [PostRequst setPostValue:signinfo forKey:@"signinfo"];
    
    NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:dic,@"name", nil];
    PostRequst.userInfo= dictionary;
    PostRequst.delegate=self;
    [PostRequst startAsynchronous];//发起异步请求
}
//userindex=15&nickname=12&realname=11&sexuality=12&birthday=11&age=11&bornanimal=1&constellation=1&bloodtype=1&job=1&educational=1&school=1&mailbox=1&birthplace=1&location=1&address=1&remark=1
+(NSMutableDictionary *)notifictionplist{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Notification" ofType:@"plist"];
    NSString *filePath = [self datafilePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])//如果沙盒不存在就copy到路径到沙盒文件里真运行必须要
    {
        [[NSFileManager defaultManager] copyItemAtPath:dataPath toPath:filePath error:nil];
    }
  return [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
}
+(NSString *)datafilePath//返回数据文件的完整路径名。
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docPath stringByAppendingPathComponent:@"Notification.plist"];
}
+(NSString *)UserIndex{
    NSString *user=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    return user;
}
@end
