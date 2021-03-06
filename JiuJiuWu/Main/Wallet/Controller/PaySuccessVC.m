//
//  PaySuccessVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/29.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "PaySuccessVC.h"
#import "CustomTableViewCell.h"
#import "NSDate+Category.h"

@interface PaySuccessVC ()

@end

@implementation PaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.navigationItem.leftBarButtonItem = BLACKBAR_BUTTON;
    self.dataSources = @[@[@"商户名称:",@"商户编号:"],@[@"交易类型:",@"订单编号:"],@[@"商户电话:",@"日期时间:",@"交易金额:"]].mutableCopy;
    [self createTableView];
}
-(void)backAction:(id)sender {
    if (_isComeSuccess) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.inputTextField.enabled = NO;
    [cell updatePaySuccessCell:((NSArray *)self.dataSources[indexPath.section])[indexPath.row] textAlignment:NSTextAlignmentRight];
    [self inputContent:cell Row:indexPath];
    return cell;
}
- (void)inputContent:(CustomTableViewCell *)cell Row:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = [JJWLogin sharedMethod].loginData.merchant_name;
                break;
            case 1:
                cell.inputTextField.text = STRISEMPTY(_item.mer_no) ? [JJWLogin sharedMethod].loginData.user_id : _item.mer_no;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = [self checkPayType:_item.channel_flag];
                break;
            case 1:
                cell.inputTextField.text = STRISEMPTY(_item.orderNo) ? _item.order_no : _item.orderNo;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 2) {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:_item.reqTime.doubleValue];
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = [JJWLogin sharedMethod].loginData.mobile;
                break;
            case 1:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",[date toString]];
                break;
            case 2:
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f元",_item.amount.doubleValue/100];
                break;
            default:
                break;
        }
    }
}
- (NSString *)checkPayType:(NSString *)type {
    NSString * s = @"其他";
    if ([type isEqualToString:@"00"]) {
        s = @"微信";
    }else if ([type isEqualToString:@"01"]){
        s = @"支付宝";
    }
    return s;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSources[section]).count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = CommonBackgroudColor;
    view.frame = CGRectMake(0, 0, SCreenWidth, 25);
    return view;
}

//- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 80)];
//    view.backgroundColor = [UIColor clearColor];
//
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    btn.backgroundColor = themeColor;
//    btn.showsTouchWhenHighlighted = NO;
//    btn.layer.cornerRadius = 5;
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
//        if (block) {
//            block(x);
//        }
//    }];
//    btn.frame = CGRectMake(11, 25, SCreenWidth - 2 * 11, 41);
//    [view addSubview:btn];
//    return view;
//}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 11, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 11, 0, 0)];
    }
}















@end
