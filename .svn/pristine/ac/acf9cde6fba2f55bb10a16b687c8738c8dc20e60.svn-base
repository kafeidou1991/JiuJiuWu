//
//  CTShareTool.h
//  CreditTreasury
//
//  Created by 咖啡豆 on 2017/8/11.
//  Copyright © 2017年 YinSheng Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialCore/UMSocialCore.h"

typedef void(^AuthWeChatCode)(NSString *);

@interface CTShareTool : NSObject

+ (instancetype)shareDefault;

+ (void) setupShare;


/**
 是否正在授权中  因为微信绑定code跟友盟的share冲突，造成微信授权返回的 code无法使用，在handleOpenUrl方法内部使用
 */
@property (nonatomic, assign) BOOL isAuthing;

+ (void) openShareUI:(UIViewController *)viewConroller ShareUrl:(NSString *)url Title:(NSString *)title DetailTitle:(NSString *)desTitle Icon:(NSString *)iconUrl;

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType VC:(UIViewController *)vc ShareUrl:(NSString *)url Title:(NSString *)title DetailTitle:(NSString *)desTitle Icon:(NSString *)iconUrl;
@property (nonatomic, copy) AuthWeChatCode authBlock;
/**
 微信授权
 */
- (void)getAuthWithUserInfoFromWechatVC:(UIViewController *)vc Auth:(AuthWeChatCode)block;

@end
