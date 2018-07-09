//
//  UIImage+load.h
//  MiniSales
//
//  Created by sunjun on 13-7-4.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+Resolutions.h"
@interface UIImage (load)

+(id) imageLoad:(NSString *)name;
+(id) imageColor:(UIColor *)color size:(CGSize)size;
+(id) imageColor:(UIColor *)scolor end:(UIColor *)endColor size:(CGSize)size;

+(UIImage*) grayscale:(UIImage*)anImage type:(char)type;
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
/**
 *  根据视频地址截取视频图片
 *
 *  @param videoUrl 视频地址
 *
 *  @return UIImage
 */
+(UIImage *)getImage:(NSString *)videoUrl;
@end
