//
//  ManageCardVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseTableVC.h"

typedef NS_ENUM(NSInteger, BindCardType) {
    BindRegisterCardType = 0, //从判断状态过来
    BindChangeCardType,  //从center进来
};

@interface ManageCardVC : JJWBaseTableVC

@property (nonatomic, assign) BindCardType type;

@end
