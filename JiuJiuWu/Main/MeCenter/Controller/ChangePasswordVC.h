//
//  ChangePasswordVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/19.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWBaseTableVC.h"

typedef NS_ENUM(NSInteger, ChangePasswordType) {
    ChangeLoginPasswordType = 0,
    ChangePayPasswordType,
};

@interface ChangePasswordVC : JJWBaseTableVC

@property (nonatomic, assign)ChangePasswordType type;

@end
