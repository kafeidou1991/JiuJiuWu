//
//  BankCardItem.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/19.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "BankCardItem.h"

@implementation BankCardItem
-(void)setEmptyItem {
    _idcard_number = @"";
    _account = @"";
    _bank_name = @"";
    _account_name = @"";
    _idcard_img_one = [UIImage new];
    _idcard_img_two = [UIImage new];
    _idcard_img_three = [UIImage new];
    _province = @"";
    _city = @"";
    _district = @"";
    _account_mobile = @"";
    _bank_code = @"";
    _account_type = @"1";
    _open_branch = @"";
    _address_detail =@"";
    
    _merchant_name = @"";
    _gszc_name = @"";
    _biz_org = @"";
    _biz_tax =@"";
    _biz_license = @"";
    _license_img = [UIImage new];
    _shop_head_img = [UIImage new];
}


@end
