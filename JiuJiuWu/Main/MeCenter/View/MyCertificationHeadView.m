//
//  MyCertificationHeadView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/7.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "MyCertificationHeadView.h"

@implementation MyCertificationHeadView



- (IBAction)clickIdCardAction:(UITapGestureRecognizer *)sender {
    if (_clickBlock) {
        _clickBlock(0);
    }
}

- (IBAction)clickIdCardBackAction:(UITapGestureRecognizer *)sender {
    if (_clickBlock) {
        _clickBlock(1);
    }
}
@end
