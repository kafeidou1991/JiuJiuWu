//
//  CTShareTool.m
//  CreditTreasury
//
//  Created by 咖啡豆 on 2017/8/11.
//  Copyright © 2017年 YinSheng Technology Co. Ltd. All rights reserved.
//

#import "CTShareTool.h"
#import "UShareUI/UShareUI.h"

static CTShareTool * share = nil;

#define RedirectURL @"https://itunes.apple.com/us/app/%E4%B9%9D%E4%B9%9D%E5%90%BE/id1282870764?l=zh&ls=1&mt=8"

static NSString * const UMengAppKey = @"592fea0e1061d2290b000a1a";

static NSString * const QQShareKey = @"1106527086";
static NSString * const QQShareSecret = @"R90BHMq9nFyUUvY9";

static NSString * const WXShareKey = @"wxdd739a82ee9261b3";
static NSString * const WXShareSecret = @"59654c5de13fc4195d8b87403654df80";


@implementation CTShareTool

+ (instancetype)shareDefault{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!share) {
            share = [[CTShareTool alloc]init];
        }
    });
    return share;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [super allocWithZone:zone];
    });
    
    return share;
}

+ (void) openShareUI:(UIViewController *)viewConroller ShareUrl:(NSString *)url Title:(NSString *)title DetailTitle:(NSString *)desTitle Icon:(NSString *)iconUrl{
//    ,@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [[CTShareTool shareDefault]shareWebPageToPlatformType:platformType VC:viewConroller ShareUrl:url Title:title DetailTitle:desTitle Icon:iconUrl];
        
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType VC:(UIViewController *)vc ShareUrl:(NSString *)url Title:(NSString *)title DetailTitle:(NSString *)desTitle Icon:(NSString *)iconUrl {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desTitle thumImage:STRISEMPTY(iconUrl) ? [UIImage imageNamed:@"sendShare_icon"] : iconUrl];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    [JJWBase alertMessage:@"分享成功" cb:nil];
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                    [JJWBase alertMessage:@"分享取消" cb:nil];
                }
            });
        }
    }];
}

+ (void)setupShare{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppKey];
    
    [[CTShareTool shareDefault] configUSharePlatforms];
    
    [[CTShareTool shareDefault] confitUShareSettings];
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXShareKey appSecret:WXShareSecret redirectURL:RedirectURL];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQShareKey/*设置QQ平台的appID*/  appSecret:QQShareSecret redirectURL:RedirectURL];
    
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}







@end
