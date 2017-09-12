//
//  JJWGlobal.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateCenter.h"

#define SCreenWidth      (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.width))
#define SCreenHegiht     (([UIScreen mainScreen].bounds.size.height < [UIScreen mainScreen].bounds.size.width)?([UIScreen mainScreen].bounds.size.width):([UIScreen mainScreen].bounds.size.height))
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

@property (nonatomic, strong) DloginData * loginData;

+(instancetype) sharedMethod;

- (void) saveLoginData:(DloginData *)data;
-(void) removeLoingData;

@end
