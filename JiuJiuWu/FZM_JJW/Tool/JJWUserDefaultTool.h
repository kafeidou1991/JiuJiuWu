//
//  JJWUserDefaultTool.h
//  JiuJiuWu
//
//  Created by 付志敏 on 17/12/27.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJWUserDefaultTool : NSObject

@property (nonatomic,retain) NSUserDefaults *defaults;

+ (JJWUserDefaultTool *)getInstall;

//记录账号
- (void)setUsername:(NSString *)username;
- (NSString *)username;

@end
