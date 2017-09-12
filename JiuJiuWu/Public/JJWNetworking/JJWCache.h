//
//  JJWCache.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJWCache : NSObject
/**
 存储缓存
 
 @param data 网络数据
 @param key key
 */
+ (void)saveDataCache: (id)data forKey:(NSString *)key;


/**
 读取缓存
 
 @param key key
 */
+ (id)readCache:(NSString *)key ;

/**
 获取缓存总大小
 */
+ (void)getAllCacheSize;

/**
 删除指定缓存
 
 @param key key
 */
+ (void)removeChache:(NSString *)key;

/**
 删除全部缓存
 */
+ (void)removeAllCache;

@end
