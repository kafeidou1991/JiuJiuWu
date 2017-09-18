//
//  MeCenterHeadView.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/17.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCenterHeadView : UIView

- (void)updateHeadInfo;

@property (nonatomic, copy) dispatch_block_t clickHeadIconBlock;

@end
