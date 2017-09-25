//
//  PresentPayTypeVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/25.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseTableVC.h"

typedef NS_ENUM(NSInteger, PayType) {
    PayCardType = 0, //银行卡
    PayWXType,       //微信支付
    PayAlipayType,   //支付宝支付
    
};
typedef void(^PayTypeBlock)(PayType);
@interface PayTypeVC : JJWBaseTableVC

@property (nonatomic, copy) PayTypeBlock block;

@end
