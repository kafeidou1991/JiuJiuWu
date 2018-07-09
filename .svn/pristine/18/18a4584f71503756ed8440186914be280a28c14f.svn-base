//
//  FZMWalletBannerCell.m
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/9.
//  Copyright © 2018年 张竟巍. All rights reserved.
//

#import "FZMWalletBannerCell.h"

#import "AdvertiseItem.h"

#import <SDCycleScrollView.h>

@interface FZMWalletBannerCell ()<SDCycleScrollViewDelegate>{
    AdvertiseItem *_item;
}

@property (strong, nonatomic) NSMutableArray    *bannerImagesArray;
@property (strong, nonatomic) NSMutableArray    *bannertitlesArray;
@property (strong, nonatomic) NSMutableArray    *bannerLinksArray;

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation FZMWalletBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI{
    [self addSubview:self.cycleScrollView];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) imageURLStringsGroup:nil];
        _cycleScrollView.placeholderImage = JJWImageMake(@"banner_image");
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    }
    
    return _cycleScrollView;
}

- (void)configItem:(NSArray *)adsImageArray{
    
    [self.bannerImagesArray removeAllObjects];
    [self.bannerLinksArray removeAllObjects];
    [self.bannertitlesArray removeAllObjects];
    
    for (AdvertiseItem * item in adsImageArray) {
        //判空
        item.ad_code = kJJWStringIsEmpty(item.ad_code) ? @"" : item.ad_code;
        item.ad_name = kJJWStringIsEmpty(item.ad_name) ? @"" : item.ad_name;
        item.ad_link = kJJWStringIsEmpty(item.ad_link) ? @"" : item.ad_link;

        [self.bannerImagesArray addObject:item.ad_code];
        [self.bannertitlesArray addObject:item.ad_name];
        [self.bannerLinksArray addObject:item.ad_link];
    }
    
    _cycleScrollView.titlesGroup = self.bannertitlesArray;
    _cycleScrollView.imageURLStringsGroup = self.bannerImagesArray;
}

- (NSMutableArray *)bannerImagesArray{
    if (!_bannerImagesArray) {
        _bannerImagesArray = [NSMutableArray array];
    }
    
    return _bannerImagesArray;
}

- (NSMutableArray *)bannertitlesArray{
    if (!_bannertitlesArray) {
        _bannertitlesArray = [NSMutableArray array];
    }
    
    return _bannertitlesArray;
}

- (NSMutableArray *)bannerLinksArray{
    if (!_bannerLinksArray) {
        _bannerLinksArray = [NSMutableArray array];
    }
    
    return _bannerLinksArray;
}

#pragma mark ------SDCycleScrollViewDelegate-------
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    if (kJJWStringIsEmpty(self.bannerLinksArray[index])) {
        [JJWBase alertMessage:@"链接地址为空！" cb:nil];
        return;
    }
    
    if (_bannerBlock) {
        _bannerBlock(self.bannerLinksArray[index]);
    }

}

@end
