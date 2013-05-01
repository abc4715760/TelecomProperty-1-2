//
//  HarpyConstants.h
//  
//
//  Created by Arthur Ariel Sabintsev on 1/30/13.
//
//

#warning Please customize Harpy's static variables

/*
 Option 1 (DEFAULT): NO gives user option to update during next session launch
 Option 2: YES forces user to update app on launch
 */
static BOOL harpyForceUpdate = NO; //是否强迫用户更新应用程序

 BOOL update;//区分是用户选择更新还是系统检查提示更新
// 2. Your AppID (found in iTunes Connect)
#define kHarpyAppID                 @"573293275"

// 3. Customize the alert title and action buttons
#define kHarpyAlertViewTitle        @"版本有更新"
#define kHarpyCancelButtonTitle     @"先不更新"
#define kHarpyUpdateButtonTitle     @"更新"
