//
//  SelectBandViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/2.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "SelectBandVC.h"

@interface SelectBandVC ()

@end

@implementation SelectBandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dataSources.count == 0) {
        self.dataSources  = @[@"请选择开户行",@"中国农业银行"].mutableCopy;
    }
    [self createTableView];
    CGFloat height = 100;
    height = MIN(MAX(100, self.dataSources.count * 50.f), 300);
    self.view.frame = CGRectMake(40,(SCreenHegiht - height)/2, SCreenWidth - 80, height);
    self.tableView.frame = self.view.bounds;
    self.tableView.layer.cornerRadius = 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.textColor = themeColor;
        cell.textLabel.textAlignment =  NSTextAlignmentCenter;
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment =  NSTextAlignmentLeft;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    
    if (indexPath.row == 1) {
        if (_block) {
            _block();
        }
    }
    
    if (_selectBlock) {
        _selectBlock(indexPath.row);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}

@end
