//
//  JJWBase.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <Foundation/Foundation.h>

#define themeColor UIColorRGB(43,188,98)
//分割线
#define CellLine_Color UIColorFromRGB(0xe3e9ee)
#define CommonBackgroudColor UIColorFromRGB(0xF2F3F4)
#define STRISEMPTY(str) (str==nil || [str isEqual:[NSNull null]] || [str isEqualToString:@""])
#define APP_Address @"https://itunes.apple.com/us/app/%E9%93%B6%E6%99%BA%E4%BB%98/id1221203134?mt=8"

//处理颜色
#define UIColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define IMAGE_SIZE(imageName) [UIImage imageNamed:imageName].size

#define STR_FONT_SIZE(str,maxWidth,font) [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size
//邀请码链接
#define loadUrl [NSString stringWithFormat:@"http://yinzhifu.yongqingjt.com/index/member/qrcode.html?member_id=%@",[JJWLogin sharedMethod].loginData.member.cmid]
#define HelpUrl [NSString stringWithFormat:@"http://q.eqxiu.com/s/Tucz4UvN"]
#define SuperPartner [NSString stringWithFormat:@"http://yinzhifu.yongqingjt.com/index/member/upgrade.html?member_id=%@",[JJWLogin sharedMethod].loginData.member.cmid]
#define CardApplyUrl @"http://lx.jifuzf.com/mobile/index/lx_xin?id=VzVng2zX&aciton=1.html"

#define kTabBarHeight 49

#define NAVIGATION_BAR_HEIGHT   64.0f

// xcode8 bug
#ifdef DEBUG
#define DLog(format, ...) printf("class: < %s:(%d) > method: %s \n%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DLog(format, ...)
#endif

#pragma mark - 设备相关

#define IS_IPHONE4 [[UIScreen mainScreen] bounds].size.height == 480.0f
#define IS_IPHONE5 [[UIScreen mainScreen] bounds].size.height == 568.0f
#define IS_IPHONE6 [[UIScreen mainScreen] bounds].size.height == 667.0f
#define IS_IPHONE6_PLUS [[UIScreen mainScreen] bounds].size.height == 736.0f

#pragma mark - 系统相关

#define IS_IOS_9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)
#define IS_IOS_10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)


#define WeakSelf   __block __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

#define BLACKBAR_BUTTON [JJWBase backButton:self action:@selector(backAction:)]
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_NAME [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_ID  @"49ba59abbe56e057" //针对不同App拥有不同的appid
#define APP_INVITE_CODE [NSString stringWithFormat:@"http://yinzhifu.yongqingjt.com/index/member/register.html?invitationCodea=%@",[JJWLogin sharedMethod].loginData.member.invitation_codea]

#define Segment_height 30
#define STTR_ater_on @"请稍后..."

typedef void (^ALertCompletion)(BOOL compliont);

@interface JJWBase : NSObject

+ (UIBarButtonItem *) backButton:(id) taget action:(SEL)action;
+(UIBarButtonItem *)createCustomBarButtonItem:(id)target action:(SEL)action title:(NSString *)title;
+(UIBarButtonItem *)createCustomBarButtonItem:(id)target action:(SEL)action image:(NSString *)imagestr;
+(UIButton *) createButton:(CGRect) frame type:(UIButtonType)buttonType title:(NSString *)title;
+(UILabel *)  createLabel:(CGRect) frame font:(UIFont *)font text:(NSString *)text defaultSizeTxt:(NSString *)sizeDefault color:(UIColor *)txtColor backgroundColor:(UIColor *)backgroundColor;

//提醒
+(void) alertMessage:(NSString*)msg cb:(ALertCompletion) completion;

//构造器
+(UILabel *)  createLabel:(CGRect) frame font:(UIFont *)font text:(NSString *)text defaultSizeTxt:(NSString *)sizeDefault color:(UIColor *)txtColor backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)align;

@end
