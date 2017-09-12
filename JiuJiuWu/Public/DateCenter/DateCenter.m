//
//  DateCenter.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/27.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "DateCenter.h"



@implementation DateCenter

@end

@implementation PageItem

@end

@implementation DloginData

-(NSString *)description{
    return [NSString stringWithFormat:@"%@-%@-%@",self.member.mobile,self.token,self.member.status];
}

@end

@implementation UserData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cmid" : @"id"};
}

@end

@implementation ShopData
@end

@implementation Version_App
@end
@implementation AppVersion
@end
@implementation PersionModel
@end
@implementation BandCardInfo
@end





