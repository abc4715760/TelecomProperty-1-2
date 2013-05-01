//
//  UrlAddress.h
//  TelecomProperty
//
//  Created by 邓成其 on 13-4-9.
//  Copyright (c) 2013年 chutangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlAddress : NSObject

@property(nonatomic,retain)NSString *urlimage;//广告图片地址
@property(nonatomic,retain)NSString *urlAddress;//广告连接地址
@property(nonatomic,retain)NSString *sitecode;//编码
@property(nonatomic,retain)NSString *cityname;//长沙
@property(nonatomic,retain)NSString *NameFirstLetter;//拼音首字母
@property(nonatomic,retain)NSString *NameLetter;//拼音
/*
 通知类的属性
 */
@property(nonatomic,retain)NSString *NotifeID;//通知ID
@property(nonatomic,retain)NSString *Notifeinfo;//发送内容
@property(nonatomic,retain)NSString *Notifetitleinfo;//发送消息内容
@property(nonatomic,retain)NSString *Notifeuser;//通知用户名
@property(nonatomic,retain)NSString *Notifetime;//通知时间

/*
 个人资料*/
@property(nonatomic,retain)UIImage* imageurl;//[图像],
@property(nonatomic,retain)NSString * nickname;//[昵称]
@property(nonatomic,retain)NSString * signinfo;//[个性签名],
@property(nonatomic,retain)NSString * realname;//[真实姓名]
@property(nonatomic,retain)NSString * sexuality;//[性别],
@property(nonatomic,retain)NSString * birthday;//[生日],
@property(nonatomic,retain)NSString * age;//[年龄],
@property(nonatomic,retain)NSString * bornanimal;//[生肖],
@property(nonatomic,retain)NSString * constellation;//[星座],
@property(nonatomic,retain)NSString * bloodtype;//[血型],
@property(nonatomic,retain)NSString * job;//[从事职业]
@property(nonatomic,retain)NSString *mailbox;//[邮箱]
@property(nonatomic,retain)NSString *location;//现居住地址
/*
 小区介绍属性
 */
@property(nonatomic,retain)NSString *groupname;//小区名字
@property(nonatomic,retain)NSString *GroupImage;//小区照片
@property(nonatomic,retain)NSString * remark;//介绍
@property(nonatomic,retain)NSString *groupindex;//小区ID
@end
