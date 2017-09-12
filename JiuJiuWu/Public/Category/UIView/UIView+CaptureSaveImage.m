//
//  UIView+CaptureSaveImage.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/29.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "UIView+CaptureSaveImage.h"
#import <Photos/Photos.h>

@implementation UIView (CaptureSaveImage)


// 保存图片到相册功能，

-(void)savePhoto{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];

    if (status == PHAuthorizationStatusNotDetermined) {
        //正在请求相册权限
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                UIImage * image = [self captureImageFromView:self];
                //将数据保存为图片
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized){
        UIImage * image = [self captureImageFromView:self];
        //将数据保存为图片
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted){
        dispatch_async(dispatch_get_main_queue(), ^{
            [JJWBase alertMessage:@"相册权限未被开启！" cb:nil];
        });
    }
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    dispatch_async(dispatch_get_main_queue(), ^{
       [JJWBase alertMessage:error ? @"图片保存失败！":@"保存成功!" cb:nil];
    });
}


//截图功能

-(UIImage *)captureImageFromView:(UIView *)view{
    
    CGRect screenRect = [view bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
