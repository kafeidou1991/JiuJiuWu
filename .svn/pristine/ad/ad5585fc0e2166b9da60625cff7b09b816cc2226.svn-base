//
//  UIView+DashesLion.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/29.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "UIView+DashesLion.h"

@implementation UIView (DashesLion)

- (void)addDashesLion:(CGFloat)cornerRadius{
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    
    borderLayer.frame = CGRectMake(0,0, self.width - 1, self.height - 1);
//    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.frame cornerRadius:cornerRadius].CGPath;
    borderLayer.lineWidth = 1;
    //虚线边框
    borderLayer.lineDashPattern = @[@4, @4];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:borderLayer];
    
//    CAShapeLayer *border = [CAShapeLayer layer];
//    
//    border.strokeColor = [UIColor grayColor].CGColor;
//    
//    border.fillColor = nil;
//    
//    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//    
//    border.frame = CGRectMake(0, 0, SCreenWidth - 16, 150);//self.bounds;
//    
//    border.lineWidth = 1.f;
//    
//    border.lineCap = @"square";
//    
//    border.lineDashPattern = @[@4, @4];
//    
//    [self.layer addSublayer:border];
    

}

@end
