//
//  ScrollLabelHelp.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/14.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "ScrollLabelHelp.h"
#import "TXScrollLabelView.h"

@interface ScrollLabelHelp ()
@property (nonatomic, strong) NSMutableArray <NSString *> * dataSources; //弹幕数组
@property (nonatomic, strong) TXScrollLabelView *scrollLabelView;
@end

static ScrollLabelHelp * instance = nil;
@implementation ScrollLabelHelp

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [ScrollLabelHelp new];
            instance.dataSources = @[].mutableCopy;
        }
    });
    return instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

-(void)showScrolle {
    [[JJWInitApp sharedMethod]initApp:^(Version_App * app) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (app.is_open.integerValue == 1) {
                //弹幕分润
                if (![JJWLogin sharedMethod].isLogin) {
                    return;
                }
                if (_dataSources.count > 0) {
                    self.scrollLabelView.hidden = NO;
                    [self.scrollLabelView beginScrolling];
                    return;
                }
                WeakSelf
                [JJWNetworkingTool PostWithUrl:AllCashDistribute params:@{@"token":[JJWLogin sharedMethod].loginData.token} isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSArray * listArray = [NSArray yy_modelArrayWithClass:[MyShareBenefitItem class] json:responseObject];
                    for (MyShareBenefitItem * item in listArray) {
                        [_dataSources addObject:[NSString stringWithFormat:@"%@获得分润%@元",item.member_name,[NSString stringWithFormat:@"%.2f",item.amount.floatValue]]];
                    }
                    if (_dataSources.count > 0) {
                        [weakSelf.scrollLabelView beginScrolling];
                    }
                } failed:^(NSError *error, id chaceResponseObject) {
                    [JJWBase alertMessage:error.domain cb:nil];
                }];
            }
        });
    }];
}
-(void)hiddenScrolle {
    if (self.dataSources.count <= 0) {
        return;
    }
    self.scrollLabelView.hidden = YES;
    [_scrollLabelView endScrolling];
    
}

-(TXScrollLabelView *)scrollLabelView {
    if (!_scrollLabelView) {
        /** Step2: 创建 ScrollLabelView */
        _scrollLabelView = [TXScrollLabelView scrollWithTextArray:_dataSources type:TXScrollLabelViewTypeLeftRight velocity:0.8 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        
        /** Step4: 布局(Required) */
        _scrollLabelView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCreenWidth, 30);
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:_scrollLabelView];
        //偏好(Optional), Preference,if you want.
        _scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
        _scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        _scrollLabelView.scrollSpace = 40;
        _scrollLabelView.font = [UIFont systemFontOfSize:15];
        _scrollLabelView.textAlignment = NSTextAlignmentCenter;
        _scrollLabelView.backgroundColor = [UIColor clearColor];
        //禁掉交互，防止阻挡时间触发
        _scrollLabelView.userInteractionEnabled = NO;
    }
    return _scrollLabelView;
}





@end
