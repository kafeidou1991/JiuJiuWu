//
//  ActiveCodeViewController.h
//  YZF
//
//  Created by 张竟巍 on 2017/3/28.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "JJWBaseVC.h"

typedef void(^ScanGunPayResultBlock)(NSString * content);

//激活码
@interface PerfectInfoVC : JJWBaseVC

@property (nonatomic, copy) dispatch_block_t cancelBlock;

@property (nonatomic, copy) dispatch_block_t activeVlock;


@end
