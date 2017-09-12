//
//  IdCardApiHelper.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/1.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "IdCardApiHelper.h"


static NSString * const key = @"FoTCVM6PP3CH9fe1wAkJu6";
static NSString * const secret = @"d1a14210789d4cb58f00683c910d2fb7";
static NSString * const url = @"http://netocr.com/api/recog.do";


@implementation IdCardApiHelper

+(instancetype) sharedMethod
{
    static IdCardApiHelper *g_global = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_global = [[IdCardApiHelper alloc] init];
    });
    return g_global;
}

- (void)checkIdCard:(UIImage *)image result:(void (^)(PersionModel *,NSError *))block{
    if (!image) {
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //设置文件路径 001001
    dict[@"key"] = key;
    dict[@"secret"]= secret;
    dict[@"typeId"]=@"2";//2 代表身份证  17 银行卡
    dict[@"format"]=@"json";
    
    //    self.imageview.image = [UIImage imageWithContentsOfFile:sr];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
        NSData *data = UIImageJPEGRepresentation(image, 0.0);
        
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"ap.png" mimeType:@"image/jpeg/png"];//png或者jpg  自己加判断
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据返回
        //返回结果
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        PersionModel * item = [[PersionModel alloc]init];
        for (id a  in [dict[@"cardsinfo"] firstObject][@"items"] ){
            if (a[@"desc"]!=nil) {
                NSLog(@"des%@----content%@",a[@"desc"],a[@"content"]);
                if ([a[@"desc"] isEqualToString:@"姓名"]) {
                    item.name = a[@"content"];
                }else if ([a[@"desc"] isEqualToString:@"公民身份号码"]){
                    item.cardNumber = a[@"content"];
                }else if ([a[@"desc"] isEqualToString:@"住址"]){
                    item.address = a[@"content"];
                }
            }
        }
        if (STRISEMPTY(item.name) || STRISEMPTY(item.cardNumber) ||STRISEMPTY(item.address)) {
            if (block) {
                block(nil,[NSError errorWithDomain:@"照片无法识别!" code:0 userInfo:nil]);
            }
        }else{
            if (block) {
                block(item,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
}
- (void)checkBandIdCard:(UIImage *)image result:(void(^)(BandCardInfo *,NSError *))block{
    if (!image) {
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //设置文件路径 001001
    dict[@"key"] = key;
    dict[@"secret"]= secret;
    dict[@"typeId"]=@"17";//2 代表身份证  17 银行卡
    dict[@"format"]=@"json";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
        NSData *data = UIImageJPEGRepresentation(image, 0.0);
        
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"ap.png" mimeType:@"image/jpeg/png"];//png或者jpg  自己加判断
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //数据返回
        //返回结果
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        BandCardInfo * item = [[BandCardInfo alloc]init];
        for (id a  in [dict[@"cardsinfo"] firstObject][@"items"] ){
            if (a[@"desc"]!=nil) {
                DLog(@"des%@----content%@",a[@"desc"],a[@"content"]);
                if ([a[@"desc"] isEqualToString:@"卡号"]) {
                    item.account = a[@"content"];
                }else if ([a[@"desc"] isEqualToString:@"银行名称"]){
                    item.bandName = a[@"content"];
                }
            }
        }
        if (STRISEMPTY(item.account)) {
            if (block) {
                block(nil,[NSError errorWithDomain:@"照片无法识别!" code:0 userInfo:nil]);
            }
        }
//        else if (STRISEMPTY(item.accountName) || ![item.accountName containsString:@"农业"]){
//            if (block) {
//                block(nil,[NSError errorWithDomain:@"暂只支持中国农业银行!" code:0 userInfo:nil]);
//            }
//        }
        else{
            if (block) {
                block(item,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
    
}

@end
