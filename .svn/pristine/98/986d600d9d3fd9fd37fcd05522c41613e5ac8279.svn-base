//
//  PubilcBankCardCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/22.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectActionBlock)(UIButton * sender);

@interface PubilcBankCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) SelectActionBlock block;

- (void)updateBindCardCell:(NSDictionary *)dict textAlignment:(NSTextAlignment)align;
@end
