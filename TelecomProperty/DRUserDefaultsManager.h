//
//  DRUserDefaultsManager.h
//  DingRuanCGM
//
//  Created by dingruan on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "DRAlertManager.h"


@interface DRUserDefaultsManager : NSObject

+ (DRUserDefaultsManager *)sharedUserDefaultsManager;
+ (void)setSharedUserDefaultsManager:(DRUserDefaultsManager *)userDefaultsManager;

- (void)setUserDefaultObject:(id)string forKey:(NSString *)key;
- (NSObject *)objectForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;

- (BOOL)synced;
- (void)setSyncedDone;

- (BOOL)activated;
- (void)setActivationCode:(NSString *)code;

- (NSString *)userID;
- (void)setUserID:(NSString *)userID;
- (BOOL)userIDExists;

- (NSString *)userEmail;
- (void)setUserEmail:(NSString *)userEmail;

- (NSString *)userPassword;
- (void)setUserPassword:(NSString *)userPassword;

- (NSString *)userNickname;
- (void)setUserNickname:(NSString *)userNickname;

- (NSString *)userAvatarURL;
- (void)setUserAvatarURL:(NSString *)userAvatarURL;

- (NSNumber *)userGender;
- (void)setUserGender:(NSNumber *)userGender;

- (NSString *)userMobile;
- (void)setUserMobile:(NSString *)userMobile;

- (NSString *)hostDomain;
- (void)setHostDomain:(NSString *)host;

- (void)logout;

- (NSNumber *)tutorialShowed:(NSString *)key;
- (void)setTutorialShowed:(NSString *)key;

- (NSString *)sessionKey;
- (void)setSessionKey:(NSString *)sessionKey;

- (NSNumber *)isRememberPassword;
- (void)setIsRememberPassword:(NSNumber *)isRememberPassword;

- (NSNumber *)isAutoLogin;
- (void)setIsAutoLogin:(NSNumber *)isAutoLogin;

- (NSArray *)expressenPermission;
- (void)setExpressenPermission:(NSArray *)expressen;

- (CGFloat)timeout;
- (void)setTimeout:(NSString *)timeout;

- (NSInteger)maxAmount;
- (void)setMaxAmount:(NSString *)amount;

@end
