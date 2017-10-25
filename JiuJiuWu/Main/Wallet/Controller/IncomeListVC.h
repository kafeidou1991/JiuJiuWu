//
//  IncomeListVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/23.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseTableVC.h"
typedef NS_ENUM(NSInteger, ListType) {
    ListType_Income = 0, //交易记录
    ListType_MyCashDis,       //我的分润
};
@interface IncomeListVC : JJWBaseTableVC

@property (nonatomic, assign) ListType type;

@end
