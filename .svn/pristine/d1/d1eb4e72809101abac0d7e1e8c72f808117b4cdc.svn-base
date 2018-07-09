//
//  JJWMyCreditCardController.m
//  JiuJiuWu
//
//  Created by 付志敏 on 18/1/11.
//  Copyright © 2018年 张竟巍. All rights reserved.
//

#import "FZMMyCreditCardController.h"
#import "FZMMyCreditCardModel.h"
#import "FZMWalletCreditCardCell.h"

#import "MyRateVC.h"
#import "FZMBindCreditCardController.h"

@interface FZMMyCreditCardController ()

@end

@implementation FZMMyCreditCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configNavigation{
    self.title = @"我的信用卡";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCreditCardAction)];
}

- (void)afterProFun {
    
    [self loadData];
}

- (void)loadData{
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:MyCreditCard params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[FZMMyCreditCardModel class] json:responseObject].mutableCopy;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FZMWalletCreditCardCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FZMWalletCreditCardCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([FZMWalletCreditCardCell class]) owner:nil options:nil].firstObject;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row < self.dataSources.count) {
        [cell configParameter:self.dataSources[indexPath.row]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JJWCommonHelper fzm_tableViewHeight:tableView];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView qmui_clearsSelection];
    
    MyRateVC * VC = [[MyRateVC alloc]init];
    VC.isQuickPay = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark ------Action-------

- (void)addCreditCardAction{
    FZMBindCreditCardController *addVC = [[FZMBindCreditCardController alloc] init];
    
    WeakSelf
    [addVC setRefeshCreditCardListBlok:^(){
        [weakSelf loadData];
    }];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)refreshAction{
    [self loadData];
}

@end
