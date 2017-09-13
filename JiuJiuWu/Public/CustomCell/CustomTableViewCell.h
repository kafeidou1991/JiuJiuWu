//
//  CustomTableViewCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/13.
//  Copyright © 2017年 张竟巍. All rights reserved.
//  //左文字 右边输入框样式

#import <UIKit/UIKit.h>
//左文字 右边输入框样式
@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

//注册第二步cell
- (void)updateRegistCell:(NSDictionary *)dict;

@end
