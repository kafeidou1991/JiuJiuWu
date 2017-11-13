//
//  HomeHeaderView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/15.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()

- (IBAction)clickAction:(UIButton *)sender;

@end

@implementation HomeHeaderView

-(void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)clickAction:(UIButton *)sender {
    if (_block) {
        _block(sender.tag);
    }
}
@end
