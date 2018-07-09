//
//  JJWUserDefaultTool.m
//  JiuJiuWu
//
//  Created by 付志敏 on 17/12/27.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "JJWUserDefaultTool.h"

@implementation JJWUserDefaultTool

@synthesize defaults;


+ (JJWUserDefaultTool *)getInstall{
    static JJWUserDefaultTool *install;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        install=[[JJWUserDefaultTool alloc]init];
        install.defaults=[NSUserDefaults standardUserDefaults];
    });
    return install;
}

- (void)setUsername:(NSString *)username {
    [defaults setObject:username forKey:@"username"];
    [defaults synchronize];
}

- (NSString *)username {
    
    return [defaults valueForKey:@"username"];
}

@end
