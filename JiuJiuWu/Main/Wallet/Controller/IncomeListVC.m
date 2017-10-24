//
//  IncomeListVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/23.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "IncomeListVC.h"
#import "IncomeTableViewCell.h"
#import "PaySuccessVC.h"

@interface IncomeListVC ()

@end

@implementation IncomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易记录";
}
-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:CashOrderList params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[PaySuccessItem class] json:responseObject].mutableCopy;
        if (weakSelf.dataSources.count > 0) {
            [self createTableView];
        }else {
            [self createEmptyView];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Identifier";
    IncomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"IncomeTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PaySuccessItem * item = [self.dataSources objectAtIndex:indexPath.row];
    [cell updateCell:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PaySuccessVC * VC = [[PaySuccessVC alloc]init];
    PaySuccessItem * item = [self.dataSources objectAtIndex:indexPath.row];
    VC.item = item;
    [self.navigationController pushViewController:VC animated:YES];
}



@end
