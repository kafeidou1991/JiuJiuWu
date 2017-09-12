//
//  NSString+AppendSubBaseurl.h
//  YZF
//
//  Created by 张竟巍 on 2017/3/28.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


//次类别 是为了增加不同的子字段 请求。。

@interface NSString (AppendSubBaseurl)

- (NSString *)appendBaseUrl:(NSString *)sub;

@end
