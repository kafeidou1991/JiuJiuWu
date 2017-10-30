//
//  ShareWebVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/30.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ShareWebVC.h"

@interface ShareWebVC ()

@end

@implementation ShareWebVC

- (void)viewDidLoad {
    self.urlString = ShareURL;
    self.title = @"分享二维码";
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
}


@end
