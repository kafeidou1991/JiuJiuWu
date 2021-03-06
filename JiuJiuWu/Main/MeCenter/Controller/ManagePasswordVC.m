//
//  ManagePasswordVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ManagePasswordVC.h"
#import "ChangePasswordVC.h"
#import "RegistVC.h"
#import "CLLockVC.h"

@interface ManagePasswordVC ()

@end

@implementation ManagePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码管理";
//    @"更改交易密码",@"忘记交易密码"
    self.dataSources = @[@"更改登录密码", @"设置手势密码",@"修改手势密码",@"删除手势密码"].mutableCopy;
    [self createTableView];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ChangePasswordVC * VC = [[ChangePasswordVC alloc]init];
        VC.type = ChangeLoginPasswordType;
        [self.navigationController pushViewController:VC animated:YES];
    }else if (indexPath.row == 1) {
        [self setPassword];
    }else if(indexPath.row == 2) {
        [self reSetPassword];
    }else if (indexPath.row == 3) {
        [self deletePassword];
    }
}

- (void)setPassword {
    //设置密码
    BOOL hasPwd = [CLLockVC hasPwd];
    if(hasPwd){
        [JJWBase alertMessage:@"您已经设置过密码，可以修改密码!" cb:nil];
    }else{
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            [JJWBase alertMessage:@"设置成功" cb:nil];
            [lockVC dismiss:0.0f];
        }];
    }
}

- (void)reSetPassword {
    //重置密码
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        [JJWBase alertMessage:@"您还没有设置密码，请先设置密码!" cb:nil];
    }else {
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
           [JJWBase alertMessage:@"重置成功" cb:nil];
            [lockVC dismiss:0.0f];
        }];
    }
}
- (void)deletePassword {
    //删除密码，先验证密码
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        [JJWBase alertMessage:@"您还没有设置密码，请先设置密码!" cb:nil];
    }else {
        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
//            NSLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            //验证通过
            [JJWBase alertMessage:@"删除成功" cb:nil];
            [lockVC clear];
            [lockVC dismiss:0.0f];
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, SCreenWidth, 10);
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = UIColorRGB(102, 102, 102);
    }
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 11, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 11, 0, 0)];
    }
}








@end
