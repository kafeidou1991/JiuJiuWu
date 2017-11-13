//
//  OpationButton.m
//  wyzc
//
//  Created by WYZC on 16/4/14.
//  Copyright © 2016年 北京我赢科技有限公司. All rights reserved.
//  左图片 右文字的按钮

#import "OpationButton.h"

@implementation OpationButton

- (void)createButtonCenterImage:(NSString *)centerImage RightTitle:(NSString *)title{
    if (self.space == 0) {
        self.space = 15;
    }
    CGSize size = IMAGE_SIZE(centerImage);
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - size.width)/2, self.height/2 - size.width, size.width,size.height)];
        [self addSubview:_centerImageView];
    }
    _centerImageView.image = [UIImage imageNamed:centerImage];
    
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.frame = CGRectMake(0,  _centerImageView.bottom +  self.space, self.width, 20);
        [self addSubview:_contentLabel];
    }
    _contentLabel.text = title;
    self.clipsToBounds = YES;
}

@end
