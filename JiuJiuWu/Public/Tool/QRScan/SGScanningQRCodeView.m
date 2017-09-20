//
//  SGScanningQRCodeView.m
//  SGQRCodeExample
//
//  Created by Sorgle on 16/8/27.
//  Copyright © 2016年 Sorgle. All rights reserved.
//
//  - - - - - - - - - - - - - - 交流QQ：1357127436 - - - - - - - - - - - - - - - //
//
//  - - 如在使用中, 遇到什么问题或者有更好建议者, 请于 kingsic@126.com 邮箱联系 - - - - //
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//  - - GitHub下载地址 https://github.com/kingsic/SGQRCode.git - - - - - - - - - //
//
//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

#import "SGScanningQRCodeView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+RectCorner.h"
#import "UIImage+TintColor.h"
/** 扫描内容的Y值 */
#define scanContent_Y self.frame.size.height * 0.24
/** 扫描内容的Y值 */
#define scanContent_X self.frame.size.width * 0.15

@interface SGScanningQRCodeView ()
@property (nonatomic, strong) CALayer *basedLayer;
/** 扫描动画线(冲击波) */
@property (nonatomic, strong) UIImageView *animation_line;
@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SGScanningQRCodeView

/** 扫描动画线(冲击波) 的高度 */
static CGFloat const animation_line_H = 12;
/** 扫描内容外部View的alpha值 */
static CGFloat const scanBorderOutsideViewAlpha = 0.4;
/** 定时器和动画的时间 */
static CGFloat const timer_animation_Duration = 0.05;

- (instancetype)initWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer {
    if (self = [super initWithFrame:frame]) {
        _basedLayer = outsideViewLayer;
         // 创建扫描边框
         [self setupScanningQRCodeEdging];
    }
    return self;
}

+ (instancetype)scanningQRCodeViewWithFrame:(CGRect)frame outsideViewLayer:(CALayer *)outsideViewLayer {
    return [[self alloc] initWithFrame:frame outsideViewLayer:outsideViewLayer];
}


// 创建扫描边框
- (void)setupScanningQRCodeEdging {
    // 扫描内容的创建
    UIView *scanContentView = [[UIView alloc] init];
    CGFloat scanContentViewX = scanContent_X;
    CGFloat scanContentViewY = scanContent_Y;
    CGFloat scanContentViewW = self.frame.size.width - 2 * scanContent_X;
    CGFloat scanContentViewH = scanContentViewW;
    scanContentView.frame = CGRectMake(scanContentViewX, scanContentViewY, scanContentViewW, scanContentViewH);
    scanContentView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6].CGColor;
    scanContentView.layer.borderWidth = 0.7;
    scanContentView.backgroundColor = [UIColor clearColor];
    [self.basedLayer addSublayer:scanContentView.layer];
    
    // 扫描动画添加
    self.animation_line = [[UIImageView alloc] init];
    _animation_line.image = [[UIImage imageNamed:@"scanCodeLine"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];//QRCodeLine
    _animation_line.tintColor = themeColor;
    [_animation_line.image imageWithTintColor:UIColorFromRGB(0x0df1ff)];
    _animation_line.frame = CGRectMake(scanContent_X * 0.5, scanContentViewY, self.frame.size.width - scanContent_X , animation_line_H);
    [self.basedLayer addSublayer:_animation_line.layer];
    
    // 添加定时器
    self.timer =[NSTimer scheduledTimerWithTimeInterval:timer_animation_Duration target:self selector:@selector(animation_line_action) userInfo:nil repeats:YES];
    
#pragma mark - - - 扫描外部View的创建
    // 顶部View的创建
    UIView *top_View = [[UIView alloc] init];
    CGFloat top_ViewX = 0;
    CGFloat top_ViewY = 0;
    CGFloat top_ViewW = self.frame.size.width;
    CGFloat top_ViewH = scanContentViewY;
    top_View.frame = CGRectMake(top_ViewX, top_ViewY, top_ViewW, top_ViewH);
    top_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:top_View];

    // 左侧View的创建
    UIView *left_View = [[UIView alloc] init];
    CGFloat left_ViewX = 0;
    CGFloat left_ViewY = scanContentViewY;
    CGFloat left_ViewW = scanContent_X;
    CGFloat left_ViewH = scanContentViewH;
    left_View.frame = CGRectMake(left_ViewX, left_ViewY, left_ViewW, left_ViewH);
    left_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:left_View];
    
    // 右侧View的创建
    UIView *right_View = [[UIView alloc] init];
    CGFloat right_ViewX = CGRectGetMaxX(scanContentView.frame);
    CGFloat right_ViewY = scanContentViewY;
    CGFloat right_ViewW = scanContent_X;
    CGFloat right_ViewH = scanContentViewH;
    right_View.frame = CGRectMake(right_ViewX, right_ViewY, right_ViewW, right_ViewH);
    right_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:right_View];

    // 下面View的创建
    UIView *bottom_View = [[UIView alloc] init];
    CGFloat bottom_ViewX = 0;
    CGFloat bottom_ViewY = CGRectGetMaxY(scanContentView.frame);
    CGFloat bottom_ViewW = self.frame.size.width;
    CGFloat bottom_ViewH = self.frame.size.height - bottom_ViewY;
    bottom_View.frame = CGRectMake(bottom_ViewX, bottom_ViewY, bottom_ViewW, bottom_ViewH);
    bottom_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:scanBorderOutsideViewAlpha];
    [self addSubview:bottom_View];

    // 提示Label
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.backgroundColor = [UIColor clearColor];
    CGFloat promptLabelX = 0;
    CGFloat promptLabelY = scanContent_X * 0.5;
    CGFloat promptLabelW = self.frame.size.width;
    CGFloat promptLabelH = 25;
    promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
    promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    promptLabel.text = @"将二维码放入框内, 即可自动扫描";
    [bottom_View addSubview:promptLabel];
    
    //正在识别
    
    UILabel *recognitionLab = [[UILabel alloc] initWithFrame:CGRectMake((SCreenWidth-120)/2, promptLabel.bottom+10, 120, 30)];
