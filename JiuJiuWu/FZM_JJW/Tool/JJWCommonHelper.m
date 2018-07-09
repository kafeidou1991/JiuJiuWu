//
//  JJWCommonHelper.m
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/3.
//  Copyright © 2018年 张竟巍. All rights reserved.
//

#import "JJWCommonHelper.h"

@implementation JJWCommonHelper

#pragma mark 抖动
+ (void)fzm_shakeView:(UIView *)viewToShake
{
    CGFloat t =4.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

+ (CGFloat)fzm_tableViewHeight:(UITableView *)tableView{
    tableView.rowHeight = UITableViewAutomaticDimension;
    if (IS_IOS_11) {
        tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    } else {
        tableView.estimatedRowHeight = 1000;
    }
    
    return tableView.rowHeight;
}

+ (UIFont *)pingFang_SC_RegularSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    
}

+ (UIFont *)pingFang_SC_BoldSize:(CGFloat)size{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

@end
