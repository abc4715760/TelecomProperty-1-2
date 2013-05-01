//
//  DRUserDefaultsManager.m
//  DingRuanCGM
//
//  Created by dingruan on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DRUserDefaultsManager.h"

#define STORED_ACTIVATION_CODE_KEY @"ACTIVATION_CODE"
#define STORED_SYNCED_STATUS_KEY @"SYNCED_STATUS"
#define STORED_USER_ID_KEY @"USER_ID"
#define STORED_USER_EMAIL_KEY @"USER_EMAIL"
#define STORED_USER_PASSWORD_KEY @"USER_PASSWORD"
#define STORED_USER_WEIBO_KEY @"USER_WEIBO"
#define STORED_USER_NICKNAME_KEY @"USER_NICKNAME"
#define STORED_USER_AVATAR_KEY @"USER_AVATAR"
#define STORED_USER_GENDER_KEY @"USER_GENDER"
#define STORED_USER_MOBILE_KEY @"USER_MOBILE"
#define STORED_HOST_DOMIAN_KEY @"HOST_DOMAIN"
#define STORED_SESSION_KEY @"SESSION_KEY"
#define STORED_REMEMBER_PASSWORD_KEY @"REMEMBER_PASSWORD"
#define STORED_AUTO_LOGIN_KEY @"AUTO_LOGIN"
#define STORED_EXPRESSEN_KEY @"EXPRESSEN"
#define STORED_TIME_OUT_KEY @"TIME_OUT"
#define STORED_MAX_AMOUNT_KEY @"MAX_AMOUNT"

#define STORED_PREFER_FONT_SIZE_KEY_NAME @"STORED_PREFER_FONT_SIZE"

@implementation DRUserDefaultsManager

static DRUserDefaultsManager *_userDefaultsManager = nil;

- (id)init {
	self = [super init];
	if (self) {
        if (![self stringForKey:STORED_USER_ID_KEY]) {
            [self setUserDefaultObject:@"0" forKey:STORED_USER_ID_KEY];
        }
        if (![self stringForKey:STORED_USER_EMAIL_KEY]) {
            [self setUserDefaultObject:@"0" forKey:STORED_USER_EMAIL_KEY];
        }
        if (![self stringForKey:STORED_SYNCED_STATUS_KEY]) {
            [self setUserDefaultObject:@"0" forKey:STORED_SYNCED_STATUS_KEY];
        }
	}
	return self;
}

+ (DRUserDefaultsManager *)sharedUserDefaultsManager {
    if (!_userDefaultsManager) {
        _userDefaultsManager = [[DRUserDefaultsManager alloc] init];
    }
    return _userDefaultsManager;
}

+ (void)setSharedUserDefaultsManager:(DRUserDefaultsManager *)userDefaultsManager {
    [_userDefaultsManager release];
    _userDefaultsManager = [userDefaultsManager retain];
}

- (void)setUserDefaultObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

- (NSObject *)objectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *object = [defaults objectForKey:key];
    return object;
}

- (NSString *)stringForKey:(NSString *)key {
    NSString *string = (NSString *)[self objectForKey:key];
    if ([string isKindOfClass:[NSNumber class]]) {
        string = [NSString stringWithFormat:@"%@", string];
    }
    return string;
}

- (NSNumber *)numberForKey:(NSString *)key {
    NSNumber *number = (NSNumber *)[self objectForKey:key];
    if ([number isKindOfClass:[NSNumber class]]) {
        return number;
    } else {
        return [NSNumber numberWithInt:0];
    }
}

