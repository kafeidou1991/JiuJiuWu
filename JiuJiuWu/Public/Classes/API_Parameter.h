//
//  API_Parameter.h
//  YZF
//
//  Created by 张竟巍 on 2017/5/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#ifndef API_Parameter_h
#define API_Parameter_h

#pragma mark ---------------------- 域名 ---------------------------
#ifdef DEBUG //开发环境
//0 测试环境  1 正式环境
#define environment 1

#if environment
static NSString * const baseUrl = @"https://api.yongqingjt.com/yinzhifuapi/";
#else
static NSString * const baseUrl = @"http://test.yongqingjt.com:8080/yinzhifuapi/"; //101.201.117.15:8080
#endif

#else //发布环境
static NSString * const baseUrl = @"https://api.yongqingjt.com/yinzhifuapi/";
#endif

#pragma mark ---------------------- 参数字段、功能 ----------------------------
//初始化接口信息
#define Initialzation [baseUrl appendBaseUrl:@"app/initialization"]
//获取资料状态  余额
#define UserStaus [baseUrl appendBaseUrl:@"user/getUserStatus"]
//获取轮播图
#define GetIdsList [baseUrl appendBaseUrl:@"app/getAdlist"]
//邀请码激活
#define InvitationCodea [baseUrl appendBaseUrl:@"merchant/invitationCodeaActivation"]
//修改手机号
#define ChangeMobile [baseUrl appendBaseUrl:@"user/changeMobile"]
//验证码
#define VerifyMobile [baseUrl appendBaseUrl:@"user/verifyMobile"]
//提交结算账户信息
#define UpdateBanckInfo [baseUrl appendBaseUrl:@"merchant/updateBanckInfo"]
//收款验证码
#define ScanPayQR [baseUrl appendBaseUrl:@"merchant/scanPayQrCode"]
//总代信息
#define GeneralagentInfo [baseUrl appendBaseUrl:@"generalagent/getGeneralagentInfo"]
//普通代理信息
#define AgentInfo_API [baseUrl appendBaseUrl:@"agent/getAgentInfo"]
//修改代理等级
#define UpdateLevelScale [baseUrl appendBaseUrl:@"user/updateLevelScale"]
//验证码
#define VeriftUser [baseUrl appendBaseUrl:@"user/verifyUser"]
//注册
#define RegisterAction [baseUrl appendBaseUrl:@"user/register"]
//找回密码
#define ResetPW [baseUrl appendBaseUrl:@"user/resetPassword"]
//重置密码
#define ChangePW [baseUrl appendBaseUrl:@"user/changePassword"]
//设置交易密码
#define ChangePayPW [baseUrl appendBaseUrl:@"user/changePayPassword"]
//设置个人信息资料
#define MemberIdCard [baseUrl appendBaseUrl:@"merchant/setMemberIdCard"]
//交易明细
#define IncomeDetail [baseUrl appendBaseUrl:@"merchant/getIncome"]
//收益记录
#define ProfitDetails [baseUrl appendBaseUrl:@"agent/profitDetails"]
//收益明细
#define Withdrawals [baseUrl appendBaseUrl:@"agent/getWithdrawals"]
//登录
#define LoginAction [baseUrl appendBaseUrl:@"user/login"]
//通知列表
#define NoticeList [baseUrl appendBaseUrl:@"app/getNoticeList"]
//消息列表
#define PushList_API [baseUrl appendBaseUrl:@"merchant/getPushList"]
//付款
#define UnScanCodePay [baseUrl appendBaseUrl:@"merchant/unScanCodePay"]
//设置费率
#define UpdateScale [baseUrl appendBaseUrl:@"generalagent/updateScale"]
//商户信息
#define UpdateMerchat [baseUrl appendBaseUrl:@"merchant/updateMerchant"]
//获取商户资质
#define MerchatQualification [baseUrl appendBaseUrl:@"merchant/getMerchantQualification"]
//上传资质
#define MerchatQualificationImg [baseUrl appendBaseUrl:@"merchant/setMerchantQualificationImg"]
//提现银行卡
#define Withdrawals_API [baseUrl appendBaseUrl:@"agent/Withdrawals"]
//获取推荐商户统计信息
#define RecommendMerchatInfo [baseUrl appendBaseUrl:@"agent/getRecommendMerchantInfo"]
//获取推荐商户列表
#define RecommendMerchatList [baseUrl appendBaseUrl:@"agent/getRecommendMerchantList"]
//获取上福快捷支付短信验证码
#define GetShangFuFastPayCode [baseUrl appendBaseUrl:@"merchant/getShangFuFastPayCode"]
//请求支付接口
#define ShangFuFastPay [baseUrl appendBaseUrl:@"merchant/shangFuFastPay"]
//获取信用卡列表
#define CreditCardList [baseUrl appendBaseUrl:@"merchant/creditList"]





#endif /* API_Parameter_h */
