//
//  NSString+YY.m
//  HisunPay
//
//  Created by sks on 16/3/6.
//  Copyright © 2016年 com.hisuntech. All rights reserved.
//  属性字符串

#import "NSString+YY.h"


@implementation NSString (YY)


#pragma mark - 属性字符串
- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range color:(UIColor *)color font:(UIFont *)font {
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attriDic = @{NSForegroundColorAttributeName:color, NSFontAttributeName : font};
    [attriString setAttributes:attriDic range:range];
    
    return attriString;
}


- (NSMutableAttributedString *)attributedString:(NSString *)attributedString color:(UIColor *)color font:(UIFont *)font {
    
    NSRange range = [self rangeOfString:attributedString];
    return [self attributedStringWithRange:range color:color font:font];
}


- (NSMutableAttributedString *)attributedStrings:(NSArray *)attributedStrings color:(NSArray *)colors textFont:(NSArray *)fonts {
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSInteger i = 0; i < attributedStrings.count; i++) {
        
        NSRange range = [self rangeOfString:attributedStrings[i]];
        NSDictionary *attriDic = @{NSForegroundColorAttributeName:colors[i], NSFontAttributeName:fonts[i]};
        [attriString setAttributes:attriDic range:range];
    }
    return attriString;
}

- (NSMutableAttributedString *)attributedStringWithRanges:(NSArray *)ranges colors:(NSArray *)colors fonts:(NSArray *)fonts{
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    for(int i=0; i<ranges.count; i++){
        
        NSRange range = [ranges[i] rangeValue];
        NSDictionary *attriDic = @{NSForegroundColorAttributeName:colors[i], NSFontAttributeName:fonts[i]};
        [attriString setAttributes:attriDic range:range];
    }
    return attriString;
}


- (NSMutableAttributedString *)attributedStringWithRange:(NSRange)range font:(UIFont *)font
{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attriDic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle],NSStrokeColorAttributeName:[UIColor blackColor],NSFontAttributeName:font};
    [attriString setAttributes:attriDic range:range];
    return attriString;
}

/**
 获取字符串长度
 
 @return 长度
 */
- (NSUInteger)charLength {
    int strlength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}



- (NSArray *)rangesOfSearchString:(NSString *)searchString{
    
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [self length]);
    NSRange range;
    while ((range = [self rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [self length] - NSMaxRange(range));
        
    }
    return results;
}

- (NSString *)filtrateJSONString{
    
    NSString *newStr;
    newStr = [self stringByReplacingOccurrencesOfString:@"    " withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\\"
                                                   withString:@"" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [newStr length])];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r"
                                                   withString:@"" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [newStr length])];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n"
                                                withString:@"" options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [newStr length])];
    return newStr;
    
}

@end
