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
    _banck_code = @"";
    _bank_name = @"";
    _account = @"";
    _idcard_img_one = [UIImage new];
    _idcard_img_two = [UIImage new];
    _idcard_img_three = [UIImage new];
    _province = @"";
    _city = @"";
    _district = @"";
    _cell_phone = @"";
    _bank_number = @"";
    _detailAddress =@"";
    
    _merchant_name = @"";
    _gszc_name = @"";
    _biz_org = @"";
    _biz_tax =@"";
    _biz_license = @"";
    _license_img = [UIImage new];
    _shop_head_img = [UIImage new];
}


@end
