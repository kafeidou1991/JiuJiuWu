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
@property (nonatomic, copy) NSString * gesturePassword; //手势密码
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

@interface CheckItem : DateCenter
@property (nonatomic, copy)NSString * status;//城市
@property (nonatomic, copy)NSString * money;//城市
@end

@interface IdsList : DateCenter
@property (nonatomic, strong) NSArray * adlist;
@end
@interface IdsItem : DateCenter
@property (nonatomic, copy)NSString * title;
@property (nonatomic, copy)NSString * link_url;//跳转链接
@property (nonatomic, copy)NSString * images;//图片地址
@end


@interface AppVersion : DateCenter
@property (nonatomic, copy) NSString * version_code;
@property (nonatomic, copy) NSString * is_force;
@property (nonatomic, copy) NSString * content;
@end

@interface Version_App : DateCenter
@property (nonatomic, strong)AppVersion * appVersion;
@property (nonatomic, copy) NSString * notice; //公告
@property (nonatomic, copy) NSString * apipath; //请求的地址
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

@interface ShopModel : DateCenter
@property (nonatomic, copy)NSString * idcardName;//商户姓名
@property (nonatomic, copy)NSString * merchantName;//商户名称
@property (nonatomic, copy)NSString * province;
@property (nonatomic, copy)NSString * merchantAddr;//商户地址
@property (nonatomic, copy)NSString * city;
@property (nonatomic, copy)NSString * tel;
@property (nonatomic, copy)NSString * legalPperson;//法人
@property (nonatomic, copy)NSString * companyName;//名称
@property (nonatomic, copy)NSString * bizLicense;//执照
@property (nonatomic, copy)NSString * bizOrg;//组织代码
@property (nonatomic, copy)NSString * bizTax;//税务登记
@end

/**
 *  通知信息
 */
@interface NoticeAps : NSObject

@property (nonatomic, strong) NSString *alert;
@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) NSString *sound;

@end


@class CollectionItem;  //收款记录
@interface CollectionRecrod : DateCenter
@property (nonatomic, copy) NSString * count;
@property (nonatomic, copy) NSString * sumamount;
@property (nonatomic, copy) NSArray * orderlist;
@end

@interface CollectionItem : DateCenter
@property (nonatomic, copy) NSString * cmid;//id
@property (nonatomic, copy) NSString * add_time;//添加时间
@property (nonatomic, copy) NSString * order_no;//订单编号
@property (nonatomic, copy) NSString * amount;//金额
@property (nonatomic, copy) NSString * money;//收款金额
@property (nonatomic, copy) NSString * member_name;//商户名称
@property (nonatomic, copy) NSString * cash_order_id;//订单id
@property (nonatomic, copy) NSString * channel_flag; //支付渠道00：微信，01：支付宝，02：百付宝，03翼支付，04：qq钱包
@property (nonatomic, copy) NSString * state; //   0转账中 1转账成功 2转账失败
@end

@interface PaySuccessItem : DateCenter
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * orderNo;
@property (nonatomic, copy) NSString * reqTime;
@property (nonatomic, copy) NSString * channel_flag; //支付渠道00：微信，01：支付宝，02：百付宝，03翼支付，04：qq钱包 05 快捷支付
@end

@interface DelegateList : DateCenter
@property (nonatomic, strong) NSArray * agents;//代理列表
@property (nonatomic, strong) NSArray * merchants;//商户列表

@end

@interface DelegateItem : DateCenter
//我的代理相关member_id
@property (nonatomic, copy) NSString * member_id; //代理商//商户 id
@property (nonatomic, copy) NSString * member_name; //代理商姓名
@property (nonatomic, copy) NSString * merchant_name; //商户名称
@property (nonatomic, copy) NSString * mobile; // 手机号
@property (nonatomic, copy) NSString * account; // 银行账号
@property (nonatomic, copy) NSString * create_time; // 注册时间
@property (nonatomic, copy) NSString * sub_agent; // 下级代理
@property (nonatomic, copy) NSString * agent_level; //代理商等级  1:高级合伙人2：初级合伙人3:金牌会员4:普通会员
@property (nonatomic, copy) NSString * sub_mer_count; //商户数量
@property (nonatomic, copy) NSString * dist_amount; //分润金额
@property (nonatomic, copy) NSString * dist_count; //分润记录
//我的商户相关
@property (nonatomic, copy) NSString * status; //状态是否开启
@property (nonatomic, copy) NSString * income_amount; //收款金额
@property (nonatomic, copy) NSString * income_count; //收款笔数


