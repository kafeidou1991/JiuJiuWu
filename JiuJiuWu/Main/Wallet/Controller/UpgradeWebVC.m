//
//  UpgradeWebVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/6.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "UpgradeWebVC.h"
#import "BindStudentInfoVC.h"

@interface UpgradeWebVC ()

@end

@implementation UpgradeWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QMUINavigationButton *rightButton = [[QMUINavigationButton alloc]initWithType:QMUINavigationButtonTypeNormal title:@"绑定大学生信息"];
    rightButton.frame = CGRectMake(0, 0, 50, 20);
    [rightButton addTarget:self action:@selector(bindInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
- (void)bindInfo {
    [self.navigationController pushViewController:[BindStudentInfoVC new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
