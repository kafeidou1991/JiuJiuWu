//
//  FZMMineOprationController.m
//  JiuJiuWu
//
//  Created by 付志敏 on 2018/1/24.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "FZMMineOprationController.h"

@interface FZMMineOprationController ()<QMUIImagePreviewViewDelegate>

@property(nonatomic, strong) QMUIImagePreviewView *imagePreviewView;
@property(nonatomic, strong) NSArray<UIImage *> *images;

@end

@implementation FZMMineOprationController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.images = @[JJWImageFile(@"Mine_operation0", @"png"),
                    JJWImageFile(@"Mine_operation1", @"png"),
                    JJWImageFile(@"Mine_operation2", @"png"),
                    JJWImageFile(@"Mine_operation3", @"png"),
                    JJWImageFile(@"Mine_operation4", @"png"),
                    JJWImageFile(@"Mine_operation5", @"png"),
                    JJWImageFile(@"Mine_operation6", @"png")];
    
    self.imagePreviewView = [[QMUIImagePreviewView alloc] init];
    self.imagePreviewView.delegate = self;
    self.imagePreviewView.loadingColor = UIColorGray;// 设置每张图片里的 loading 的颜色，需根据业务场景来修改
    self.imagePreviewView.collectionViewLayout.minimumLineSpacing = 0;// 去掉每张图片之间的间隙
    [self.view addSubview:self.imagePreviewView];
    
    self.title = [self titleForIndex:self.imagePreviewView.currentImageIndex];
}

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//
//        self.automaticallyAdjustsScrollViewInsets = NO;
//
//
//    }
//    return self;
//}

//- (void)initSubviews {
//    [super initSubviews];
//
//}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat originY = self.qmui_navigationBarMaxYInViewCoordinator;
    
    CGSize imageSize = self.images.firstObject.size;
    CGSize imagePreviewViewSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds) * imageSize.height / imageSize.width);
    imagePreviewViewSize.height = fmin(CGRectGetHeight(self.view.bounds) - originY, imagePreviewViewSize.height);
    
    self.imagePreviewView.frame = CGRectFlatMake(CGFloatGetCenter(CGRectGetWidth(self.view.bounds), imagePreviewViewSize.width), originY, imagePreviewViewSize.width, imagePreviewViewSize.height);
}

//- (void)setNavigationItemsIsInEditMode:(BOOL)isInEditMode animated:(BOOL)animated {
//    [super setNavigationItemsIsInEditMode:isInEditMode animated:animated];
//
//}

- (NSString *)titleForIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"%@ / %@", @(index + 1), @(self.images.count)];
}

#pragma mark - <QMUIImagePreviewViewDelegate>

- (NSUInteger)numberOfImagesInImagePreviewView:(QMUIImagePreviewView *)imagePreviewView {
    return self.images.count;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView renderZoomImageView:(QMUIZoomImageView *)zoomImageView atIndex:(NSUInteger)index {
    
    zoomImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (index == 1) {
        
        zoomImageView.image = nil; // 第 2 张图将图片清空，模拟延迟加载的场景
        [zoomImageView showLoading];// 显示 loading（loading 也可与图片同时显示）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 由于 cell 是复用的，所以之前的 zoomImageView 可能已经被用于显示其他 index 的图片了，所以这里要重新判断一下 index
            NSUInteger indexForZoomImageView = [imagePreviewView indexForZoomImageView:zoomImageView];
            if (indexForZoomImageView == index) {
                zoomImageView.image = self.images[index];
                [zoomImageView hideEmptyView];// 把 loading 隐藏掉
            }
        });
    } else {
        // 设置图片，此时会按默认的缩放来显示（所谓的默认缩放指如果图片比容器小则显示原大小，如果图片比容器大，则缩放到完整显示图片）
        zoomImageView.image = self.images[index];
        [zoomImageView hideEmptyView];
    }
}

- (QMUIImagePreviewMediaType)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView assetTypeAtIndex:(NSUInteger)index {
    return QMUIImagePreviewMediaTypeImage;
}

- (void)imagePreviewView:(QMUIImagePreviewView *)imagePreviewView willScrollHalfToIndex:(NSUInteger)index {
    self.title = [self titleForIndex:index];
}

@end
