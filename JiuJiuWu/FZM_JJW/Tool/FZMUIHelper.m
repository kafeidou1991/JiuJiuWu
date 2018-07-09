//
//  SCTUIHelper.m
//  JiuJiuWuPay
//
//  Created by 付志敏 on 17/9/2.
//  Copyright © 2017年 付志敏. All rights reserved.
//

#import "FZMUIHelper.h"

@implementation FZMUIHelper

@end

@implementation FZMUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title
                                image:(UIImage *)image
                        selectedImage:(UIImage *)selectedImage
                                  tag:(NSInteger)tag {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
    tabBarItem.selectedImage = selectedImage;
    return tabBarItem;
}

@end

@implementation FZMUIHelper (UIImage)

//改变图片颜色 只支持按路径渲染
+ (UIImage *)generateNewImageWithBlendColor:(UIColor *)color
                                     image:(UIImage *)originalImage{
    UIImage *newImage = [originalImage qmui_imageWithBlendColor:color];
    
    return newImage;
}

+ (UIImage *)generateNewImageWithTintColor:(UIColor *)color
                                     image:(UIImage *)originalImage{
    UIImage *newImage = [originalImage qmui_imageWithTintColor:color];
    
    return newImage;
}


/*改变图片大小*/
+ (UIImage *)generateNewImageScaleToSize:(CGSize)size
                                   image:(UIImage *)originalImage{
    UIImage *newImage = [originalImage qmui_imageWithScaleToSize:CGSizeMake(50, 50)];
    
    return newImage;
}

/*旋转图片*/
+ (UIImage *)generateNewImageOrientation:(UIImageOrientation)orientation
                                   image:(UIImage *)originalImage{
    UIImage *newImage = [originalImage qmui_imageWithOrientation:orientation];
    
    return newImage;
}

@end


@implementation FZMUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton {
    QMUIButton *button = [[QMUIButton alloc] qmui_initWithSize:CGSizeMake(200, 40)];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = JJWThemeColor;
    button.highlightedBackgroundColor = [JJWThemeColor qmui_transitionToColor:UIColorBlack progress:.15];// 高亮时的背景色
    button.layer.cornerRadius = 4;
    return button;
}

@end

@implementation FZMUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size {
    NSString * strSize = nil;
    if (size >= 1048576.0) {
        strSize = [NSString stringWithFormat:@"%.2fM", size / 1048576.0f];
    } else if (size >= 1024.0) {
        strSize = [NSString stringWithFormat:@"%.2fK", size / 1024.0f];
    } else {
        strSize = [NSString stringWithFormat:@"%.2fB", size / 1.0f];
    }
    return strSize;
}

@end

@implementation FZMUIHelper (QMUITextView)

+ (QMUITextView *)sct_creatQMUITextViewTitle:(NSString *)title textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize{
    QMUITextView *textView = [[QMUITextView alloc] init];
    textView.placeholder = title;
    textView.textColor = textColor;
    textView.font = UIFont_PFSCR_Make(fontSize);
    
    return textView;

}

@end

@implementation FZMUIHelper (QMUITextField)

+ (QMUITextField *)sct_creatQMUITextFieldPlaceholder:(NSString *)placeholder textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize{
    QMUITextField *textView = [[QMUITextField alloc] init];
    textView.placeholder = placeholder;
    textView.textColor = textColor;
    textView.font = UIFont_PFSCR_Make(fontSize);
    
    return textView;
    
}

@end

@implementation FZMUIHelper (UIView)

+ (void)sct_compressionHuggingHorizontal:(UILayoutPriority)layoutPriority view:(UIView *)view{
    [view setContentCompressionResistancePriority:layoutPriority forAxis:UILayoutConstraintAxisHorizontal];
    [view setContentHuggingPriority:layoutPriority forAxis:UILayoutConstraintAxisHorizontal];
}

@end
