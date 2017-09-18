//
//  API_Parameter.h
//  YZF
//
//  Created by 张竟巍 on 2017/5/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#ifndef API_Parameter_h
#define API_Parameter_h

#pragma mark ---------------------- 域名 ---------------------------
#ifdef DEBUG //开发环境
//0 测试环境  1 正式环境
#define environment 1

#if environment
static NSString * const baseUrl = @"http://www.jiujiuwu.cn/api/";
#else
static NSString * const baseUrl = @"http://www.jiujiuwu.cn/api/";
#endif

#else //发布环境
static NSString * const baseUrl = @"http://www.jiujiuwu.cn/api/";
#endif

#pragma mark ---------------------- 参数字段、功能 ----------------------------
//注册获取短信验证卡
#define RegistGetCode [baseUrl appendBaseUrl:@"user/sendMobileValidateCode"]
//验证验证码
#define CheckRegistCode [baseUrl appendBaseUrl:@"user/checkMobileValidateCode"]
//注册账户
#define RegistUser [baseUrl appendBaseUrl:@"user/reg"]
//用户登录
#define UserLogin [baseUrl appendBaseUrl:@"user/login"]
//用户登录
#define UpdateBankInfo [baseUrl appendBaseUrl:@"user/updateUserBankInfo"]






#endif /* API_Parameter_h */
