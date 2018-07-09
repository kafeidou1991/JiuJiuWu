//
//  SCTUIHelper.h
//  JiuJiuWuPay
//
//  Created by 付志敏 on 17/9/2.
//  Copyright © 2017年 付志敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZMUIHelper : NSObject
    

@end

@interface FZMUIHelper (UITabBarItem)
/**tabbar数据配置*/
+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title
                                image:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                                  tag:(NSInteger)tag;

@end

@interface FZMUIHelper (UIImage)
/**改变图片颜色 不改变图片纹路*/
+ (UIImage *)generateNewImageWithTintColor:(UIColor *)color
                                     image:(UIImage *)originalImage;
+ (UIImage *)generateNewImageWithBlendColor:(UIColor *)color
                                      image:(UIImage *)originalImage;
/**将图片改变为指定大小*/
+ (UIImage *)generateNewImageScaleToSize:(CGSize)size
                                   image:(UIImage *)originalImage;
/**改变图片方向*/
+ (UIImage *)generateNewImageOrientation:(UIImageOrientation)orientation
                                   image:(UIImage *)originalImage;

@end

@interface FZMUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton;

@end

@interface FZMUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size;

@end

@interface FZMUIHelper (QMUITextView)

+ (QMUITextView *)sct_creatQMUITextViewTitle:(NSString *)title
                                   textColor:(UIColor *)textColor
                                    fontSize:(CGFloat)fontSize;

@end

@interface FZMUIHelper (QMUITextField)

+ (QMUITextField *)sct_creatQMUITextFieldPlaceholder:(NSString *)placeholder textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;

@end

@interface FZMUIHelper (UIView)

+ (void)sct_compressionHuggingHorizontal:(UILayoutPriority)layoutPriority view:(UIView *)view;

@end


