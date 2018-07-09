//
//  NSDate+Category.m
//  MHTTPRequestTest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (category)

-(NSString *) toString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:self];
}
-(NSString *) toString:(NSString *)frame
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:frame];
    return [dateFormatter stringFromDate:self];
}

+(NSDate *) StringToDate:(NSString *)strDate
{
    //NSString *myDateString = @"2010-12-08";
    //拿到原先的日期格式
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:@"yyyy-MM-dd"]; //2010-12-08 06:53:43
    
    //将NSString转换为NSDate
    NSDate *theDate  = [inputFormat dateFromString:strDate];
    return theDate;
    
}


+(NSDate *) StringToDate:(NSString *)strDate Formatte:(NSString *)format
{
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:format]; //2010-12-08 06:53:43
    
    //将NSString转换为NSDate
    NSDate *theDate  = [inputFormat dateFromString:strDate];
    return theDate;
}

+ (NSString *)timeStringFromDate:(NSDate *)date
{
    NSDate *hh = date;
    NSDate * nowDate =[NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * comp =[gregorian components:unitFlags fromDate:hh toDate:nowDate options:0];
    NSString * shareTime;
    if ([comp year]==0){
        if ([comp month]==0){
            if ([comp day]==0){
                if ([comp hour]==0){
                    if ([comp minute]==0){
                        shareTime = [NSString stringWithFormat:@"1分钟内"];
                    }else{
                        shareTime = [NSString stringWithFormat:@"%ld分钟前",(long)[comp minute]];
                    }
                }else{
                    shareTime = [NSString stringWithFormat:@"%ld小时前",(long)[comp hour]];
                }
            }else{
                shareTime = [NSString stringWithFormat:@"%ld天前",(long)[comp day]];
            }
        }else{
            shareTime = [NSString stringWithFormat:@"%ld个月前",(long)[comp month]];
        }
    }else {
        shareTime = [NSString stringWithFormat:@"%ld年前",(long)[comp year]];
    }
    return shareTime;
}

+ (NSString *)getWeekDayFordate:(long long)date
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

// 获取当前是星期几
- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

@end
