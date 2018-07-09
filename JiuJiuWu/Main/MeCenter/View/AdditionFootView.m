//
//  AdditionFootView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/13.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "AdditionFootView.h"

@implementation AdditionFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)click:(UIButton *)sender {
    if (_block) {
        _block();
    }
    
    
}
@end
