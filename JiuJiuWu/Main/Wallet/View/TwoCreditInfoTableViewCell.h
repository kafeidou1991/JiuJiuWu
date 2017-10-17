//
//  TwoCreditInfoTableViewCell.h
//  YZF
//
//  Created by 张竟巍 on 2017/6/30.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoCreditCardView.h"

@interface TwoCreditInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TwoCreditCardView *leftView;
@property (weak, nonatomic) IBOutlet TwoCreditCardView *rightView;

@end
