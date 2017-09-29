//
//  BankCardItem.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/19.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "DateCenter.h"

@interface BankCardItem : DateCenter
//绑定银行卡是用
@property (nonatomic, copy) NSString * idcard_number;//身份证号
@property (nonatomic, copy) NSString * account;//银行卡号
@property (nonatomic, copy) NSString * bank_name;//银行名称
@property (nonatomic, copy) NSString * account_name;//户主
@property (nonatomic, strong) UIImage * idcard_img_one;//身份证照片正面
@property (nonatomic, strong) UIImage * idcard_img_two;//身份证照片反面
@property (nonatomic, strong) UIImage * idcard_img_three;//手持身份证
@property (nonatomic, strong) UIImage * shop_head_img;//店铺门面照片
@property (nonatomic, copy) NSString * province;//省编号
@property (nonatomic, copy) NSString * provinceName;//省
@property (nonatomic, copy) NSString * city;//市编号
@property (nonatomic, copy) NSString * cityName;//市
@property (nonatomic, copy) NSString * district;//县编号
@property (nonatomic, copy) NSString * districtName;//县
@property (nonatomic, copy) NSString * account_mobile;//预留手机号
@property (nonatomic, copy) NSString * bank_code;//银行code
@property (nonatomic, copy) NSString * account_type; //是否对公账号 //1.对私 2.对公
@property (nonatomic, copy) NSString * open_branch;//对公银行行号
@property (nonatomic, copy) NSString * address_detail;//详细地址

//商户信息用
@property (nonatomic, copy) NSString * merchant_name; //商户名称
@property (nonatomic, copy) NSString * gszc_name;//工商注册名称
@property (nonatomic, copy) NSString * legal_person;//法人姓名
@property (nonatomic, copy) NSString * biz_license;//营业执照
@property (nonatomic, copy) NSString * biz_org;//组织机构代码
@property (nonatomic, copy) NSString * biz_tax;//纳税人识别号
@property (nonatomic, strong) UIImage * license_img;//营业执照照片

- (void)setEmptyItem;


@end

