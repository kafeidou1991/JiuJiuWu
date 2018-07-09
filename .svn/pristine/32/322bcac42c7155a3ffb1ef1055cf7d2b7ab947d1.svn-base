//
//  SUAlarmMessage.h
//  wyzc
//
//  Created by sunjun on 14-8-20.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYAlertView.h"

typedef XYAlertViewBlock DidCallBack;

@interface SUAlarmMessage : NSObject;

@property(nonatomic,copy) DidCallBack  didCallBack;
- (void)showAlarm:(NSString *)title msg:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle callBack:(DidCallBack)callback;
@end
