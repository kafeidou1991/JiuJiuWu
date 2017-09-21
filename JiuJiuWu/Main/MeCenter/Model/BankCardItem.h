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
@property (nonatomic, copy) NSString * banck_code;//银行卡号
@property (nonatomic, copy) NSString * bank_name;//银行名称
@property (nonatomic, copy) NSString * account;//户主
@property (nonatomic, strong) UIImage * idcard_img_one;//身份证照片正面
@property (nonatomic, strong) UIImage * idcard_img_two;//身份证照片反面
@property (nonatomic, strong) UIImage * idcard_img_three;//手持身份证
@property (nonatomic, copy) NSString * province;//省
@property (nonatomic, copy) NSString * city;//市
@property (nonatomic, copy) NSString * district;//县
@property (nonatomic, copy) NSString * cell_phone;//预留手机号
@property (nonatomic, copy) NSString * bank_number;//银行code
@property (nonatomic, copy) NSString * detailAddress;//详细地址

//商户信息用
@property (nonatomic, copy) NSString * merchant_name; //商户名称
@property (nonatomic, copy) NSString * gszc_name;//工商注册名称
@property (nonatomic, copy) NSString * biz_license;//营业执照
@property (nonatomic, copy) NSString * biz_org;//组织机构代码
@property (nonatomic, copy) NSString * biz_tax;//纳税人识别号
@property (nonatomic, strong) UIImage * license_img;//营业执照照片
@property (nonatomic, strong) UIImage * shop_head_img;//店铺门面照片

- (void)setEmptyItem;


@end

