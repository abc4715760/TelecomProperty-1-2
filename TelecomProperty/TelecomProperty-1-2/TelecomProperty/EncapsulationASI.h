//
//  EncapsulationASI.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-17.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@protocol EncapsupationDelegate <NSObject>

-(void)request:(NSString*)strData andreqname:(NSString *)userinfo;
@end
@interface EncapsulationASI : NSObject<ASIHTTPRequestDelegate>
@property(nonatomic,assign) id<EncapsupationDelegate>delegate;
@property(nonatomic,retain) NSString *stringURL;//网络地址
@property(nonatomic,retain)NSString * groupindex;//小区地址
@property(nonatomic,retain)NSString *sendinfo;//建议内容
@property(nonatomic,retain)NSString *dic;
@property(nonatomic,retain)NSString *userID;//用户唯一标示
@property(nonatomic,retain)NSString *code;//小区代码查询小区详情
@property(nonatomic,retain)NSString *Telephone;//用户注册号码
@property(nonatomic,retain)NSString *selectname;//搜索小区输入的名字  用于小区的名字的模糊查询
@property(nonatomic,retain)NSString  *NotifictionID;
-(void)startRequstASIurl:(NSString *)url andgroupindex:(NSString *)groupindex andsendinfo:(NSString*)info userindex:(NSString*)userID addinfo:(NSString *)dic andsitecode:(NSString*)sitecode;
+(void)alertView:(NSString *)title andmessage:(NSString *)message;
-(void)ASIRequstuserindex:(NSString* )userindex andnickname:(NSString *)nickname andrealname:(NSString *)realname andsexuality:(NSString *)sexuality andbirthday:(NSString *)birthday andage: (NSString *)age andbornanimal:(NSString *)bornanimal andconstellation:(NSString *)constellation andbloodtype:(NSString *)bloodtype andjob:(NSString *)job andeducational:(NSString *)educational andschool:(NSString *)school andmailbox:(NSString *)mailbox andbirthplace:(NSString *)birthplace andlocation:(NSString *)location andaddress:(NSString *)address andremark:(NSString *)remark andurl:(NSString*)strurl anddic:(NSString *)dic andsigninfo:(NSString*)signinfo;
+(NSMutableDictionary *)notifictionplist;
+(NSString *)UserIndex;
@end
