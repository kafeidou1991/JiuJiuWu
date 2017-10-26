//
//  BalanceViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/5/17.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "BalanceVC.h"
#import "WithdrawVC.h"

@interface BalanceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (nonatomic, copy) NSString * userMoney; //余额

@end

@implementation BalanceVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包余额";
    self.view.backgroundColor = themeColor;
    
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
        [weakSelf hudclose];
        weakSelf.userMoney = [responseObject objectForKey:@"user_money"];
        weakSelf.balanceLabel.text = [NSString stringWithFormat:@"%.2f",weakSelf.userMoney.doubleValue];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"提现";
        cell.imageView.image = [UIImage imageNamed:@"tixian"];
    }else{
        cell.textLabel.text = @"充值";
        cell.imageView.image = [UIImage imageNamed:@"chongzhi"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawVC * VC = [[WithdrawVC alloc]init];
    VC.userMoney = self.userMoney;
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
