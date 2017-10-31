//
//  JJWGlobal.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateCenter.h"
@class JJWBaseVC;
#define LOGIN_DATA_KEY @"LOGIN_DATA_KEY"

@interface JJWGlobal : NSObject

@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *apipath;
+(instancetype) sharedMethod;


@end


// 用户方面的参数
@interface JJWLogin : NSObject

@property(nonatomic,assign, readonly) BOOL isLogin;

@property (nonatomic, assign) BOOL isVisitor;//是否是体验用户
//登录数据
@property (nonatomic, strong) DloginData * loginData;
//版本信息
@property (nonatomic, strong) Version_App * version;

+(instancetype) sharedMethod;

- (void) saveLoginData:(DloginData *)data;
-(void) removeLoingData;

//检测资料是否齐全
- (BOOL)checkInfo:(JJWBaseVC *)viewController complete:(void (^)())block;

@end
