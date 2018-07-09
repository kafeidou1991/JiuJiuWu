//
//  MyLucyListCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/29.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLucyListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;


- (void) updateCell:(MyLuckyDrawItem *)item;

@end
