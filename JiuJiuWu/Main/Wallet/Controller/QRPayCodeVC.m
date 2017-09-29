//
//  QRPayCodeVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/29.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "QRPayCodeVC.h"

@interface QRPayCodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;

@end

@implementation QRPayCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码收款";
    self.view.backgroundColor = CommonBackgroudColor;
    
}
-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostOriginalWithUrl:ScanPayQrCode params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString * qrUrl = [responseObject objectForKey:@"qrcode_url"];
        if (!STRISEMPTY(qrUrl)) {
            [weakSelf.qrImageView sd_setImageWithURL:[NSURL URLWithString:qrUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [weakSelf hudclose];
            }];
        }else {
            [weakSelf hudclose];
            [JJWBase alertMessage:@"图片链接为空！" cb:nil];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}






@end
