//
//  FZMBindCreditCardController.h
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/11.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

typedef void (^refeshCreditCardListBlok)();
@interface FZMBindCreditCardController : JJWBaseVC

@property (copy, nonatomic) refeshCreditCardListBlok refeshCreditCardListBlok;

@end
