//
//  LevelItem.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/25.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "DateCenter.h"

@interface LevelItem : DateCenter

@property (nonatomic, copy) NSString * level_id;
@property (nonatomic, copy) NSString * amount;
@property (nonatomic, copy) NSString * discount;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * level_name;
@property (nonatomic, copy) NSString * describe;
@property (nonatomic, copy) NSString * scale;
@property (nonatomic, assign) BOOL select;

@end
