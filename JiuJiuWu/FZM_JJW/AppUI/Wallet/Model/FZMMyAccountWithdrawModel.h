//
//  FZMMyAccountWithdrawModel.h
//  JiuJiuWu
//
//  Created by 付志敏 on 2018/1/17.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZMMyAccountWithdrawModel : NSObject

//"id": 2,
//"user_id": 13,
//"order_no": "20171026174151959465",
//"amount": "2.00",
//"account": "6228480018812164871",
//"account_name": "青国平",
//"account_type": "1",
//"state": 1,
//"return_desc": "支付请求已受理，请等待交易结果异步通知",
//"trans_id": "2017102605232152012",
//"trans_status_desc": "成功-00",
//"update_time": 1509010914,
//"add_time": 1509010913

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *user_id;
@property (copy, nonatomic) NSString *order_no;
@property (assign, nonatomic) double amount;
@property (copy, nonatomic) NSString *account_name;
@property (assign, nonatomic) NSInteger account_type;
@property (assign, nonatomic) NSInteger state;
@property (copy, nonatomic) NSString *return_desc;
@property (copy, nonatomic) NSString *trans_id;
@property (copy, nonatomic) NSString *trans_status_desc;
@property (copy, nonatomic) NSString *update_time;
@property (copy, nonatomic) NSString *add_time;
@property (copy, nonatomic) NSString *account;

@end
