//
//  IncomeTableViewCell.h
//  YZF
//
//  Created by 张竟巍 on 2017/3/26.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeTableViewCell : UITableViewCell

- (void)updateCell:(PaySuccessItem *)item;

- (void)updateBorrowCell:(PaySuccessItem *)item;

- (void)updateWithdrawListCell:(PaySuccessItem *)item;

@end
