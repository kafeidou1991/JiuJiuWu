//
//  CompanyInfoVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/20.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "CompanyInfoVC.h"
#import "CustomTableViewCell.h"
#import "CompanyInfoCell.h"
#import "ZLPhotoActionSheet.h"
#import "BankCardItem.h"

@interface CompanyInfoVC ()<UITextFieldDelegate>

@property (nonatomic, strong) BankCardItem * currCardItem;

@end

@implementation CompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定企业商户信息";
    [self.currCardItem setEmptyItem];
    self.dataSources = @[@[@{@"title":@"商户名称:",@"placeholder":@"请输入商户名称"},
                         @{@"title":@"工商注册名称:",@"placeholder":@"请输入营业执照注册名称"},
                         @{@"title":@"法人姓名:",@"placeholder":@"请输入法人姓名"},
                         @{@"title":@"营业执照号:",@"placeholder":@"请输入营业执照号"},
                         @{@"title":@"组织结构号:",@"placeholder":@"请输入组织结构号"},
                         @{@"title":@"税务登记证号:",@"placeholder":@"请输入税务登记证号"}],
                         @[@{@"title":@"占位符",@"placeholder":@"占位符"}]].mutableCopy;
    [self createTableView];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提 交" Block:^(UIButton * btn) {
        [weakSelf nextAction];
    }];
}
//提交
- (void)nextAction {
    //merchant_name    string    否    商户名称
    //gszc_name    string    否    工商注册名称
    //biz_license    string    否    营业执照
    //biz_org    string    否    组织机构代码
    //biz_tax    string    否    纳税人识别号
    //user_id    string    是    用户ID
    //license_img    string    否    营业执照照片
    //shop_head_img    string    否    店铺门面照片
    //token
}
#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    static NSString * secondCellId = @"secondCellId";
    if (indexPath.section == 0) {
        CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
        }
        cell.inputTextField.keyboardType = (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
        cell.inputTextField.tag = indexPath.row + 100;
        [cell updateBindCardCell:((NSArray *)self.dataSources[indexPath.section])[indexPath.row] textAlignment:NSTextAlignmentRight];
        [self inputContent:cell Row:indexPath];
        return cell;
    }else {
        CompanyInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"CompanyInfoCell" owner:self options:nil].firstObject;
        }
        WeakSelf
        cell.block = ^(UIButton *sender) {
            [weakSelf openPhotoCameraAction:sender];
        };
        [cell updateCell:_currCardItem];
        return cell;
    }
}
- (void)inputContent:(CustomTableViewCell *)cell Row:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            cell.inputTextField.text = _currCardItem.merchant_name;
            break;
        case 1:
            cell.inputTextField.text = _currCardItem.gszc_name;
            break;
        case 2:
        cell.inputTextField.text = _currCardItem.legal_person;
        break;
        case 3:
            cell.inputTextField.text = _currCardItem.biz_license;
            break;
        case 4:
            cell.inputTextField.text = _currCardItem.biz_org;
            break;
        case 5:
            cell.inputTextField.text = _currCardItem.biz_tax;
            break;
        default:
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSources[section]).count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 50.f : 300;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = CommonBackgroudColor;
    view.frame = CGRectMake(0, 0, SCreenWidth, 25);
    UILabel * label = [JJWBase createLabel:CGRectMake(5, 0, SCreenWidth- 10, 25) font:[UIFont systemFontOfSize:14] text:section == 0 ? @"企业信息" :@"商户照片" defaultSizeTxt:@"" color:MainTextColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [view addSubview:label];
    return view;
}

- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 80)];
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
#pragma mark - 照片选择
- (void)openPhotoCameraAction:(UIButton *)sender {
    [self.view endEditing:YES];
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
        if (sender.tag == 0) {
            _currCardItem.license_img = image;
        }else if (sender.tag == 1){
            _currCardItem.shop_head_img = image;
        }
    };
}
#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * beString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 100) {
        _currCardItem.merchant_name = beString;
    }else if (textField.tag == 101) {
        _currCardItem.gszc_name = beString;
    }else if (textField.tag == 102) {
        _currCardItem.legal_person = beString;
    }else if (textField.tag == 103) {
        _currCardItem.biz_license = beString;
    }else if (textField.tag == 104) {
        _currCardItem.biz_org = beString;
    }else if (textField.tag == 105) {
        _currCardItem.biz_tax = beString;
    }
    return YES;
}


-(BankCardItem *)currCardItem {
    if (!_currCardItem) {
        _currCardItem = [[BankCardItem alloc]init];
    }
    return _currCardItem;
}






@end
