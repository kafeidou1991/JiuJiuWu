//
//  NSString+YY.h
//  HisunPay
//
//  Created by sks on 16/3/6.
//  Copyright © 2016年 com.hisuntech. All rights reserved.
//  属性字符串

#import <Foundation/Foundation.h>


@interface NSString (YY)


/**
 *  属性字符串-设置单个
 *
 *  @param range 属性字符串的范围
 *  @param color 属性字符串颜色
 *  @param font  属性字符串字体大小
 *
 *  @return 返回设置好的属性字符串
 */
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range color:(UIColor *)color font:(UIFont *)font;


/**
 *  属性字符串-设置单个
 *
 *  @param originalString       字串全串
 *  @param attributedString     需要属性化的字符串
 *  @param color                属性字符串颜色
 *  @param fontSize             属性字符串字体大小
 *
 *  @return 返回设置好的属性字符串
 */
- (NSMutableAttributedString *)attributedString:(NSString *)attributedString color:(UIColor *)color font:(UIFont *)font;

/**
 *  属性字符串-设置多个
 */
- (NSMutableAttributedString *)attributedStrings:(NSArray *)attributedStrings color:(NSArray *)colors textFont:(NSArray *)fonts;

/**
 属性字符串-设置多个

 @param ranges 范围 每个对象为存放range的value
 @param colors 颜色
 @param fonts 字体
 @return
 */
- (NSMutableAttributedString *)attributedStringWithRanges:(NSArray *)ranges colors:(NSArray *)colors fonts:(NSArray *)fonts;
/**
 *  加下划线
 */
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range font:(UIFont *)font;


/**
 获取字符串长度

 @return 长度
 */
- (NSUInteger)charLength;


/**
 获取字符串中所有子串的位置

 @param searchString 子串
 @return NSArray
 */
- (NSArray *)rangesOfSearchString:(NSString *)searchString;

// 过滤掉json串中的\n \r
- (NSString *)filtrateJSONString;
@end
