//
//  NSString+AppendSubBaseurl.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/28.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "NSString+AppendSubBaseurl.h"

@implementation NSString (AppendSubBaseurl)

- (NSString *)appendBaseUrl:(NSString *)sub{
    NSNumber * number = [[NSUserDefaults standardUserDefaults]objectForKey:@"INNER_TEST_CODE"];
    if (number) {
        if ([number isEqual: @(2)]) {
            //正式环境
            return [NSString stringWithFormat:@"%@%@",@"https://api.yongqingjt.com/yinzhifuapi/",sub];
        }else{
            //测试环境
            return [NSString stringWithFormat:@"%@%@",@"http://test.yongqingjt.com:8080/yinzhifuapi/",sub];
        }
    }
    return [NSString stringWithFormat:@"%@%@",STRISEMPTY([JJWGlobal sharedMethod].apipath) ? self : ([[JJWGlobal sharedMethod].apipath hasSuffix:@"/"] ? [NSString stringWithFormat:@"%@",[JJWGlobal sharedMethod].apipath] : [NSString stringWithFormat:@"%@/",[JJWGlobal sharedMethod].apipath]),sub];
}


@end
