//
//  SelectBandViewController.h
//  YZF
//
//  Created by 张竟巍 on 2017/4/2.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "JJWBaseTableVC.h"

typedef void(^SelectRowBlock)(NSInteger);

@interface SelectBandVC : JJWBaseTableVC

@property (nonatomic, copy) dispatch_block_t block;

@property (nonatomic, copy)SelectRowBlock selectBlock;

@end
