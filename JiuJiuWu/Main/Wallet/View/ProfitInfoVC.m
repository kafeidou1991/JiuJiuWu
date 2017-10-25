//
//  ProfitInfoViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/6/8.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "ProfitInfoVC.h"
#import "GeneralTableViewCell.h"
#import "NSDate+Category.h"

@interface ProfitInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)cancelAction:(id)sender;
@property (nonatomic, strong) PaySuccessItem *item;
@end

@implementation ProfitInfoVC

-(instancetype)initWith:(PaySuccessItem *)item{
    if (self = [super init]) {
        self.item = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds =YES;
    self.view.layer.cornerRadius = 5.f;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"myCellId";
    GeneralTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GeneralTableViewCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text =@"";
        cell.destailLabel.text =@"";
    }else if (indexPath.row == 1){
        cell.titleLabel.text =@"时   间：";
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:self.item.add_time.doubleValue];
        cell.destailLabel.text = [date toString];
    }else if (indexPath.row == 2){
        cell.titleLabel.text =@"订单编号：";
        cell.destailLabel.text = self.item.order_no;
    }else if (indexPath.row == 3){
        cell.titleLabel.text =@"收款金额：";
        cell.destailLabel.text = [NSString stringWithFormat:@"￥%.2f",self.item.amount.doubleValue/100];;
    }else if (indexPath.row == 4){
        cell.titleLabel.text =@"收款商户：";
        cell.destailLabel.text = self.item.member_name;
    }else if (indexPath.row == 5){
        cell.titleLabel.text =@"分润金额：";
        cell.destailLabel.text = self.item.amount;
    }else if (indexPath.row == 6){
        cell.titleLabel.text =@"";
        cell.destailLabel.text =@"";
    }
    return cell;
}

- (IBAction)cancelAction:(id)sender {
    if (_block) {
        _block();
    }
}
@end
