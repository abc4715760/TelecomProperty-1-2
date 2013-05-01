//
//  RTImage.h
//  CameraTest2
//
//  Created by  rtsafe02 on 12-11-1.
//  Copyright (c) 2012年 TelSafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTImage : NSObject
+(void)SaveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
+(UIImage*)ImageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
