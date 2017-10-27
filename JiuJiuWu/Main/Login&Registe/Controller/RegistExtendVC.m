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
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"注 册" Block:^(UIButton * btn) {
        [weakSelf registAction];
    }];
}
//注册
- (void)registAction {
    CustomTableViewCell * cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString * name = [cell.inputTextField.text trimmWhiteSpace];
    if (STRISEMPTY(name)) {
        [JJWBase alertMessage:@"请输入您的真实姓名！" cb:nil];
        return;
    }
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString * password = [cell.inputTextField.text trimmWhiteSpace];
    if (STRISEMPTY(password) || password.length < 6 || ![password checkPassword]) {
        [JJWBase alertMessage:@"请输入正确的6-15位密码！" cb:nil];
        return;
    }
    
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString * payPassword = [cell.inputTextField.text trimmWhiteSpace];
    if (STRISEMPTY(payPassword) || payPassword.length != 6 || ![payPassword isPureInt]) {
        [JJWBase alertMessage:@"请输入正确的交易密码！" cb:nil];
        return;
    }
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString * inviteMobile = [cell.inputTextField.text trimmWhiteSpace];
    if (STRISEMPTY(inviteMobile) || ![inviteMobile checkPhoneNumInput]) {
        [JJWBase alertMessage:@"请输入正确的推荐人手机号！" cb:nil];
        return;
    }
    if (STRISEMPTY(_mobile) || ![_mobile checkPhoneNumInput]) {
        [JJWBase alertMessage:@"手机号错误，请退出重新注册！" cb:nil];
        return;
    }
    
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"username":name,@"mobile":_mobile,@"password":password,@"paypwd":payPassword,@"invite":inviteMobile};
    WeakSelf
    
    [JJWNetworkingTool PostWithUrl:RegistUser params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"注册成功！" cb:nil];
        DloginData * data = [DloginData yy_modelWithDictionary:responseObject];
        [[JJWLogin sharedMethod]saveLoginData:data];
        //注册成功之后跳转登录页面
        [self.navigationController popToRootViewControllerAnimated:YES];
        //        for (UIViewController * popVC in self.navigationController.viewControllers) {
        //            if ([popVC isKindOfClass:[LoginVC class]]) {
        //                [popVC dismissViewControllerAnimated:YES completion:nil];
        //            }
        //        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
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
    cell.inputTextField.tag = indexPath.row + 100;
    [cell updateRegistCell:self.dataSources[indexPath.row]];
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.inputTextField.secureTextEntry =YES;
    }else {
        cell.inputTextField.secureTextEntry =NO;
    }
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
