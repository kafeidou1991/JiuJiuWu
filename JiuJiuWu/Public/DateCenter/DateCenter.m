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

@end

@implementation Version_App
@end
@implementation BankItem

@end
@implementation CreditCardsList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"credit_list" : [QuickPayInfoItem class]};
}
@end
@implementation PaySuccessItem

@end
@implementation QuickPayInfoItem
- (instancetype)init{
    if (self = [super init]) {
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QuickPayInfoItem.plist"];
        id item = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (item) {
            self = item;
        }
    }
    return self;
}
- (void)saveProdfile{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QuickPayInfoItem.plist"];
    BOOL result = [NSKeyedArchiver archiveRootObject:self toFile:path];
    if (result) {
        DLog(@"归档成功:%@",path);
    }else
    {
        DLog(@"归档不成功!!!");
    }
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}
@end





