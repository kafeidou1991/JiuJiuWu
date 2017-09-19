//
//  KeyBoradView.m
//  YZF
//
//  Created by 咖啡豆 on 17/3/23.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "KeyBoradView.h"

static CGFloat const space = 3.f;

static NSInteger const col = 3;

#define BUTTON_WIDTH (self.width - 2 * space)/3
#define BUTTON_HEIGHT (self.height - self.titleArray.count / 3 - 3 * space)/4

@interface KeyBoradView ()
/** titles */
@property (nonatomic, strong) NSArray * titleArray;
/** 全部按钮 */
@property (nonatomic, strong) NSMutableArray * buttons;

/** 当前字符串 */
@property (nonatomic, copy) NSMutableString * currString;

@end

@implementation KeyBoradView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _buttons = @[].mutableCopy;
        _currString = @"".mutableCopy;
        [self _createButtons];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0; i<self.titleArray.count; i++) {
        CGFloat x = i % col;
        CGFloat y = i / col;
        UIButton * btn = [_buttons objectAtIndex:i];
        btn.frame = CGRectMake(x * (BUTTON_WIDTH + space), y * (BUTTON_HEIGHT + space), BUTTON_WIDTH, BUTTON_HEIGHT);
    }
}

- (void) _createButtons{
    [self.titleArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        [btn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        if (idx == self.titleArray.count - 1) {
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setImage:[UIImage imageNamed:@"keyboard_del"] forState:UIControlStateNormal];
        }else{
            [btn setTitle:obj forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius =3.0f;
        btn.titleLabel.font = [UIFont systemFontOfSize:25];
        btn.adjustsImageWhenHighlighted =NO;
        [_buttons addObject:btn];
    }];
    [self addSubviews:_buttons];
}

- (void)clickTap:(UIButton *)sender{
    //最多5位
    if (![_currString containsString:@"."] && _currString.length > 4 && sender.tag != 11) {
        return;
    }
    
    //    //最大9300
    //    if (![_currString containsString:@"."] && _currString.length > 3 && sender.tag != 11) {
    //        if (sender.tag != 9) {
    //            [YZFBase alertMessage:@"可输入最大金额9300！" cb:nil];
    //            return;
    //        }
    //    }
    //    if (_currString.length == 3) {
    //        if ([_currString hasPrefix:@"9"] && [_currString substringWithRange:NSMakeRange(1, 1)].integerValue > 3) {
    //            if (!(sender.tag == 9 || sender.tag == 11)) {
    //                [YZFBase alertMessage:@"可输入最大金额9300！" cb:nil];
    //                return;
    //            }
    //        }
    //    }
    //    if (_currString.integerValue > 9300 && sender.tag != 11) {
    //        [YZFBase alertMessage:@"可输入最大金额9300！" cb:nil];
    //        return;
    //    }
    
    //开始时输入 点跟del不做处理
    if (STRISEMPTY(_currString) && (sender.tag == 9 || sender.tag == 11)) {
        return;
    }
    //首字母是0 下位不是点 del 不做处理
    if ([_currString isEqualToString:@"0"]){
        if (!(sender.tag == 11 || sender.tag == 9)) {
            return;
        }
    }
    //小数点不能重复输入  //小数点 最多两位
    if ([_currString containsString:@"."]) {
        if (sender.tag == 9) {
            return;
        }
        NSArray * array = [_currString componentsSeparatedByString:@"."];
        if (((NSString *)array[1]).length >= 2 && sender.tag != 11) {
            return;
        }
    }
    if (_currString.integerValue == 9300 && sender.tag != 11) {
        return;
    }
    NSString * temp = [self _configNumber:sender.tag];
    if (sender.tag == 11) {
        _currString = [_currString substringToIndex:_currString.length - 1].mutableCopy;
    }else{
        [_currString appendString:temp];
    }
    if (_valueBlock) {
        _valueBlock((NSString *)_currString);
    }
}
- (NSString *) _configNumber:(NSInteger)tag{
    switch (tag) {
        case 9:
            return @".";
            break;
        case 10:
            return @"0";
            break;
        case 11:
            return @"del";
            break;
        default:
            return [NSString stringWithFormat:@"%ld",tag + 1];
            break;
    }
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"·",@"0",@"del"];
    }
    return _titleArray;
}



@end