@property (nonatomic, copy) NSString * weixin_scale; //微信费率
@property (nonatomic, copy) NSString * zfb_scale; //支付宝费率
@property (nonatomic, copy) NSString * pos_scale; //刷卡费率
@property (nonatomic, copy) NSString * fast_scale; //快捷费率
@property (nonatomic, copy) NSString * qq_scale; //QQ费率
@end

@interface AgentInfo : DateCenter
@property (nonatomic, copy) NSString * totalProfit; //总收益
@property (nonatomic, copy) NSString * todayProfit; //今日收益
@property (nonatomic, copy) NSString * notExtractProfit; //未提取收益
@property (nonatomic, copy) NSString * merchantnum; //商户数量
@property (nonatomic, copy) NSString * agentnum; //代理商数量

@end

@interface UploadList : DateCenter
@property (nonatomic, strong) NSArray * qualification;
@property (nonatomic, copy) NSString * memberStatus;
@end
@interface UploadModel : DateCenter

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, copy) NSString * filepath;//地址
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * checked;//审核是否通过
@property (nonatomic, copy) NSString * legalidType;//1身份证正面照",11身份证背面照",21本人手持身份证合照",31银行卡正面照",41企业营业执照"

@end
//提现记录  收益明细
@interface ProfitDetailsList : DateCenter
@property (nonatomic, copy) NSString * total;
@property (nonatomic, copy) NSString * amount;
@property (nonatomic, strong) NSArray * income;
@property (nonatomic, strong) NSArray * withdrawalsList;
@end

//推送列表
@interface PushList : DateCenter
@property (nonatomic, strong) NSArray * push_list;
@property (nonatomic, strong) NSArray * noticelist;
@end

@interface PushListItem : DateCenter
@property (nonatomic, copy) NSString * content; //内容
@property (nonatomic, copy) NSString * add_time; //时间
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title; //标题
@property (nonatomic, copy) NSString * template_id;
@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * is_read;//是否已读
@end

//推荐商户信息
@interface RecommendInfoItem : DateCenter
@property (nonatomic, copy) NSString * amount;//总金额
@property (nonatomic, copy) NSString * total;//总人数
@property (nonatomic, copy) NSString * one_level1;// 直接推荐
@property (nonatomic, copy) NSString * one_level2;//
@property (nonatomic, copy) NSString * one_level3;//
@property (nonatomic, copy) NSString * one_level4;//

@property (nonatomic, copy) NSString * two_level1;// 二代
@property (nonatomic, copy) NSString * two_level2;//
@property (nonatomic, copy) NSString * two_level3;//
@property (nonatomic, copy) NSString * two_level4;//

@property (nonatomic, copy) NSString * three_level1;//三代
@property (nonatomic, copy) NSString * three_level2;//
@property (nonatomic, copy) NSString * three_level3;//
@property (nonatomic, copy) NSString * three_level4;//
@end

@interface CreditCardsList : DateCenter
@property (nonatomic, strong) NSArray * credit_list;
@end
/**
 快捷支付 所需充填信息
 */
@interface QuickPayInfoItem : DateCenter<NSCoding>

@property (nonatomic, copy) NSString * acct_type;   // DEBIT-储蓄卡  CREDIT-信用卡
@property (nonatomic, copy) NSString * account;      // 卡号
@property (nonatomic, copy) NSString * account_name;   //持卡人姓名
@property (nonatomic, copy) NSString * account_expire_date;//当卡类型为：CREDIT 必填 有限期
@property (nonatomic, copy) NSString * account_cvv;        //当卡类型为：CREDIT 必填 安全吗
@property (nonatomic, copy) NSString * idcard_number;      //证件号码
@property (nonatomic, copy) NSString * account_mobile;     //银行预留手机号
@property (nonatomic, copy) NSString * bank_code;//信用卡所属银行代码
@property (nonatomic, copy) NSString * bank_name;//信用卡开户行完整名称 具体到支行bank_type

@property (nonatomic, copy) NSString * bank_type;//信用卡开户行名称 不具体到支行
@property (nonatomic, copy) NSString * bankShowName; //用于展示  例如：招商银行（6545）

- (void)saveProdfile;

@end

@interface BankItem : DateCenter

@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * name;

@end














