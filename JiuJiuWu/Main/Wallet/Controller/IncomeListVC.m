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
#import "ProfitInfoVC.h"
#import "UIViewController+MJPopupViewController.h"

@interface IncomeListVC ()
{
    ProfitInfoVC * VC;
}
@end

@implementation IncomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (_type) {
        case ListType_Income:
            self.title = @"交易记录";
            break;
        case ListType_MyCashDis:
            self.title = @"我的分润";
            break;
        default:
            break;
    }
    
}
-(void)afterProFun {
    if (_type == ListType_Income) {
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
    }else {
        [self hudShow:self.view msg:STTR_ater_on];
        NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,@"token":[JJWLogin sharedMethod].loginData.token};
        WeakSelf
        [JJWNetworkingTool PostWithUrl:CashDistribute params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
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
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Identifier";
    IncomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"IncomeTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    PaySuccessItem * item = [self.dataSources objectAtIndex:indexPath.row];
    if (_type == ListType_Income) {
        [cell updateCell:item];
    }else if (_type ==ListType_MyCashDis) {
        [cell updateWithdrawListCell:item];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PaySuccessItem * item = [self.dataSources objectAtIndex:indexPath.row];
    WeakSelf
    if (_type == ListType_Income) {
        PaySuccessVC * VC = [[PaySuccessVC alloc]init];
        VC.item = item;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (_type == ListType_MyCashDis) {
        VC = [[ProfitInfoVC alloc]initWith:item];
        VC.block = ^{
            [weakSelf dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        };
        [self presentPopupViewController:VC animationType:MJPopupViewAnimationFade];
    }
}



@end
