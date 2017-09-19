//
//  CashKeyBoradVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/19.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseVC.h"

typedef NS_ENUM(NSInteger, PayType) {
    PayFaceToFaceType = 0, //当面付
    PayQuickType,    //快捷支付
    PayScanCodeType, //扫码付
};

@interface CashKeyBoradVC : JJWBaseVC

@property(nonatomic, assign)PayType payType;

@end
