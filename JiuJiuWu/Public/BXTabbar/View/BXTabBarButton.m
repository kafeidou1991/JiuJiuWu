//
//  BXTabBarButton.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "BXTabBarButton.h"
#import "BXBadgeView.h"
#import "UIView+Extension.h"

@interface BXTabBarButton ()
/**
 *  提醒数字
 */
@property (strong, nonatomic) BXBadgeView *badgeView;
@end

@implementation BXTabBarButton
/**
 *  小红点
 */
- (BXBadgeView *)badgeView {
    if (!_badgeView) {
        BXBadgeView *badgeView = [[BXBadgeView alloc] init];
        [self addSubview:badgeView];
        self.badgeView = badgeView;
    }
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    self.badgeView.badgeValue = item.badgeValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 文字位置
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 20;
    //适配iPhone X
    self.titleLabel.y = self.height - self.titleLabel.height - HOME_INDICATOR_HEIGHT;
    // 图片位置
//    self.imageView.width = 35;
//    self.imageView.height = 35;
//    self.imageView.x = (self.width - self.imageView.width) / 2;
//    self.imageView.y = 0;
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = self.titleLabel.y - self.imageView.height - 2;
    
    
    // 小红点位置
    self.badgeView.x = CGRectGetMaxX(self.imageView.frame) - 5;
    self.badgeView.y = 2;
//    self.badgeView.width = ;
//    self.badgeView.height = ;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
