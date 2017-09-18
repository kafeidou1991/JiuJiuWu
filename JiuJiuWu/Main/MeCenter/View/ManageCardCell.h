//
//  ManageCardCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CameraActionBlock)(UIButton * sender);

@interface ManageCardCell : UITableViewCell

@property (nonatomic, copy) CameraActionBlock block;
- (IBAction)cameraAction:(UIButton *)sender;

@end
