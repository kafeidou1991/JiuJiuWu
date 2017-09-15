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
    }
    return self;
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
    NSLog(@"123");
}


#pragma  mark -  initUI

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * cfl = [[UICollectionViewFlowLayout alloc]init];
        cfl.minimumLineSpacing = 0;
        cfl.minimumInteritemSpacing = 0;
        cfl.itemSize = CGSizeMake((self.frame.size.width - 2 * leftSpace)/3, self.frame.size.height / ((self.dataSource.count % 3 == 0)?self.dataSource.count/3 : self.dataSource.count/3 + 1));
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
