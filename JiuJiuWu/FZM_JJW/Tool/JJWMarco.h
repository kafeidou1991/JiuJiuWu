//
//  JJWMarco.h
//  JiuJiuWu
//
//  Created by 付志敏 on 17/12/27.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#ifndef JJWMarco_h
#define JJWMarco_h

#define JJWUserDefaultCofigKit  [JJWUserDefaultTool getInstall]

#define PGY_AppId @"b07a857097c4a1500d9a56d1e405c3a6"

#define JJWImageFile(filePath,imageType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:filePath ofType:imageType]]

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_IOS_11 (IOS_VERSION >= 11.0 ? YES : NO)

#endif /* JJWMarco_h */
