//
//  CompanyInfoCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/21.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CameraActionBlock)(UIButton * sender);
@class BankCardItem;
@interface CompanyInfoCell : UITableViewCell
@property (nonatomic, copy) CameraActionBlock block;

- (void)updateCell:(BankCardItem *)item;

@end
