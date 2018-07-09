//
//  FZMWalletHeaderCell.h
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/9.
//  Copyright © 2018年 张竟巍. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

typedef void (^hederBlock)(NSInteger index);

@interface FZMWalletHeaderCell : QMUITableViewCell


@property (copy, nonatomic) hederBlock hederBlock;

@end
