//
//  AdditionFootView.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/13.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdditionFootView : UICollectionReusableView
- (IBAction)click:(UIButton *)sender;

@property (nonatomic, copy) dispatch_block_t block;

@end
