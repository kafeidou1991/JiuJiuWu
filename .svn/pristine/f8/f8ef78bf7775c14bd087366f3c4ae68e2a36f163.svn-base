//
//  MeCenterHeadView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/17.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "MeCenterHeadView.h"

@interface MeCenterHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *roleImageV;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mobileTop;
- (IBAction)userInfoAction:(UIButton *)sender;
- (IBAction)headIconAction:(id)sender;
@end


@implementation MeCenterHeadView
- (void)updateHeadInfo {
    DloginData * loginData = [JJWLogin sharedMethod].loginData;
    BOOL isLogin = [JJWLogin sharedMethod].isLogin;
    if (isLogin) {
        self.mobileTop.constant = 0;
        self.mobileLabel.text = loginData.mobile;
        self.nameLabel.text = loginData.nickname;
        self.roleImageV.hidden = NO;
    }else {
        self.mobileTop.constant = 15.f;
        self.mobileLabel.text = @"未登录";
        self.nameLabel.text = @"";
        self.roleImageV.hidden = YES;
    }
    
}











- (IBAction)userInfoAction:(UIButton *)sender {
    
    
}

- (IBAction)headIconAction:(id)sender {
    if (_clickHeadIconBlock) {
        _clickHeadIconBlock();
    }
}



@end
