
//
//  FZMWalletFunctionCell.m
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/9.
//  Copyright © 2018年 张竟巍. All rights reserved.
//

#import "FZMWalletFunctionCell.h"

@interface FZMWalletFunctionCell (){
    BOOL _isOpen;
}

@property (strong, nonatomic) QMUIGridView *gridView;

@end

@implementation FZMWalletFunctionCell{
    NSArray *_titlesArray;
    NSArray *_imagesArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = UIColorClear;
    }
    
    return self;
}

- (void)configVersonIsOpen:(BOOL)isOpen{
    
    _isOpen = isOpen;
    
    if (isOpen) {
        _titlesArray = @[@"我的账户",@"我的分润",
                         @"分享",@"我的商户",
                         @"我的抽奖",@"我要升级",
                         @"申请信用卡",@"信用贷",];
        _imagesArray = @[@"featurelist_0",@"featurelist_1",
                         @"featurelist_2",@"featurelist_3",
                         @"featurelist_4",@"featurelist_5",
                         @"featurelist_6",@"featurelist_7"];
    } else {
        _titlesArray = @[@"交易记录"];
        _imagesArray = @[@"featurelist_2"];
    }
    
    [self addSubview:self.gridView];
}

- (QMUIGridView *)gridView{
    if (!_gridView) {
        
        if (_isOpen) {
            _gridView = [[QMUIGridView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        } else {
            _gridView = [[QMUIGridView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4)];
        }
        _gridView.columnCount = 4;
        _gridView.rowHeight = SCREEN_WIDTH/4;
        _gridView.separatorWidth = PixelOne *2;
        _gridView.backgroundColor = UIColorWhite;
        _gridView.qmui_borderPosition = QMUIBorderViewPositionTop | QMUIBorderViewPositionBottom;
        
        
        for (NSInteger i = 0; i < _titlesArray.count; i++) {
            QMUIButton *button = [[QMUIButton alloc] initWithImage:UIImageMake(_imagesArray[i]) title:_titlesArray[i]];
            [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
            button.imagePosition = QMUIButtonImagePositionTop;
            button.spacingBetweenImageAndTitle = kJJWSmallMargin;
            button.titleLabel.font = UIFont_PFSCR_Make(13);
            [button setTitleColor:kJJWTitleColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.gridView addSubview:button];
        }
    }
    
    return _gridView;
}

- (void)clickButton:(QMUIButton *)button{
    
    NSString *title = button.titleLabel.text;
    
    if ([title isEqualToString:@"我的账户"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_MyAccount);
        }
    }else if ([title isEqualToString:@"我的分润"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_MyProfit);
        }
    }else if ([title isEqualToString:@"分享"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_Share);
        }
    }else if ([title isEqualToString:@"我的商户"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_MyShop);
        }
    }else if ([title isEqualToString:@"我的抽奖"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_MyLucky);
        }
    }else if ([title isEqualToString:@"我要升级"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_LeveUp);
        }
    }else if ([title isEqualToString:@"信用贷"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_Loan);
        }
    }else if ([title isEqualToString:@"理财"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_Money);
        }
    }else if ([title isEqualToString:@"申请信用卡"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_CreditCard);
        }
    }else if ([title isEqualToString:@"交易记录"]) {
        if (_typeBlock) {
            _typeBlock(JJWSelectType_PayList);
        }
    }
}

@end
