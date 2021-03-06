//
//  ChangePasswordVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/19.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "CustomTableViewCell.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = (_type == ChangeLoginPasswordType)? @"更改登录密码" : @"更改交易密码";
    
    self.dataSources = (_type == ChangeLoginPasswordType)?
    @[@{@"title":@"当前密码:",@"placeholder":@"请输入当前密码"},
      @{@"title":@"登录密码:",@"placeholder":@"请输入新的登录密码"},
      @{@"title":@"确认密码:",@"placeholder":@"请确认新的登录密码"}].mutableCopy :
    @[@{@"title":@"当前交易密码:",@"placeholder":@"输入当前交易密码"},
      @{@"title":@"更改交易密码:",@"placeholder":@"请输入新的交易密码"},
      @{@"title":@"确认交易密码:",@"placeholder":@"请确认新的交易密码"}].mutableCopy;
    
    [self createTableView];
    
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"确认更改" Block:^(UIButton * btn) {
        [weakSelf changeAction];
    }];
    
}
- (void)changeAction {
    [self.view endEditing:YES];
    CustomTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString * old_password = cell.inputTextField.text;
    if (STRISEMPTY(old_password)) {
        [JJWBase alertMessage:@"请输入旧密码!" cb:nil];
        return;
    }
    
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString * new_password = cell.inputTextField.text;
    if (STRISEMPTY(new_password)) {
        [JJWBase alertMessage:@"请输入新密码!" cb:nil];
        return;
    }
    
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString * confirm_password = cell.inputTextField.text;
    if (STRISEMPTY(confirm_password)) {
        [JJWBase alertMessage:@"请输入确认密码!" cb:nil];
        return;
    }
    if (![new_password isEqualToString:confirm_password]) {
        [JJWBase alertMessage:@"确认密码不一致！" cb:nil];
        return;
    }
    
    
    if (_type == ChangeLoginPasswordType) {
        [self hudShow:self.view msg:STTR_ater_on];
        NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,
//                                TPSHOP
                                @"old_password":[NSString md5Digest:[NSString stringWithFormat:@"%@",old_password]].lowercaseString,
                                @"new_password":[NSString md5Digest:[NSString stringWithFormat:@"%@",new_password]].lowercaseString,
                                @"confirm_password":[NSString md5Digest:[NSString stringWithFormat:@"%@",confirm_password]].lowercaseString,
                                @"token":[JJWLogin sharedMethod].loginData.token};
        WeakSelf
        [JJWNetworkingTool PostWithUrl:ChangePassword params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf hudclose];
            [JJWBase alertMessage:@"修改成功!" cb:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSError *error, id chaceResponseObject) {
            [weakSelf hudclose];
            [JJWBase alertMessage:error.domain cb:nil];
        }];
    }
}


#pragma mark - tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
    }
    cell.inputTextField.keyboardType = (_type == ChangeLoginPasswordType) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
    cell.inputTextField.tag = indexPath.row + 100;
    [cell updateRegistCell:self.dataSources[indexPath.row]];
    cell.inputTextField.secureTextEntry =YES;
    return cell;
}

- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 150)];
    view.backgroundColor = [UIColor clearColor];
    CGFloat leftMarge = 11.f;
    UILabel * tipLabel = [JJWBase createLabel:CGRectMake(leftMarge, 2 * leftMarge , SCreenWidth - 2 * leftMarge, 21) font:[UIFont systemFontOfSize:13] text:(_type == ChangeLoginPasswordType) ? @"登录密码由6-15字母或数字组合" : @"交易密码由6位数字组成" defaultSizeTxt:nil color:DesTextColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [view addSubview:tipLabel];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = JJWThemeColor;
    btn.showsTouchWhenHighlighted = NO;
    btn.layer.cornerRadius = 5;
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIButton * _Nullable x) {
        if (block) {
            block(x);
        }
    }];
    btn.frame = CGRectMake(leftMarge, 109, SCreenWidth - 2 * leftMarge, 41);
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
    NSUInteger maxLength = (_type == ChangeLoginPasswordType) ? 15 : 6;
    if (beString.length > maxLength) {
        return NO;
    }
    return YES;
}















@end
