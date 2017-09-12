//
//  IdCardApiHelper.h
//  YZF
//
//  Created by 张竟巍 on 2017/4/1.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdCardApiHelper : NSObject

+(instancetype) sharedMethod;
//查验身份证
- (void)checkIdCard:(UIImage *)image result:(void(^)(PersionModel *,NSError *))block;
//查验银行卡
- (void)checkBandIdCard:(UIImage *)image result:(void(^)(BandCardInfo *,NSError *))block;

@end



