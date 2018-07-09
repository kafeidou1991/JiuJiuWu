//
//  JJWBase.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBase.h"
#import "FRDLivelyButton.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@implementation JJWBase

+ (UIBarButtonItem *) backButton:(id) taget action:(SEL)action
{
    FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0, 0,22.f,28.f)];
    [button setStyle:kFRDLivelyButtonStyleCaretLeft animated:NO];
    [button setOptions:@{kFRDLivelyButtonLineWidth:@(1.50f),kFRDLivelyButtonHighlightedColor:[UIColor whiteColor],kFRDLivelyButtonColor:[UIColor whiteColor]}];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)createCustomBarButtonItem:(id)target action:(SEL)action title:(NSString *)title
{
    if (STRISEMPTY(title)) {
        return nil;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14.f];
    CGSize size = STR_FONT_SIZE(title,200, button.titleLabel.font);
    button.frame=CGRectMake(0, 0, size.width, size.height+10.f);
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:UIColorFromRGBA(0xffffff, 0.5) forState:UIControlStateDisabled];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)createCustomBarButtonItem:(id)target action:(SEL)action image:(NSString *)imagestr
{
    if (STRISEMPTY(imagestr)) {
        return nil;
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = IMAGE_SIZE(imagestr);
    button.frame=CGRectMake(0, 0, size.width, size.height);
    [button setImage:[UIImage imageNamed:imagestr] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imagestr] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imagestr] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+(UIButton *) createButton:(CGRect) frame type:(UIButtonType)buttonType title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:buttonType];
    if(!STRISEMPTY(title)){
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = frame;
    return button;
}

+(void) alertMessage:(NSString*)msg cb:(ALertCompletion) completion
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *win = app.window;
    MBProgressHUD *HUD = (MBProgressHUD *)[win viewWithTag:8012];
    if(HUD==nil){
        HUD =  [[MBProgressHUD alloc] initWithView:win];
        
        HUD.tag = 8012;
        HUD.mode = MBProgressHUDModeText;
        [win addSubview:HUD];
        HUD.removeFromSuperViewOnHide = YES;
        HUD.contentColor = [UIColor whiteColor];
        HUD.bezelView.color = [UIColor blackColor];
    }
    HUD.label.text = msg;
    [HUD showAnimated:YES];
    HUD.completionBlock = ^{
        if(completion){
            completion(YES);
        }
    };
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUD hideAnimated:YES afterDelay:1.5f];
    });
    
}

+(UILabel *)createLabel:(CGRect) frame font:(UIFont *)font text:(NSString *)text defaultSizeTxt:(NSString *)sizeDefault color:(UIColor *)txtColor backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)align{
    CGRect lr = frame;
    CGSize fsize = CGSizeMake(0, 0);
    fsize = [sizeDefault sizeWithAttributes: @{NSFontAttributeName:font}];
    CGSize labelSize = (STRISEMPTY(sizeDefault))?frame.size:fsize;
    lr.size = labelSize;
    UILabel *label = [[UILabel alloc] initWithFrame:lr];
    label.font = font;
    label.textColor = txtColor;
    label.backgroundColor = backgroundColor;
    [label setTextAlignment:align];
    label.text = (STRISEMPTY(text))?@"":text;
    return label;
}

@end
