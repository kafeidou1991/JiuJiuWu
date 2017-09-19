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
@property (nonatomic, copy) NSString * idcard_number;
@property (nonatomic, copy) NSString * banck_code;
@property (nonatomic, copy) NSString * bank_name;
@property (nonatomic, copy) NSString * account;
@property (nonatomic, strong) UIImage * idcard_img_one;
@property (nonatomic, strong) UIImage * idcard_img_two;
@property (nonatomic, strong) UIImage * idcard_img_three;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * district;
@property (nonatomic, copy) NSString * cell_phone;
@property (nonatomic, copy) NSString * bank_number;

- (void)setEmptyItem;

@end


//user_id	string	是	用户ID
//idcard_number	string	是	身份证号
//banck_code	string	是	银行卡号
//bank_name	string	是	银行名称
//account	string	是	户主
//idcard_img_one	string	是	身份证照片正面
//idcard_img_two	string	是	身份证照片反面
//idcard_img_three	string	是	手持身份证
//province	int	是	省
//city	int	是	市
//district	int	是	县
//token	string	是
//cell_phone	int	是	预留手机号
//bank_number	string	是	银行编号
