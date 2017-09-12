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


@class UserData,ShopData;
@interface DloginData : DateCenter
@property (nonatomic, copy) NSString * token;//登录令牌
@property (nonatomic, strong) UserData * member;
@property (nonatomic, strong) ShopData * merchant;
@end

@interface UserData : DateCenter
@property (nonatomic, copy) NSString * cmid; //用户id
@property (nonatomic, copy) NSString * mobile;
//    1正常 2待激活 3身份证信息 4待完善商户信息  5待完善结算账户 6 待上传资质
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * tel; //商户服务电话
@property (nonatomic, copy) NSString * agent_level; //是否是代理 1:高级合伙人2：初级合伙人3:金牌会员4:普通会员
@property (nonatomic, copy) NSString * is_generalagent; //是否是总代理invitation_codea
@property (nonatomic, copy) NSString * invitation_codea; //邀请码
@property (nonatomic, copy) NSString * weixin_scale; //费率
@property (nonatomic, copy) NSString * zfb_scale; //费率
@property (nonatomic, copy) NSString * pos_scale; //费率
@property (nonatomic, copy) NSString * fast_scale; //费率
@property (nonatomic, copy) NSString * qq_scale; //费率
@property (nonatomic, copy) NSString * money;//账户余额  (通过user/getUserStatus获取)
@end

@interface ShopData : DateCenter  
@property (nonatomic, copy) NSString * openType; //1 是个人 C是企业
@property (nonatomic, copy) NSString * idcardNumber; //身份证号
@property (nonatomic, copy) NSString * idcardName; //身姓名
@property (nonatomic, copy) NSString * idcardOrg;//发证机构
@property (nonatomic, copy) NSString * idcardAddress;//地址
@property (nonatomic, copy) NSString * idcardExpiredTime;//身份证过期时间
@property (nonatomic, copy) NSString * legalPerson;//法人姓名
@property (nonatomic, copy) NSString * companyName;//企业名称
@property (nonatomic, copy)NSString * bizLicense;//执照
@property (nonatomic, copy)NSString * merchantName;  //商户名称
@property (nonatomic, copy)NSString * bizOrg;//组织代码
@property (nonatomic, copy)NSString * bizTax;//税务登记
@property (nonatomic, copy)NSString * merchantAddr;  //详细地址

@property (nonatomic, copy)NSString * account;//卡号
@property (nonatomic, copy)NSString * accountName;//账户名
@property (nonatomic, copy)NSString * openBranch;//对公的时候开户网点
@property (nonatomic, copy)NSString * accountMobile;//银行预留的银行卡号
@property (nonatomic, copy)NSString * accountType;//对私"3" 对公 @"2",memberId
@property (nonatomic, copy)NSString * memberId;//会员id
@property (nonatomic, copy)NSString * province;//省
@property (nonatomic, copy)NSString * city;//城市
@property (nonatomic, copy)NSString * telephone;//服务telephone
@property (nonatomic, copy)NSString * customerId;//商户编号
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