//    recognitionLab.frame = CGRectMake((SCreenWidth-120)/2, promptLabel.bottom+10, 120, 40);
    recognitionLab.backgroundColor = [UIColor blackColor];
    recognitionLab.alpha = 0.5;
    recognitionLab.textAlignment = NSTextAlignmentCenter;
    [recognitionLab setCornerSize:20];
    recognitionLab.text =@"      正在识别······";
    recognitionLab.textColor = themeColor;//UIColorFromRGB(0x0df1ff);
    recognitionLab.font = [UIFont boldSystemFontOfSize:13.0];
    [bottom_View addSubview:recognitionLab];
    
    _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(recognitionLab.left+8, recognitionLab.top+6, recognitionLab.height-12, recognitionLab.height-12)];
    _imgV.image = [UIImage imageNamed:@"scanLoad"];
    [bottom_View addSubview:_imgV];
#pragma mark - - - 扫描边角imageView的创建
    // 左上侧的image
    CGFloat margin = 7;
    
    UIImage *left_image = [[UIImage imageNamed:@"scanCodeTopLeft"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *left_imageView = [[UIImageView alloc] init];
    CGFloat left_imageViewX = CGRectGetMinX(scanContentView.frame) - left_image.size.width * 0.5 + margin;
    CGFloat left_imageViewY = CGRectGetMinY(scanContentView.frame) - left_image.size.width * 0.5 + margin;
    CGFloat left_imageViewW = left_image.size.width;
    CGFloat left_imageViewH = left_image.size.height;
    left_imageView.frame = CGRectMake(left_imageViewX, left_imageViewY, left_imageViewW, left_imageViewH);
    left_imageView.image = left_image;
    left_imageView.tintColor = themeColor;
    [self.basedLayer addSublayer:left_imageView.layer];
    
    // 右上侧的image
    UIImage *right_image = [[UIImage imageNamed:@"scanCodeTopLeft"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *right_imageView = [[UIImageView alloc] init];
    CGFloat right_imageViewX = CGRectGetMaxX(scanContentView.frame) - right_image.size.width * 0.5 - margin;
    CGFloat right_imageViewY = left_imageView.frame.origin.y;
    CGFloat right_imageViewW = left_image.size.width;
    CGFloat right_imageViewH = left_image.size.height;
    right_imageView.frame = CGRectMake(right_imageViewX, right_imageViewY, right_imageViewW, right_imageViewH);
    right_imageView.image = right_image;
    right_imageView.transform = CGAffineTransformMakeRotation(90 * M_PI/180.0);
    right_imageView.tintColor = themeColor;
    [self.basedLayer addSublayer:right_imageView.layer];
    // 左下侧的image
    UIImage *left_image_down = [[UIImage imageNamed:@"scanCodeTopLeft"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *left_imageView_down = [[UIImageView alloc] init];
    CGFloat left_imageView_downX = left_imageView.frame.origin.x;
    CGFloat left_imageView_downY = CGRectGetMaxY(scanContentView.frame) - left_image_down.size.width * 0.5 - margin;
    CGFloat left_imageView_downW = left_image.size.width;
    CGFloat left_imageView_downH = left_image.size.height;
    left_imageView_down.frame = CGRectMake(left_imageView_downX, left_imageView_downY, left_imageView_downW, left_imageView_downH);
    left_imageView_down.image = left_image_down;
    left_imageView_down.transform = CGAffineTransformMakeRotation(-90 * M_PI/180.0);
    left_imageView_down.tintColor = themeColor;
    [self.basedLayer addSublayer:left_imageView_down.layer];
    
    // 右下侧的image
    UIImage *right_image_down = [[UIImage imageNamed:@"scanCodeTopLeft"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *right_imageView_down = [[UIImageView alloc] init];
    CGFloat right_imageView_downX = right_imageView.frame.origin.x;
    CGFloat right_imageView_downY = left_imageView_down.frame.origin.y;
    CGFloat right_imageView_downW = left_image.size.width;
    CGFloat right_imageView_downH = left_image.size.height;
    right_imageView_down.frame = CGRectMake(right_imageView_downX, right_imageView_downY, right_imageView_downW, right_imageView_downH);
    right_imageView_down.image = right_image_down;
    right_imageView_down.transform = CGAffineTransformMakeRotation(180 * M_PI/180.0);
    right_imageView_down.tintColor = themeColor;
    [self.basedLayer addSublayer:right_imageView_down.layer];

}


#pragma mark - - - 执行定时器方法
- (void)animation_line_action {
    __block CGRect frame = _animation_line.frame;
    
    static BOOL flag = YES;
    
    if (flag) {
        frame.origin.y = scanContent_Y;
        flag = NO;
        [UIView animateWithDuration:timer_animation_Duration animations:^{
            frame.origin.y += 5;
            _animation_line.frame = frame;
        } completion:nil];
        
        [UIView animateWithDuration:scanContent_Y*0.019 animations:^{
            _imgV.transform = CGAffineTransformMakeRotation(180 * M_PI/180.0);//CGAffineTransformRotate(_imgV.transform, 180 * M_PI/180.0);// CGAffineTransformMakeRotation(90 * M_PI/180.0);
        }];
    } else {
        if (_animation_line.frame.origin.y >= scanContent_Y) {
            CGFloat scanContent_MaxY = scanContent_Y + self.frame.size.width - 2 * scanContent_X;
            if (_animation_line.frame.origin.y >= scanContent_MaxY - 5) {
                frame.origin.y = scanContent_Y;
                _animation_line.frame = frame;
                flag = YES;
            } else {
                [UIView animateWithDuration:timer_animation_Duration animations:^{
                    frame.origin.y += 5;
                    _animation_line.frame = frame;
                } completion:nil];
                [UIView animateWithDuration:scanContent_Y*0.019 animations:^{
                    _imgV.transform = CGAffineTransformMakeRotation(360 * M_PI/180.0);//CGAffineTransformRotate(_imgV.transform, 180 * M_PI/180.0);
                }];
            }
        } else {
            flag = !flag;
        }
    }
}

/** 移除定时器 */
- (void)removeTimer {
    [self.timer invalidate];
    [self.animation_line removeFromSuperview];
    self.animation_line = nil;
}



@end


