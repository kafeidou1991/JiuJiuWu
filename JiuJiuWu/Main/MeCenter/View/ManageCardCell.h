//
//  ManageCardCell.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardItem;
typedef void(^CameraActionBlock)(UIButton * sender);

@interface ManageCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIButton *sevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *eightBtn;

@property (nonatomic, copy) CameraActionBlock block;
- (IBAction)cameraAction:(UIButton *)sender;

- (void)updateCell:(DloginData *)item ImageBlock:(void (^)(UIButton *,UIImage *))block;

@end
