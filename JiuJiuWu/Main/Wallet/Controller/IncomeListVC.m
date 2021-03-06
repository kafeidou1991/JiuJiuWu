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
#import "MyShareBenefitCell.h"
#import "MyShareBenefitHeadView.h"

@interface IncomeListVC ()

@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) PageItem *pageItem;
@property (nonatomic, strong) id responseObject;

@end

@implementation IncomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    [self configNavigation];
    [self configRequest];
    
}

- (void)configNavigation{
    self.title = (_type == ListType_Income) ? @"交易记录" : @"我的分润";
    
}

- (void)configRequest{
    switch (_type) {
        case ListType_Income:
            [self configTransaction];
            break;
        case ListType_MyCashDis:
            [self shareBenefitRequest];
            break;
        default:
            break;
    }
}

- (void)configTransaction{
    
    [self createTableView];
    WeakSelf
    [self addHeaderRefesh:YES Block:^{
        weakSelf.page = 1;
        [weakSelf transactionRequest];
    }];
    
    [self addFooterRefesh:^{
        [weakSelf transactionMoreRequest];
    }];
}

#pragma mark ------交易记录网络强求-------
- (void)transactionRequest{
    [self hudShow:self.view msg:STTR_ater_on];
    
    NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,
                            @"token":[JJWLogin sharedMethod].loginData.token,
                            @"page":@(self.page)};
    WeakSelf
    
    [JJWNetworkingTool PostWithUrl:CashOrderList params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [self endRefesh:YES];
        [weakSelf hudclose];
        
        weakSelf.pageItem = [PageItem yy_modelWithJSON:responseObject[@"page"]];
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[PaySuccessItem class] json:responseObject[@"list"]].mutableCopy;
        
        if (weakSelf.dataSources.count > 0) {
            [self createTableView];
            
            if (weakSelf.pageItem.page == weakSelf.pageItem.page_total) {
                [self noHasMoreData];
            } else {
                self.page = weakSelf.pageItem.page + 1;
            }
            
        }else {
            [self createEmptyView];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [self endRefesh:YES];
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];

}

- (void)transactionMoreRequest{
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,
                            @"token":[JJWLogin sharedMethod].loginData.token,
                            @"page":@(self.page)};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:CashOrderList params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [self endRefesh:NO];
        [weakSelf hudclose];
        
        weakSelf.pageItem = [PageItem yy_modelWithJSON:responseObject[@"page"]];
        NSArray *moreDatasArray = [NSArray yy_modelArrayWithClass:[PaySuccessItem class] json:responseObject[@"list"]];
        
        if (moreDatasArray.count > 0) {
            [weakSelf.dataSources addObjectsFromArray:moreDatasArray];
            [self createTableView];
            if (weakSelf.pageItem.page == weakSelf.pageItem.page_total) {
                [self noHasMoreData];
            } else {
                self.page = weakSelf.pageItem.page + 1;
            }
            
        }else {
            [self createEmptyView];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [self endRefesh:NO];
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
    
}

#pragma mark ------我的分润网络强求-------
- (void)shareBenefitRequest{
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostAllResultUrl:CashDistribute params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.responseObject = responseObject;
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[MyShareBenefitItem class] json:responseObject[@"result"]].mutableCopy;
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

#pragma mark ------重新加载-------
- (void)refreshAction {
    [self transactionRequest];
}

#pragma mark ------UITableViewDataSource,UITableViewDelegate-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Identifier";
    if (_type == ListType_Income) {
        IncomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"IncomeTableViewCell" owner:nil options:nil].lastObject;
        }
        
        if (_type == ListType_Income) {
            PaySuccessItem * item = [self.dataSources objectAtIndex:indexPath.row];
            [cell updateCell:item];
        }
        return cell;
    }else if (_type == ListType_MyCashDis) {
        MyShareBenefitCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"MyShareBenefitCell" owner:nil options:nil].lastObject;
        }
        MyShareBenefitItem * item = [self.dataSources objectAtIndex:indexPath.row];
        [cell updateWithdrawListCell:item];
        return cell;
    }else {
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_type == ListType_MyCashDis) {
        MyShareBenefitHeadView * view = [[NSBundle mainBundle]loadNibNamed:@"MyShareBenefitHeadView" owner:nil options:nil].firstObject;
        view.frame  = CGRectMake(0, 0, SCreenWidth, 30.f);
        NSString * s = [NSString stringWithFormat:@"%.2f",[self.responseObject[@"total_money"]doubleValue]];
        [view updateHeadView:self.responseObject[@"count"] amount:s];
        return view;
    }else {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (_type) {
        case ListType_Income:
            return 0.f;
            break;
        case ListType_MyCashDis:
            return 30.f;
        default:
            return 0.f;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_type) {
        case ListType_Income:
            return 60.f;
            break;
        case ListType_MyCashDis:
            return 125.5f;
        default:
            return 0.f;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView qmui_clearsSelection];
    if (_type == ListType_Income) {
        PaySuccessItem * item = [self.dataSources objectAtIndex:indexPath.row];
        PaySuccessVC *payVC= [[PaySuccessVC alloc]init];
        payVC.item = item;
        [self.navigationController pushViewController:payVC animated:YES];
    }
}



@end
