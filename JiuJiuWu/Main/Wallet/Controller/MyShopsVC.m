//
//  MyDelegateViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "MyShopsVC.h"
#import "MyDelegateTableViewCell.h"


@interface MyShopsVC ()

@end

@implementation MyShopsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的商户";
    [self createTableView];
}
-(void)afterProFun{
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdenfi = @"";
    MyDelegateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfi];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MyDelegateTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    DelegateItem * item = self.dataSources[indexPath.section];
//    [cell updateCell:item :_myType];
//    cell.editBlock = ^{
//        EditDelegateViewController * editVC = [[EditDelegateViewController alloc]init];
//        editVC.item = item;
//        editVC.isCanChangeLevel = _isCanChangeLevel;
//        [self.navigationController pushViewController:editVC animated:YES];
//    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
