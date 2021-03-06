//
//  BalanceViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/5/17.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "BalanceVC.h"
#import "WithdrawVC.h"
#import "FZMMyAccountModel.h"

#import "FZMMyAccountWithdrawController.h"

@interface BalanceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (nonatomic, copy) NSString * userMoney; //余额

@property (nonatomic, strong) FZMMyAccountModel *accountModel;


@end

@implementation BalanceVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包余额";
    self.view.backgroundColor = JJWThemeColor;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(withdrawSuccessAction) name:@"WithdrawSuccess" object:nil];
    self.tableView.tableFooterView = [UIView new];
    
}
- (void)withdrawSuccessAction{
    [self afterProFun];
}
-(void)afterProFun{
    //请求接口 余额
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,@"user_id":[JJWLogin sharedMethod].loginData.user_id};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:GetUserMoney params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        _accountModel = [FZMMyAccountModel yy_modelWithJSON:responseObject];
        [weakSelf hudclose];
        weakSelf.userMoney = [responseObject objectForKey:@"user_money"];
        weakSelf.balanceLabel.text = [NSString stringWithFormat:@"%.2f",weakSelf.userMoney.doubleValue];
        
        [self.tableView reloadData];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"提现";
//        cell.imageView.image = [UIImage imageNamed:@"tixian"];
//    }else{
//        cell.textLabel.text = @"充值";
//        cell.imageView.image = [UIImage imageNamed:@"chongzhi"];
//    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"提现";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 1){
        cell.textLabel.text = @"总收入";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",_accountModel.total_money];
    } else if (indexPath.row == 2){
        cell.textLabel.text = @"今日收入";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",_accountModel.today_money];
    } else {
        cell.textLabel.text = @"提现记录";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        WithdrawVC * VC = [[WithdrawVC alloc]init];
        VC.userMoney = self.userMoney;
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 3){
        FZMMyAccountWithdrawController *withdrawVC = [[FZMMyAccountWithdrawController alloc] init];
        [self.navigationController pushViewController:withdrawVC animated:YES];
    }
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
