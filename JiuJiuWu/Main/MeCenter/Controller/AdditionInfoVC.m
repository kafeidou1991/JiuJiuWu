//
//  AdditionInfoVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/13.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "AdditionInfoVC.h"
#import "AdditionInfoCell.h"
#import "AdditionHeadView.h"
#import "AdditionFootView.h"
#import "ZLPhotoActionSheet.h"

@interface AdditionInfoVC () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) DloginData * currCardItem;

@end

@implementation AdditionInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"补充认证信息";
    self.currCardItem = [[JJWLogin sharedMethod].loginData yy_modelCopy];
    self.dataSource = @[@{@"title":@"手持身份证和银行卡",@"image":STRISEMPTY(self.currCardItem.idcard_bank_img) ? @"" : [self.currCardItem.idcard_bank_img configDomain]},
                        @{@"title":@"商铺门头照",@"image":STRISEMPTY(self.currCardItem.shop_head_img) ? @"" : [self.currCardItem.shop_head_img configDomain]},
                        @{@"title":@"经营场所",@"image":STRISEMPTY(self.currCardItem.shop_inner_img) ? @"" : [self.currCardItem.shop_inner_img configDomain]},
                        @{@"title":@"收银台",@"image":STRISEMPTY(self.currCardItem.shop_cash_img) ? @"" : [self.currCardItem.shop_cash_img configDomain]},
                        @{@"title":@"出租合同1",@"image":STRISEMPTY(self.currCardItem.contract_img_one) ? @"" : [self.currCardItem.contract_img_one configDomain]},
                        @{@"title":@"出租合同2",@"image":STRISEMPTY(self.currCardItem.contract_img_two) ? @"" : [self.currCardItem.contract_img_two configDomain]},
                        ];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AdditionInfoCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([AdditionInfoCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AdditionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([AdditionHeadView class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AdditionFootView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([AdditionFootView class])];
}
//MARK: 提交
- (void)submite {
    //上传图片
    if (IMAGEISEMPTY(_currCardItem.idcard_bank_img_img) ||
        IMAGEISEMPTY(_currCardItem.shop_head_img_img) ||
        IMAGEISEMPTY(_currCardItem.shop_inner_img_img) ||
        IMAGEISEMPTY(_currCardItem.shop_cash_img_img) ||
        IMAGEISEMPTY(_currCardItem.contract_img_one_img)||
        IMAGEISEMPTY(_currCardItem.contract_img_two_img)) {
        [JJWBase alertMessage:@"请完善补充每一张图片信息!" cb:nil];
        return;
    }
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSMutableDictionary * dict = @{
                                   @"token":[JJWLogin sharedMethod].loginData.token,
                                   @"idcard_bank_img":[self base64Str:_currCardItem.idcard_bank_img_img],
                                   @"shop_head_img":[self base64Str:_currCardItem.shop_head_img_img],
                                   @"shop_inner_img":[self base64Str:_currCardItem.shop_inner_img_img],
                                   @"shop_cash_img":[self base64Str:_currCardItem.shop_cash_img_img],
                                   @"contract_img_one":[self base64Str:_currCardItem.contract_img_one_img],
                                   @"contract_img_two":[self base64Str:_currCardItem.contract_img_two_img]}.mutableCopy;
    [JJWNetworkingTool PostWithUrl:UpdateUserOtherInfo params:dict.copy isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"补充完善成功!" cb:nil];
        //更新本地数据
        [self saveUpdateDate:responseObject];
        [[JJWLogin sharedMethod]saveLoginData:self.currCardItem];
        self.currCardItem = nil;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void)saveUpdateDate:(id)result {
    DloginData * tempData = [DloginData yy_modelWithJSON:result];
    self.currCardItem.idcard_bank_img = tempData.idcard_bank_img;
    self.currCardItem.shop_head_img = tempData.shop_head_img;
    self.currCardItem.shop_inner_img = tempData.shop_inner_img;
    self.currCardItem.shop_cash_img = tempData.shop_cash_img;
    self.currCardItem.contract_img_one = tempData.contract_img_one;
    self.currCardItem.contract_img_two = tempData.contract_img_two;
}
- (NSString *) base64Str:(UIImage *)image {
    NSData * data = UIImageJPEGRepresentation(image, 0.0);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdditionInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AdditionInfoCell class]) forIndexPath:indexPath];
    NSDictionary * dict = self.dataSource[indexPath.item];
    UIImage * image = [self selectedImage:indexPath];
    if (image) {
        cell.contentImageView.image = image;
    }else {
        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]] placeholderImage:[UIImage imageNamed:@"companyInfo_0"]];
    }
    cell.contentTitleLabel.text = dict[@"title"];
    
    return cell;
}
- (UIImage *)selectedImage:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return self.currCardItem.idcard_bank_img_img;
    }else if (indexPath.item == 1) {
        return self.currCardItem.shop_head_img_img;
    }else if (indexPath.item == 2) {
        return self.currCardItem.shop_inner_img_img;
    }else if (indexPath.item == 3) {
        return self.currCardItem.shop_cash_img_img;
    }else if (indexPath.item == 4) {
        return self.currCardItem.contract_img_one_img;
    }else if (indexPath.item == 5) {
        return self.currCardItem.contract_img_two_img;
    }else {
        return nil;
    }
}
/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        AdditionHeadView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind  withReuseIdentifier:NSStringFromClass([AdditionHeadView class])   forIndexPath:indexPath];
        return view;
    }
    else {
        // 底部
        AdditionFootView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:NSStringFromClass([AdditionFootView class])   forIndexPath:indexPath];
        WeakSelf
        view.block = ^{
            [weakSelf submite];
        };
        return view;
    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCreenWidth- 20)/2;
    //40 label 高度
    return CGSizeMake(width, width * 9 / 16 + 40);
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 50);
}

/** 底部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.view.bounds.size.width, 125);
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self openPhotoCameraAction:indexPath];
}
#pragma mark - 照片选择
- (void)openPhotoCameraAction:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    ZLPhotoActionSheet * actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    actionSheet.allowSelectVideo = NO;
    actionSheet.allowSelectGif = NO;
    actionSheet.allowSelectImage = YES;
    [actionSheet showPreviewAnimated:YES sender:self];
    
    actionSheet.selectImageBlock = ^(NSArray<UIImage *> * _Nonnull imageArray, NSArray<PHAsset *> * _Nonnull imageSet, BOOL is) {
        UIImage *image = imageArray[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (indexPath.item == 0) {
                self.currCardItem.idcard_bank_img_img = image;
            }else if (indexPath.item == 1) {
                self.currCardItem.shop_head_img_img = image;
            }else if (indexPath.item == 2) {
                self.currCardItem.shop_inner_img_img = image;
            }else if (indexPath.item == 3) {
                self.currCardItem.shop_cash_img_img = image;
            }else if (indexPath.item == 4) {
                self.currCardItem.contract_img_one_img = image;
            }else if (indexPath.item == 5) {
                self.currCardItem.contract_img_two_img = image;
            }
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        });
    };
}

#pragma mark -- lazy load
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
         layout.minimumInteritemSpacing = 10; // 水平方向的间距
         layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCreenWidth, self.view.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end