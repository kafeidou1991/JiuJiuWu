//
//  MeCenterVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/12.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "MeCenterVC.h"
#import "LoginVC.h"

@interface MeCenterVC ()

@end

@implementation MeCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)login {
    [LoginVC OpenLogin:self callback:^(BOOL compliont) {
        
    }];
    
}


@end
