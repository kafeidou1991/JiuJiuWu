//
//  CompanyInfoVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/20.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "CompanyInfoVC.h"
#import "CustomTableViewCell.h"

@interface CompanyInfoVC ()<UITextFieldDelegate>

@end

@implementation CompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定企业商户信息";
    self.dataSources = @[@{@"title":@"企业名称:",@"placeholder":@"请输入企业名称"},
                         @{@"title":@"法人姓名:",@"placeholder":@"请输入法人姓名"},
                         @{@"title":@"营业执照号:",@"placeholder":@"请输入营业执照号"},
                         @{@"title":@"组织结构号:",@"placeholder":@"请输入组织结构号"},
                         @{@"title":@"税务登记证号:",@"placeholder":@"请输入税务登记证号"}].mutableCopy;
    [self createTableView];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提 交" Block:^(UIButton * btn) {
        [weakSelf nextAction];
    }];
}
//提交
- (void)nextAction {

}
#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
    }
    cell.inputTextField.keyboardType = (indexPath.row == 0 || indexPath.row == 1) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
    cell.inputTextField.tag = indexPath.row + 100;
    [cell updateBindCardCell:self.dataSources[indexPath.row] textAlignment:NSTextAlignmentRight];
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.inputTextField.secureTextEntry =YES;
    }else {
        cell.inputTextField.secureTextEntry =NO;
    }
    return cell;
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
    UILabel * label = [JJWBase createLabel:CGRectMake(5, 0, SCreenWidth- 10, 25) font:[UIFont systemFontOfSize:14] text:@"企业信息" defaultSizeTxt:@"" color:MainTextColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [view addSubview:label];
    return view;
}


- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 100)];
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
    btn.frame = CGRectMake(11, 59, SCreenWidth - 2 * 11, 41);
    [view addSubview:btn];
    return view;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 11, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 11, 0, 0)];
    }
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * beString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 101) {
        if (beString.length > 15) {
            return NO;
        }
    }else if (textField.tag == 102) {
        if (beString.length > 6) {
            return NO;
        }
    }
    else if (textField.tag == 103) {
        if (beString.length > 11) {
            return NO;
        }
    }
    return YES;
}








@end
