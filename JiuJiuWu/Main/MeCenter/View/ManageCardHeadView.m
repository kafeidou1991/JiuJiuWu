//
//  ManageCardHeadView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/13.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "ManageCardHeadView.h"

@implementation ManageCardHeadView

- (IBAction)clickBankAction:(UITapGestureRecognizer *)sender {
    if (_clickBlock) {
        _clickBlock();
    }
}
@end
