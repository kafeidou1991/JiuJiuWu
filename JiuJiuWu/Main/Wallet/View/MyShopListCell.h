//
//  MyShopListCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/26.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShopListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

- (void)updateCell:(MyShopItem *)item;

@end
