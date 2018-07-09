//
//  BindStudentInfoVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/6.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "BindStudentInfoVC.h"
#import "CustomTableViewCell.h"
#import "StudentInfoItem.h"



@interface BindStudentInfoVC ()<UITextFieldDelegate>

@property (nonatomic, strong) StudentInfoItem * currCardItem;
@end

@implementation BindStudentInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定大学生信息";
    self.currCardItem = [StudentInfoItem new];
    self.dataSources = @[@{@"title":@"学生名称",@"placeholder":@"请输入学生名称"},
                         @{@"title":@"手机号",@"placeholder":@"请输入手机号"},
                         @{@"title":@"大学名称",@"placeholder":@"请输入大学名称"},
                         @{@"title":@"专业名称",@"placeholder":@"专业名称"},
                         @{@"title":@"班级",@"placeholder":@"请输入班级"},
                         @{@"title":@"学号",@"placeholder":@"请输入学号"}].mutableCopy;
    [self createTableView];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提 交" Block:^(UIButton * btn) {
        [weakSelf nextAction];
    }];
}
//提交
- (void)nextAction {
    if (STRISEMPTY(_currCardItem.name)) {
        [JJWBase alertMessage:@"请输入学生名称!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.mobile)) {
        [JJWBase alertMessage:@"请输入手机号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.schoolName)) {
        [JJWBase alertMessage:@"请输入大学名称!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.majorName)) {
        [JJWBase alertMessage:@"请输入专业名称!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.className)) {
        [JJWBase alertMessage:@"请输入班级!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.studentNumber)) {
        [JJWBase alertMessage:@"请输入学号!" cb:nil];
        return;
    }
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSMutableDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,
                                   @"student_name":_currCardItem.name,
                                   @"mobile":_currCardItem.mobile,
                                   @"school":_currCardItem.schoolName,
                                   @"specialty":_currCardItem.majorName,
                                   @"class":_currCardItem.className,
                                   @"number":_currCardItem.studentNumber
                                   }.mutableCopy;
    [JJWNetworkingTool PostWithUrl:BindStudent params:dict.copy isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"绑定成功!" cb:nil];
        //更新本地数据
        [self saveUpdateDate:responseObject];
    
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void)saveUpdateDate:(id)result {
//    self.currCardItem.biz_tax = [result objectForKey:@"biz_tax"];
//    self.currCardItem.license_img = [result objectForKey:@"license_img"];
//    self.currCardItem.gszc_name = [result objectForKey:@"gszc_name"];
//    self.currCardItem.biz_license = [result objectForKey:@"biz_license"];
//    self.currCardItem.merchant_name = [result objectForKey:@"merchant_name"];
//    self.currCardItem.biz_org = [result objectForKey:@"biz_org"];
//    self.currCardItem.legal_person = [result objectForKey:@"legal_person"];
}
#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.inputTextField.keyboardType = (indexPath.row == 1 || indexPath.row == 5) ? UIKeyboardTypePhonePad : UIKeyboardTypeDefault;
    cell.inputTextField.tag = indexPath.row + 100;
    [cell updateBindCardCell:self.dataSources[indexPath.row] textAlignment:NSTextAlignmentRight];
    [self inputContent:cell Row:indexPath];
    return cell;
}
- (void)inputContent:(CustomTableViewCell *)cell Row:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            cell.inputTextField.text = _currCardItem.name;
            break;
        case 1:
            cell.inputTextField.text = _currCardItem.mobile;
            break;
        case 2:
            cell.inputTextField.text = _currCardItem.schoolName;
            break;
        case 3:
            cell.inputTextField.text = _currCardItem.majorName;
            break;
        case 4:
            cell.inputTextField.text = _currCardItem.className;
            break;
        case 5:
            cell.inputTextField.text = _currCardItem.studentNumber;
            break;
        default:
            break;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 80)];
    view.backgroundColor = [UIColor clearColor];
    
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
    btn.frame = CGRectMake(11, 25, SCreenWidth - 2 * 11, 41);
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
    if (textField.tag == 100) {
        _currCardItem.name = beString;
    }else if (textField.tag == 101) {
        _currCardItem.mobile = beString;
    }else if (textField.tag == 102) {
        _currCardItem.schoolName = beString;
    }else if (textField.tag == 103) {
        _currCardItem.majorName = beString;
    }else if (textField.tag == 104) {
        _currCardItem.className = beString;
    }else if (textField.tag == 105) {
        _currCardItem.studentNumber = beString;
    }
    return YES;
}

@end
