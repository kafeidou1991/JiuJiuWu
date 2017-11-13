//
//  KeyBoradView.m
//  YZF
//
//  Created by 咖啡豆 on 17/3/23.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "KeyBoradView.h"

static CGFloat const space = 4.f;

static NSInteger const col = 3;

static NSInteger const row = 4;

static UIEdgeInsets const contentInSet = (UIEdgeInsets){75.f,8,20,8}; //边界距离

#define BUTTON_WIDTH (self.width - contentInSet.left - contentInSet.right -  col * space) / (col + 1)
#define BUTTON_HEIGHT (self.height - contentInSet.top - contentInSet.bottom - (row - 1) * space) / row

@interface KeyBoradView ()
/** titles */
@property (nonatomic, strong) NSArray * titleArray;
/** 全部数字按钮 */
@property (nonatomic, strong) NSMutableArray * buttons;

@property (nonatomic, strong) NSMutableArray * functionBtns;

@property (nonatomic, strong) UILabel * tipLabel;
@property (nonatomic, strong) UILabel * amountLabel;

/** 当前字符串 */
@property (nonatomic, copy) NSMutableString * currString;

@end

@implementation KeyBoradView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _buttons = @[].mutableCopy;
        _functionBtns = @[].mutableCopy;
        _currString = @"".mutableCopy;
        [self addSubview:self.tipLabel];
        [self addSubview:self.amountLabel];
        [self _createButtons];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _buttons = @[].mutableCopy;
        _functionBtns = @[].mutableCopy;
        _currString = @"".mutableCopy;
        [self addSubview:self.tipLabel];
        [self addSubview:self.amountLabel];
        [self _createButtons];
        [self _createFunctionBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _tipLabel.frame = CGRectMake(contentInSet.left, 0, 80, contentInSet.top);
    _amountLabel.frame = CGRectMake(contentInSet.left + _tipLabel.width, 0, self.width - contentInSet.left - contentInSet.right - _tipLabel.width, contentInSet.top);
    for (int i = 0; i<self.titleArray.count; i++) {
        CGFloat x = i % col;
        CGFloat y = i / col;
        UIButton * btn = [_buttons objectAtIndex:i];
        btn.frame = CGRectMake(contentInSet.left + x * (BUTTON_WIDTH + space), contentInSet.top + y * (BUTTON_HEIGHT + space), BUTTON_WIDTH, BUTTON_HEIGHT);
    }
    for (int i = 0; i < 3; i++) {
        UIButton * btn = [_functionBtns objectAtIndex:i];
        if (i != 2) {
            btn.frame = CGRectMake(contentInSet.left + col * (BUTTON_WIDTH + space), contentInSet.top + i * (BUTTON_HEIGHT + space), BUTTON_WIDTH, BUTTON_HEIGHT);
        }else {
            btn.frame = CGRectMake(contentInSet.left + col * (BUTTON_WIDTH + space), contentInSet.top + i * (BUTTON_HEIGHT + space), BUTTON_WIDTH, 2 * BUTTON_HEIGHT + space);
        }
    }
}

- (void) _createButtons{
    [self.titleArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        [btn addTarget:self action:@selector(clickTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:DesTextColor forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderColor = DesTextColor.CGColor;
        btn.layer.borderWidth = .5f;
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius =3.0f;
        btn.titleLabel.font = [UIFont systemFontOfSize:25];
        btn.adjustsImageWhenHighlighted =NO;
        [_buttons addObject:btn];
    }];
    [self addSubviews:_buttons];
}
- (void)_createFunctionBtn {
    for (NSInteger idx = 0; idx < 3; idx++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 +idx;
        [btn addTarget:self action:@selector(clickFunctionTap:) forControlEvents:UIControlEventTouchUpInside];
        if (idx == 0) {
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [btn setImage:[UIImage imageNamed:@"keyBorad_del"] forState:UIControlStateNormal];
        }else if (idx == 1){
            [btn setTitle:@"清除" forState:UIControlStateNormal];
        }else {
            [btn setTitle:@"收款" forState:UIControlStateNormal];
        }
        [btn setTitleColor:DesTextColor forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderColor = DesTextColor.CGColor;
        btn.layer.borderWidth = .5f;
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius =3.0f;
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        btn.adjustsImageWhenHighlighted =NO;
        [_functionBtns addObject:btn];
    }
    [self addSubviews:_functionBtns];
}
- (void)clickFunctionTap:(UIButton *)sender {
    //del
    if (sender.tag == 100) {
        if (![_amountLabel.text isEqualToString:@"￥"]) {
            _currString = [_currString substringToIndex:_currString.length - 1].mutableCopy;
            _amountLabel.text = [NSString stringWithFormat:@"￥%@",_currString];
        }else {
            _amountLabel.text = @"￥";
            _currString = @"".mutableCopy;
        }
    }else if (sender.tag == 101) { //清除
        _amountLabel.text = @"￥";
        _currString = @"".mutableCopy;
        
    }else if (sender.tag == 102) {//收款
        if (_valueBlock) {
            _valueBlock((NSString *)_currString);
        }
    }
    
}

- (void)clickTap:(UIButton *)sender{
    //最多5位
    if (![_currString containsString:@"."] && _currString.length > 4 && sender.tag != 11) {
        return;
    }
    //开始时输入 点或者00 不做处理
    if (STRISEMPTY(_currString) && ((sender.tag == 10) || (sender.tag == 11))) {
        return;
    }
    //首字母是0 下位不是点 不做处理
    if ([_currString isEqualToString:@"0"]){
        if (!(sender.tag == 10)) {
            return;
        }
    }
    //小数点不能重复输入  //小数点 最多两位
    if ([_currString containsString:@"."]) {
        if (sender.tag == 10) {
            return;
        }
        NSArray * array = [_currString componentsSeparatedByString:@"."];
        if (((NSString *)array[1]).length >= 2) {
            return;
        }
    }
    if (_currString.integerValue == 9300) {
        return;
    }
    NSString * temp = [self _configNumber:sender.tag];
    [_currString appendString:temp];
    _amountLabel.text = [NSString stringWithFormat:@"￥%@",_currString];
}
- (NSString *) _configNumber:(NSInteger)tag{
    switch (tag) {
        case 9:
            return @"0";
            break;
        case 10:
            return @".";
            break;
        case 11:
            return @"00";
            break;
        default:
            return [NSString stringWithFormat:@"%ld",tag + 1];
            break;
    }
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@".",@"00"];
    }
    return _titleArray;
}

-(UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [JJWBase createLabel:CGRectZero font:[UIFont systemFontOfSize:25] text:@"￥" defaultSizeTxt:@"" color:[UIColor redColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    }
    return _amountLabel;
}
-(UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [JJWBase createLabel:CGRectZero font:[UIFont systemFontOfSize:14] text:@"收款金额：" defaultSizeTxt:@"" color:MainTextColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    }
    return _tipLabel;
}


@end
