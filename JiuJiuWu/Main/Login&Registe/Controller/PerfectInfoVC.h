//
//  ActiveCodeViewController.h
//  YZF
//
//  Created by 张竟巍 on 2017/3/28.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "JJWBaseVC.h"

typedef NS_ENUM(NSInteger, PerfectInfoType) {
    PerfectNoCheckInfoType = 0, //待审核需要完善信息
    PerfectCheckingInfoType = 1, //正在审核中
    PerfectCheckSuccessInfoType = 2,//审核成功
    PerfectCheckFailedInfoType = 3,//审核失败
};

//补充信息
@interface PerfectInfoVC : JJWBaseVC

@property (nonatomic, copy) dispatch_block_t cancelBlock;

@property (nonatomic, copy) dispatch_block_t activeVlock;

@property (nonatomic, assign) PerfectInfoType type;


@end
