//
//  SUAlarmMessage.m
//  wyzc
//
//  Created by sunjun on 14-8-20.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "SUAlarmMessage.h"


@interface SUAlarmMessage()
{
    id _alerView;
}
@end



@implementation SUAlarmMessage

-(void) showAlarm:(NSString *)title msg:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle otherButtonTitle:(NSString *)otherTitle callBack:(DidCallBack)callback
{
    if(!STRISEMPTY(message))
    {
        NSMutableArray *buttons = [[NSMutableArray alloc] init];
        if (!STRISEMPTY(cancelTitle)) {
            [buttons addObject:cancelTitle];
        }
        if (!STRISEMPTY(otherTitle)) {
            [buttons addObject:otherTitle];
        }
        if(!STRISEMPTY(title)){
            _alerView = [[XYAlertView alloc] initWithTitle:title message:message buttons:buttons  afterDismiss:callback];
        }else{
            _alerView = [[XYAlertView alloc] initWithTitle:@"提醒" message:message buttons:buttons  afterDismiss:callback];
        }
        [_alerView setButtonStyle:XYButtonStyleGreen atIndex:0];
        [_alerView setButtonStyle:XYButtonStyleGray atIndex:1];
        [(XYAlertView*)_alerView show];
        if (callback) {
            self.didCallBack = callback;
        }
    }
}

@end
