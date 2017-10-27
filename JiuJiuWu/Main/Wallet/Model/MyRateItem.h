//
//  MyRateItem.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/27.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "DateCenter.h"

@interface MyRateItem : DateCenter

@property (nonatomic, copy) NSString * channel_type;
@property (nonatomic, copy) NSString * channel_id;
@property (nonatomic, copy) NSString * is_open;
@property (nonatomic, copy) NSString * level;
@property (nonatomic, copy) NSString * limit_amont;
@property (nonatomic, copy) NSString * scale_id;
@property (nonatomic, copy) NSString * scale;
@property (nonatomic, copy) NSString * channel_name;
@end