- (BOOL)synced {
    
    if ([[self stringForKey:STORED_SYNCED_STATUS_KEY] isEqualToString:@"0"]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)setActivationCode:(NSString *)code {
    [self setUserDefaultObject:code forKey:STORED_ACTIVATION_CODE_KEY];
}

- (BOOL)activated {
    if ([self stringForKey:STORED_ACTIVATION_CODE_KEY]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setSyncedDone {
    [self setUserDefaultObject:@"1" forKey:STORED_SYNCED_STATUS_KEY];
}

- (NSString *)userID {
    return [self stringForKey:STORED_USER_ID_KEY];
}

- (void)setUserID:(NSString *)userID {
    [self setUserDefaultObject:userID forKey:STORED_USER_ID_KEY];
}

- (BOOL)userIDExists {
    
    if ([[self stringForKey:STORED_USER_ID_KEY] isEqualToString:@"0"]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)userPassword {
    return [self stringForKey:STORED_USER_PASSWORD_KEY];
}

- (void)setUserPassword:(NSString *)userPassword {
    [self setUserDefaultObject:userPassword forKey:STORED_USER_PASSWORD_KEY];
}

- (NSString *)userEmail {
    return [self stringForKey:STORED_USER_EMAIL_KEY];
}

- (void)setUserEmail:(NSString *)userEmail {
    [self setUserDefaultObject:userEmail forKey:STORED_USER_EMAIL_KEY];
}

- (NSString *)userNickname {
    return [self stringForKey:STORED_USER_NICKNAME_KEY];
}

- (void)setUserNickname:(NSString *)userNickname {
    [self setUserDefaultObject:userNickname forKey:STORED_USER_NICKNAME_KEY];
}

- (NSString *)userAvatarURL {
    return [self stringForKey:STORED_USER_AVATAR_KEY];
}

- (void)setUserAvatarURL:(NSString *)userAvatarURL {
    [self setUserDefaultObject:userAvatarURL forKey:STORED_USER_AVATAR_KEY];
}

- (NSNumber *)userGender {
    return [self numberForKey:STORED_USER_GENDER_KEY];
}

- (void)setUserGender:(NSNumber *)userGender {
    [self setUserDefaultObject:userGender forKey:STORED_USER_GENDER_KEY];
}

- (NSString *)userMobile {
    return [self stringForKey:STORED_USER_MOBILE_KEY];
}

- (void)setUserMobile:(NSString *)userMobile {
    [self setUserDefaultObject:userMobile forKey:STORED_USER_MOBILE_KEY];
}

- (NSString *)hostDomain {
    return [self stringForKey:STORED_HOST_DOMIAN_KEY];
}

- (void)setHostDomain:(NSString *)host {
    [self setUserDefaultObject:host forKey:STORED_HOST_DOMIAN_KEY];
}

- (CGFloat)timeout {
    return [[self stringForKey:STORED_TIME_OUT_KEY] floatValue];
}

- (void)setTimeout:(NSString *)timeout {
    [self setUserDefaultObject:timeout forKey:STORED_TIME_OUT_KEY];
}

- (NSInteger)maxAmount {
    return [[self stringForKey:STORED_MAX_AMOUNT_KEY] integerValue];
}

- (void)setMaxAmount:(NSString *)amount {
    [self setUserDefaultObject:amount forKey:STORED_MAX_AMOUNT_KEY];
}

- (void)logout {
    
    [self setUserID:@"0"];
    [self setUserEmail:@"0"];
    [self setUserMobile:@""];
    [self setUserNickname:@""];
    [self setUserAvatarURL:@""];
    [self setUserGender:[NSNumber numberWithInt:0]];
//    DGSocialManager *socialManager = [DGSocialManager sharedSocialManager];  
//    [socialManager unbindNetease];
//    [socialManager weiboDeauthorizeWithDelegate:nil];
//    [socialManager tencentDeauthorizeWithDelegate:nil];
//    [socialManager renrenDeauthorizeWithDelegate:nil];   
//    [[DGNetworkingManager sharedNetworkingManager] registerDevice];
}

- (NSNumber *)tutorialShowed:(NSString *)key {
    return [self numberForKey:key];
}

- (void)setTutorialShowed:(NSString *)key {
    [self setUserDefaultObject:[NSNumber numberWithBool:YES] forKey:key];
}

- (NSString *)sessionKey {
    return [self stringForKey:STORED_SESSION_KEY];
}

- (void)setSessionKey:(NSString *)sessionKey {
    [self setUserDefaultObject:sessionKey forKey:STORED_SESSION_KEY];
}

- (NSNumber *)isRememberPassword {
    return [self numberForKey:STORED_REMEMBER_PASSWORD_KEY];
}

- (void)setIsRememberPassword:(NSNumber *)isRememberPassword {
    [self setUserDefaultObject:isRememberPassword forKey:STORED_REMEMBER_PASSWORD_KEY];
}

- (NSNumber *)isAutoLogin {
    return [self numberForKey:STORED_AUTO_LOGIN_KEY];
}

- (void)setIsAutoLogin:(NSNumber *)isAutoLogin {
    [self setUserDefaultObject:isAutoLogin forKey:STORED_AUTO_LOGIN_KEY];
}

- (NSArray *)expressenPermission {
    return (NSArray*)[self objectForKey:STORED_EXPRESSEN_KEY];
}

- (void)setExpressenPermission:(NSArray *)expressen {
    [self setUserDefaultObject:expressen forKey:STORED_EXPRESSEN_KEY];
}

@end
