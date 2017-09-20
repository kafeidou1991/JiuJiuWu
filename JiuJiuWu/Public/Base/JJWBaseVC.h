//
//  JJWBaseVC.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUEmptyView.h"
#import "SUAlarmMessage.h"

@interface JJWBaseVC : UIViewController{
    SUAlarmMessage *_alarmMessage;
    SUEmptyView *  _emptyView;
}

@property(nonatomic,assign)  BOOL   isPush;  //是否push 进来的
@property (nonatomic ,strong) SUEmptyView *emptyView;
//可以在此处添加一进入界面的请求
- (void)afterProFun;
//检查版本更新
- (void)checkVersion:(BOOL)isShow;

- (void)backAction:(id)sender;
- (void)willBack;
- (void)hudShow:(UIView *)inView msg:(NSString *)msgText;
- (void)hudclose;


@end
