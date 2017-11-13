//
//  FeatureListView.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/15.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "FeatureListView.h"
#import "FeatureListCell.h"

static CGFloat const leftSpace = 11.f; //左间距
static CGFloat const itemHeight = 120.f; //item 高度
static NSString * cellId = @"cellId";


@interface FeatureListView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) UICollectionView * collectionView;

@end


@implementation FeatureListView

-(instancetype)initWithFrame:(CGRect)frame DataSourse:(NSArray<NSDictionary *> *)dataArray {
    //根据个数来确定view的高度
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, itemHeight * ((dataArray.count % 3 == 0) ? dataArray.count/3 : dataArray.count/3 + 1));
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataArray;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
        [self addSepLions];
    }
    return self;
}

//增加分割线
- (void)addSepLions {
    if (self.dataSource.count <= 3) {
        return;
    }
    CGFloat marge = 15.f;
    //横线
    for (NSInteger i = 1; i < 3 ; i++) {
        UIView * view = [UIView new];
        view.frame = CGRectMake(marge, itemHeight * i + 0.5 * (i - 1) , self.collectionView.width -  2 * marge, .5f);
        view.backgroundColor = CellLine_Color;
        [self.collectionView addSubview:view];
    }
    //竖线
    for (NSInteger i = 1; i < 3 ; i++) {
        UIView * view = [UIView new];
        view.frame = CGRectMake((self.frame.size.width - 2 * leftSpace)/3 * i + 0.5 * (i -1), marge , .5f, (self.collectionView.height - 2 * leftSpace));
        view.backgroundColor = CellLine_Color;
        [self.collectionView addSubview:view];
    }
    
}
#pragma mark - collectionDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(FeatureListCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeatureListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell updateCell:self.dataSource[indexPath.item]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString * title = [self.dataSource[indexPath.item] objectForKey:@"title"];
    if ([title isEqualToString:@"我的账户"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_MyAccount);
        }
    }else if ([title isEqualToString:@"我的分润"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_MyProfit);
        }
    }else if ([title isEqualToString:@"交易记录"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_PayList);
        }
    }else if ([title isEqualToString:@"我的商户"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_MyShop);
        }
    }else if ([title isEqualToString:@"我的费率"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_MyRate);
        }
    }else if ([title isEqualToString:@"我要升级"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_LeveUp);
        }
    }else if ([title isEqualToString:@"贷款"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_Loan);
        }
    }else if ([title isEqualToString:@"理财"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_Money);
        }
    }else if ([title isEqualToString:@"更多"]) {
        if (_typeBlock) {
            _typeBlock(SelectType_More);
        }
    }
}


#pragma  mark -  initUI

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * cfl = [[UICollectionViewFlowLayout alloc]init];
        cfl.minimumLineSpacing = 0;
        cfl.minimumInteritemSpacing = 0;
        cfl.itemSize = CGSizeMake((self.frame.size.width - 2 * leftSpace)/3, itemHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(leftSpace, 0, self.frame.size.width - 2 * leftSpace, self.frame.size.height) collectionViewLayout:cfl];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator =NO;
        _collectionView.showsHorizontalScrollIndicator =NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.cornerRadius = 8.f;
        [_collectionView registerNib:[UINib nibWithNibName:@"FeatureListCell" bundle:nil] forCellWithReuseIdentifier:cellId];
        
    }
    return _collectionView;
}












@end
