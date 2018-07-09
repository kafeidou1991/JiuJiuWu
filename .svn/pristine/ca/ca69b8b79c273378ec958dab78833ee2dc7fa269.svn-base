//
//  MyCertificationHeadView.h
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/7.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickImageBlock)(int);

@interface MyCertificationHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *idCardFrontView;
@property (weak, nonatomic) IBOutlet UIImageView *idCardBackView;

@property (nonatomic, copy) ClickImageBlock clickBlock;
- (IBAction)clickIdCardAction:(UITapGestureRecognizer *)sender;
- (IBAction)clickIdCardBackAction:(UITapGestureRecognizer *)sender;



@end
