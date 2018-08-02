//
//  NSString+category.m
//  MiniSales
//
//  Created by sunjun on 13-7-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "NSString+category.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <CommonCrypto/CommonDigest.h>
@implementation NSString(chCategory)

//- (NSString *)URLEncodedString
//{
//    NSString *encodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)self,
//                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
//                                                              NULL,
//                                                              kCFStringEncodingUTF8));
//    return encodedString;
//}
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
//判断手机号码是否合法
-(BOOL)checkPhoneNumInput{
    
    NSString *Regex = @"^1[1|2|3|4|5|6|7|8|9]\\d{9}";
    
    
    //NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:self];
}
//判断密码是否包含非法字符
- (BOOL)checkPassword {
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    return (tNumMatchCount + tLetterMatchCount) == self.length;
}

//判断输入的邮箱是否合法
-(BOOL)validateEmail{
    
    if( (0 != [self rangeOfString:@"@"].length) &&  (0 != [self rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [self rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        
        // If username part contains any character other than "."  "_" "-"
        
        NSString *usernamePart = [self substringToIndex:range1.location];
        NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
        for (NSString *string in stringsArray1) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        NSString *domainPart = [self substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2) {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else // no ''@'' or ''.'' present
        return NO;
}
//服务端返回链接不包含域名
- (NSString *)configDomain{
    
    if (STRISEMPTY(self)) {
        return @"";
    }
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    NSString * domain = @"";
#ifdef DEBUG //开发环境
    //0 测试环境  1 正式环境
    if (environment) {
        domain = @"http://www.jiujiuwu.cn/";
    }else {
        domain = @"http://dev.jiujiuwu.cn/";
    }
#else
    domain = @"http://www.jiujiuwu.cn/";
#endif
    return [NSString stringWithFormat:@"%@%@",domain,self];
}


@end


@implementation NSMutableString (category)

-(NSRange) replaceString:(NSString *)search replace:(NSString *)replace
{
    NSRange substr = [self rangeOfString:search]; // 字符串查找,可以判断字符串中是否有
    if (substr.location != NSNotFound) {
         [self replaceCharactersInRange:substr withString:replace];
    }
    return substr;
}


@end


@implementation NSString (URLEncodingAdditions)

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,(CFStringRef)self, CFSTR(""),kCFStringEncodingUTF8));
    return result;
}

+ (NSString *)macAddress
{
    int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	//NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
}

+ (NSString *)md5Digest:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}
@end






@implementation NSNumber(dollar_ex)
-(NSString *) stringValueDollar
{
    double dvalue =  [self doubleValue];
    NSString *svalue = [NSNumber numberWithFloat:dvalue].stringValue;
    NSArray *arr = [svalue componentsSeparatedByString:@"."];
    if(arr && arr.count == 2){
        //整数部分
        NSMutableString *result = [NSMutableString stringWithString:[arr objectAtIndex:0]];
        //小数部分
        NSString *decimals = [arr objectAtIndex:1];
        if(decimals.length > 0)
        {
            if(decimals.length > 2)
                decimals = [decimals substringToIndex:2];
            [result appendString:@"."];
            [result appendString:decimals];
        }
        return result;
    }else{
        return svalue;
    }
}
@end
