//
//  DateCenter.h
//  YZF
//
//  Created by 张竟巍 on 2017/3/27.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import <YYCache/YYCache.h>
@class PageItem;
@interface DateCenter : NSObject
@property (nonatomic, strong) PageItem * page;//分页使用
@end

@interface PageItem : NSObject
@property (nonatomic, copy) NSString * pageSize;
@property (nonatomic, copy) NSString * pageNo;//页数
@property (nonatomic, copy) NSString * lastIndex;
@property (nonatomic, copy) NSString * firstIndex;
@property (nonatomic, copy) NSString * pageCount;
@property (nonatomic, copy) NSString * lastPage;//是否是最后一页
@property (nonatomic, copy) NSString * firstPage;
@property (nonatomic, copy) NSString * resultCount;
@end

@interface DloginData : DateCenter
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * user_id;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * level;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * paypwd;
@property (nonatomic, copy) NSString * sex;
@property (nonatomic, copy) NSString * birthday;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * mobile_validated;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * district;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * email_validated;
@property (nonatomic, copy) NSString * is_distribut;
@property (nonatomic, copy) NSString * first_leader;
@property (nonatomic, copy) NSString * second_leader;
@property (nonatomic, copy) NSString * third_leader;
@property (nonatomic, copy) NSString * total_amount;
@property (nonatomic, copy) NSString * idcard_number;
@property (nonatomic, copy) NSString * idcard_address;
@property (nonatomic, copy) NSString * idcard_expired_time;
@property (nonatomic, copy) NSString * merchant_name;
@property (nonatomic, copy) NSString * merchant_short_name;
@property (nonatomic, copy) NSString * bank_name;
@property (nonatomic, copy) NSString * banck_code;
@property (nonatomic, copy) NSString * customer_id;
@property (nonatomic, copy) NSString * open_branch;
@property (nonatomic, copy) NSString * biz_org;

@property (nonatomic, copy) NSString * realname_checked; //审核状态 个人商户  0待审核 1审核中 2审核通过 3审核未通过
@property (nonatomic, copy) NSString * merchant_checked; //企业用户   0待审核 1审核中 2审核通过 3审核未通过

@end

@class AppVersion;
@interface Version_App : DateCenter
@property (nonatomic, strong)AppVersion * appVersion;
@property (nonatomic, copy) NSString * notice; //公告
@property (nonatomic, copy) NSString * apipath; //请求的地址
@end

@interface AppVersion : DateCenter
@property (nonatomic, copy) NSString * version_code;
@property (nonatomic, copy) NSString * is_force;
@property (nonatomic, copy) NSString * content;
@end

@interface PersionModel : DateCenter
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * cardNumber;
@property (nonatomic, copy)NSString * address;
@property (nonatomic, copy)NSString * organ;
@property (nonatomic, copy)NSString * dateTo;
@end

@interface BandCardInfo : DateCenter
@property (nonatomic, copy)NSString * account;//卡号
@property (nonatomic, copy)NSString * accountName;//账户名
@property (nonatomic, copy)NSString * openBranch;//对公的时候开户网点
@property (nonatomic, copy)NSString * accountMobile;//银行预留的银行卡号
@property (nonatomic, copy)NSString * bandName;//银行名称
@property (nonatomic, copy)NSString * accountType;//对私"3" 对公 @"2",
@end

@interface BankItem : DateCenter

@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * name;

@end













