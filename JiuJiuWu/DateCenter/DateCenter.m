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
- (NSString *)gesturePassword{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"DWGesturesLock"];
}
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
@implementation CheckItem
@end
@implementation IdsList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"adlist":[IdsItem class]};
}
@end
@implementation IdsItem
@end
@implementation AppVersion
@end
@implementation Version_App
@end
@implementation PersionModel
@end
@implementation BandCardInfo
@end
@implementation ShopModel
@end
@implementation NoticeAps
@end
@implementation CollectionRecrod
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"orderlist":[CollectionItem class]};
}
@end
@implementation CollectionItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cmid" : @"id"};
}
@end
@implementation PaySuccessItem
@end
@implementation DelegateList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"agents":[DelegateItem class],
             @"merchants":[DelegateItem class]};
}

@end
@implementation DelegateItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"member_id" : @"id"};
}
@end
@implementation AgentInfo
@end
@implementation UploadList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"qualification":[UploadModel class]};
}
@end
@implementation UploadModel
@end
@implementation ProfitDetailsList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"income":[CollectionItem class],@"withdrawalsList":[CollectionItem class]};
}
@end
@implementation PushList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"push_list" : [PushListItem class],@"noticelist" : [PushListItem class]};
}


@end
@implementation PushListItem
@end
@implementation RecommendInfoItem
@end
@implementation CreditCardsList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"credit_list" : [QuickPayInfoItem class]};
}
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

@implementation BankItem

@end









