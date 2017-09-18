
//
//  ManageCardVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/18.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ManageCardVC.h"
#import "CustomTableViewCell.h"
#import "ManageCardCell.h"
#import "ZLPhotoActionSheet.h"

static CGFloat secondHeight = 300.f;

@interface ManageCardVC ()

@property (nonatomic, strong) NSMutableArray * imagesArray;

@end

@implementation ManageCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定收款银行卡";
    self.dataSources = @[@[@{@"title":@"结算银行:",@"placeholder":@"选择结算银行"},
                           @{@"title":@"结算户主:",@"placeholder":@"请输入户主姓名"},
                           @{@"title":@"结算卡号:",@"placeholder":@"请输入结算卡号"},
                           @{@"title":@"身份证号:",@"placeholder":@"请输入身份证号"}],
                         
                         @[@{@"title":@"占位符",@"placeholder":@"占位符"}]].mutableCopy;
    self.imagesArray = @[@"",@"",@""].mutableCopy;
    [self createGroupTableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提交实名" Block:^(UIButton * btn) {
        [weakSelf checkBankInfo];
    }];
    
}
//上传银行卡信息
- (void)checkBankInfo {
    
    NSLog(@"%@",_imagesArray[0]);
    NSLog(@"%@",_imagesArray[1]);
    NSLog(@"%@",_imagesArray[2]);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    static NSString * secondCellId = @"secondCellId";
    if (indexPath.section == 0) {
        CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accessoryType = (indexPath.row == 0) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        cell.inputTextField.keyboardType = (indexPath.row == 0 || indexPath.row == 1) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
        cell.inputTextField.enabled = !(indexPath.row == 0);
        cell.inputTextField.tag = indexPath.row + 100;
        [cell updateBindCardCell:((NSArray *)self.dataSources[indexPath.section])[indexPath.row]];
        return cell;
    }else {
        ManageCardCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ManageCardCell" owner:self options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        WeakSelf
        cell.block = ^(UIButton *sender) {
            [weakSelf openPhotoCameraAction:sender];
        };
        return cell;
    }
}
- (void)openPhotoCameraAction:(UIButton *)sender {
    ZLPhotoActionSheet * actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.maxSelectCount = 1;
    //设置照片最大预览数
    actionSheet.maxPreviewCount = 20;
    actionSheet.allowSelectVideo = NO;
    actionSheet.allowSelectGif = NO;
    actionSheet.allowSelectImage = YES;
    [actionSheet showPreviewAnimated:YES sender:self];
    
    actionSheet.selectImageBlock = ^(NSArray<UIImage *> * _Nonnull imageArray, NSArray<PHAsset *> * _Nonnull imageSet, BOOL is) {
        UIImage *image = imageArray[0];
        [sender setImage:image forState:UIControlStateNormal];
        [sender setImage:image forState:UIControlStateHighlighted];
        [sender setImage:image forState:UIControlStateSelected];
        _imagesArray[sender.tag] = image;
    };
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSources[section]).count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? 46.f : secondHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == 0) ? 0.00001 : 15.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = CommonBackgroudColor;
    view.frame = CGRectMake(0, 0, SCreenWidth, 15);
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [UIView new];
    if (section == 0) {
        return view;
    }
    view.backgroundColor = CommonBackgroudColor;
    view.frame = CGRectMake(0, 0, SCreenWidth, 15);
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
    if (textField.tag == 103) {
        if (beString.length > 18) {
            return NO;
        }
    }
    return YES;
}

- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 70)];
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
    btn.frame = CGRectMake(8, 20, SCreenWidth - 2 * 8, 40);
    [view addSubview:btn];
    return view;
}



@end
