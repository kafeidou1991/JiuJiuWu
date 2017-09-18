//
//  MeCenterHeadView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/17.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "MeCenterHeadView.h"
#import "LoginVC.h"

@interface MeCenterHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *roleImageV;

- (IBAction)userInfoAction:(UIButton *)sender;
- (IBAction)headIconAction:(id)sender;
@end


@implementation MeCenterHeadView
- (void)updateHeadInfo {
    DloginData * loginData = [JJWLogin sharedMethod].loginData;
    BOOL isLogin = [JJWLogin sharedMethod].isLogin;
    if (isLogin) {
        self.mobileLabel.text = loginData.mobile;
        self.nameLabel.text = loginData.nickname;
//        self.roleLabel
    }else {
        self.mobileLabel.text = @"***********";
        self.nameLabel.text = @"未登录";
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
