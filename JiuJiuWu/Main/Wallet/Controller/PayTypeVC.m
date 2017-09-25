//
//  PresentPayTypeVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/25.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "PayTypeVC.h"

@interface PayTypeVC ()
@property (nonatomic, strong) UIButton * lastBtn;
@end

@implementation PayTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCreenWidth - 50, 70 * 3 + 60);
    self.view.backgroundColor = [UIColor clearColor];
    self.dataSources = @[@"1",@"2",@"3"].mutableCopy;
    [self createTableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.layer.cornerRadius = 5.f;
    self.tableView.tableFooterView = [self _createFootView:@"提   交" Block:^(UIButton * btn) {
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.textLabel.textColor = MainTextColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = DesTextColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    [self updateCell:cell IndexPath:indexPath];
    cell.accessoryView = [self _createAccessoryView:indexPath];
    return cell;
}
- (void)updateCell:(UITableViewCell *)cell IndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"payType_card"];
        cell.textLabel.text = @"银行卡支付";
        cell.detailTextLabel.text = @"安全支付，无需开通网银";
    }else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"payType_weixin"];
        cell.textLabel.text = @"微信支付";
        cell.detailTextLabel.text = @"推荐安装5.0以上的版本的用户使用";
    }else {
        cell.imageView.image = [UIImage imageNamed:@"payType_alipay"];
        cell.textLabel.text = @"支付宝支付";
        cell.detailTextLabel.text = @"推荐有支付宝账户的用户使用";
    }
}
- (UIButton *)_createAccessoryView:(NSIndexPath *)indexPath {
    UIButton * btn = [JJWBase createButton:CGRectMake(0, 0, 50, 50) type:UIButtonTypeCustom title:@""];
    [btn setImage:[UIImage imageNamed:@"regista_protocol"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"regista_protocol_select"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"regista_protocol_select"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = indexPath.row;
    return btn;
}
- (void)btnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"%ld",sender.tag);
    if (self.lastBtn) {
        self.lastBtn.selected = !self.lastBtn.selected;
    }
    self.lastBtn = sender;
}
- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.tableView.width, 60)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = themeColor;
    btn.showsTouchWhenHighlighted = NO;
    btn.layer.cornerRadius = 5;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
        if (block) {
            block(x);
        }
    }];
    btn.frame = CGRectMake(8, 10, view.width - 2 * 8, 40);
    [view addSubview:btn];
    return view;
}


@end
