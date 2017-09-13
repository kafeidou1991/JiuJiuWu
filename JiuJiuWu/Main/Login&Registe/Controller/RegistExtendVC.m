//
//  RegistExtendVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/13.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "RegistExtendVC.h"
#import "CustomTableViewCell.h"

@interface RegistExtendVC ()<UITextFieldDelegate>

@end

@implementation RegistExtendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册第二步";
    self.dataSources = @[@{@"title":@"真实姓名:",@"placeholder":@"请输入您的真实姓名"},
                         @{@"title":@"登录密码:",@"placeholder":@"登录密码由6-15位数字或字母组成"},
                         @{@"title":@"交易密码:",@"placeholder":@"交易密码由6位数组组成"},
                         @{@"title":@"推荐手机:",@"placeholder":@"请输入推荐人的手机号码"}].mutableCopy;
    [self createTableView];
    self.tableView.tableFooterView = [self _createFootView:@"注册" Block:^(UIButton * btn) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
    }
    cell.inputTextField.keyboardType = (indexPath.row == 0) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
    [cell updateRegistCell:self.dataSources[indexPath.row]];
    return cell;
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
    NSLog(@"%@",beString);
    return YES;
}














@end
