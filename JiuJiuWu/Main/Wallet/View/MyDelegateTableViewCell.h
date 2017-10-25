//
//  MyDelegateTableViewCell.h
//  YZF
//
//  Created by 张竟巍 on 2017/4/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDelegateTableViewCell : UITableViewCell
- (IBAction)editDelegateAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, copy) dispatch_block_t editBlock;

//- (void)updateCell:(DelegateItem * )item :(BOOL)isShop;

@end
