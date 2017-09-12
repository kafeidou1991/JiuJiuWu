//
//  NSString+category.h
//  MiniSales
//
//  Created by sunjun on 13-7-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(chCategory)
- (BOOL)isPureInt;
-(BOOL)checkPhoneNumInput;
-(BOOL)validateEmail;
@end


@interface NSMutableString (category)

-(NSRange) replaceString:(NSString *)search replace:(NSString *)replace;
@end

@interface NSNumber(dollar_ex)
-(NSString *) stringValueDollar;
@end

@interface NSString (URLEncodingAdditions)

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

+ (NSString *)macAddress;
+ (NSString *)md5Digest:(NSString *)str;
@end
