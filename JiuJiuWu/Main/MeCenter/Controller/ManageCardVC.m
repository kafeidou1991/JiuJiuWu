
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
#import "SelectBandVC.h"
#import "UIViewController+MJPopupViewController.h"
#import "BankCardItem.h"
#import "HZAreaPickerView.h"
#import "PubilcBankCardCell.h"
#import "CompanyInfoVC.h"

static CGFloat thirdHeight = 600.f;

@interface ManageCardVC ()<UITextFieldDelegate,HZAreaPickerDelegate>{
    SelectBandVC * selectBandVC;
}
@property (nonatomic, strong) BankCardItem * currCardItem;

@end

@implementation ManageCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = (_type == BindRegisterCardType) ? @"绑定收款银行卡" : @"实名认证信息";
    [self initData];
    [self createGroupTableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提交实名" Block:^(UIButton * btn) {
        [weakSelf checkBankInfo];
    }];
    
}
- (void)initData {
    self.dataSources = @[@[@{@"title":@"结算银行",@"placeholder":@"选择结算银行"},
                           @{@"title":@"结算户主",@"placeholder":@"请输入户主姓名"},
                           @{@"title":@"对公账号",@"placeholder":@"请输入对公银行行号"},
                           @{@"title":@"结算卡号",@"placeholder":@"请输入结算卡号"},
                           @{@"title":@"身份证号",@"placeholder":@"请输入身份证号"},
                           @{@"title":@"预留手机号",@"placeholder":@"请输入银行预留手机号"}],
                         
                         @[@{@"title":@"省",@"placeholder":@"选择商户所在省"},
                           @{@"title":@"市",@"placeholder":@"选择商户所在市"},
                           @{@"title":@"区/县",@"placeholder":@"选择商户所在区/县"},
                           @{@"title":@"详细地址",@"placeholder":@"请输入商户详细地址"}],
                         
                         @[@{@"title":@"占位符",@"placeholder":@"占位符"}]].mutableCopy;
    
    [self.currCardItem setEmptyItem];
}
#pragma mark - 上传银行卡信息
- (void)checkBankInfo {
    if (STRISEMPTY(_currCardItem.bank_name)) {
        [JJWBase alertMessage:@"请选择结算银行!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.account_name)) {
        [JJWBase alertMessage:@"输入户主姓名!" cb:nil];
        return;
    }
    if (_currCardItem.account_type.integerValue == 2 && STRISEMPTY(_currCardItem.open_branch)) {
        [JJWBase alertMessage:@"请输入对公银行行号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.account)) {
        [JJWBase alertMessage:@"请输入结算卡号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.account_mobile)) {
        [JJWBase alertMessage:@"请输入银行预留手机号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.idcard_number)) {
        [JJWBase alertMessage:@"请输入身份证号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.province) ||STRISEMPTY(_currCardItem.city) ||STRISEMPTY(_currCardItem.district)) {
        [JJWBase alertMessage:@"请选择银行卡开户地!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.address_detail)) {
        [JJWBase alertMessage:@"请输入商户详细地址!" cb:nil];
        return;
    }
    if (_currCardItem.idcard_img_one.size.width == 0 || _currCardItem.idcard_img_two.size.width == 0 || _currCardItem.idcard_img_three.size.width == 0 ||_currCardItem.shop_head_img.size.width == 0 ||_currCardItem.shop_inner_img.size.width == 0 ||_currCardItem.shop_cash_img.size.width == 0) {
        [JJWBase alertMessage:@"请完善图片认证信息!" cb:nil];
        return;
    }
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSMutableDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,
                            @"token":[JJWLogin sharedMethod].loginData.token,
                            @"idcard_number":_currCardItem.idcard_number,
                            @"account":_currCardItem.account,
                            @"account_name":_currCardItem.account_name,
                            @"idcard_img_one":[self base64Str:_currCardItem.idcard_img_one],
                            @"idcard_img_two":[self base64Str:_currCardItem.idcard_img_two],
                            @"idcard_img_three":[self base64Str:_currCardItem.idcard_img_three],
                            @"shop_head_img":[self base64Str:_currCardItem.shop_head_img],
                            @"shop_inner_img":[self base64Str:_currCardItem.shop_inner_img],
                            @"shop_cash_img":[self base64Str:_currCardItem.shop_cash_img],
                            @"province":_currCardItem.province,
                            @"city":_currCardItem.city,
                            @"district":_currCardItem.district,
                            @"account_mobile":_currCardItem.account_mobile,
                            @"bank_code":_currCardItem.bank_code,
                            @"address_detail":_currCardItem.address_detail,
                            @"account_type":_currCardItem.account_type}.mutableCopy;
    if (_currCardItem.account_type.integerValue == 2) {
        [dict setObject:_currCardItem.open_branch forKey:@"open_branch"];
    }
    [JJWNetworkingTool PostWithUrl:UpdateBankInfo params:dict.copy isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"绑定成功!" cb:nil];
        DloginData * login = [JJWLogin sharedMethod].loginData;
        if (_currCardItem.account.integerValue == 2) {
            //进入审核状态
            login.merchant_checked = @"1";
        }else {
            login.realname_checked = @"1";
        }
        [[JJWLogin sharedMethod]saveLoginData:login];
        
        if (_type == BindChangeCardType) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else {
            [self jxt_showAlertWithTitle:@"温馨提示" message:@"企业用户请完善企业信息!" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.addActionCancelTitle(@"取消");
                alertMaker.addActionDefaultTitle(@"前往");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                if (buttonIndex == 1) {
                    CompanyInfoVC * VC = [[CompanyInfoVC alloc]init];
                    VC.type = _type;
                    [weakSelf.navigationController pushViewController:VC animated:YES];
                }else {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (NSString *) base64Str:(UIImage *)image {
    NSData * data = UIImageJPEGRepresentation(image, 0.0);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    static NSString * firstCellId = @"firstCellId";
    static NSString * secondCellId = @"secondCellId";
    static NSString * thirdCellId = @"thirdCellId";
    if (indexPath.section == 0) {
        if (indexPath.row != 2) {
            CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = (indexPath.row == 0) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
            cell.inputTextField.keyboardType = (indexPath.row == 0 || indexPath.row == 1) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
            cell.inputTextField.enabled = !(indexPath.row == 0);
            cell.inputTextField.tag = indexPath.row + 100;
            cell.inputTextField.delegate = self;
            [cell updateBindCardCell:((NSArray *)self.dataSources[indexPath.section])[indexPath.row]textAlignment:NSTextAlignmentRight];
            [self inputContent:cell Row:indexPath];
            return cell;
        }else {
            PubilcBankCardCell * cell = [tableView dequeueReusableCellWithIdentifier:firstCellId];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"PubilcBankCardCell" owner:self options:nil].firstObject;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.inputTextField.tag = indexPath.row + 1000;
            cell.inputTextField.delegate = self;
            [cell updateBindCardCell:((NSArray *)self.dataSources[indexPath.section])[indexPath.row]textAlignment:NSTextAlignmentRight];
            cell.inputTextField.text = _currCardItem.open_branch;
            cell.selectBtn.selected = cell.inputTextField.enabled =  (_currCardItem.account_type.integerValue == 2);
            __block BankCardItem * weakItem = _currCardItem;
            cell.block = ^(UIButton *sender) {
                if (sender.selected) {
                    weakItem.account_type = @"2";
                }else {
                    weakItem.account_type = @"1";
                }
            };
            return cell;
        }
    }else if (indexPath.section == 1) {
        CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.accessoryType = (indexPath.row == 3) ? UITableViewCellAccessoryNone: UITableViewCellAccessoryDisclosureIndicator;
        cell.inputTextField.enabled = (indexPath.row == 3);
        cell.inputTextField.tag = indexPath.row + 200;
        cell.inputTextField.delegate = self;
        [cell updateBindCardCell:((NSArray *)self.dataSources[indexPath.section])[indexPath.row]textAlignment:(indexPath.row == 3) ? NSTextAlignmentRight : NSTextAlignmentCenter];
        [self inputContent:cell Row:indexPath];
        return cell;
    }else {
        ManageCardCell * cell = [tableView dequeueReusableCellWithIdentifier:thirdCellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ManageCardCell" owner:self options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        WeakSelf
        cell.block = ^(UIButton *sender) {
            [weakSelf.view endEditing:YES];
            [weakSelf openPhotoCameraAction:sender];
        };
        [cell updateCell:_currCardItem];
        return cell;
    }
}
- (void)inputContent:(CustomTableViewCell *)cell Row:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = _currCardItem.bank_name;
                break;
            case 1:
                cell.inputTextField.text = _currCardItem.account_name;
                break;
//            case 2:
//                cell.inputTextField.text = _currCardItem.account;
//                break;
            case 3:
                cell.inputTextField.text = _currCardItem.account;
                break;
            case 4:
                cell.inputTextField.text = _currCardItem.idcard_number;
                break;
            case 5:
                cell.inputTextField.text = _currCardItem.account_mobile;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.province];
                break;
            case 1:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.city];
                break;
            case 2:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.district];
                break;
            case 3:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.address_detail];
                break;
            default:
                break;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSArray * array = [self _openResource];
        NSArray * bandsArray = array[0];NSArray* codeArray = array[1];
        if (!selectBandVC) {
            selectBandVC = [[SelectBandVC alloc]init];
            selectBandVC.dataSources = bandsArray.mutableCopy;
        }
        WeakSelf
        __block BankCardItem * weakItem = _currCardItem;
        selectBandVC.selectBlock = ^(NSInteger row) {
            DLog(@"code = %@-----band = %@",codeArray[row],bandsArray[row]);
            weakItem.bank_name = bandsArray[row];
            weakItem.bank_code = codeArray[row];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        };
        [self presentPopupViewController:selectBandVC animationType:MJPopupViewAnimationFade];
    }else if (indexPath.section == 1 && indexPath.row != 3) {
        //选择省市县
        [self _openPickView];
    }
}
#pragma mark - 选择省市县
- (void) _openPickView{
    HZAreaPickerView * pickView = [[HZAreaPickerView alloc]initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    
    [self.view addSubview:pickView];
}
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker{
    _currCardItem.province = picker.locate.stateId;
    _currCardItem.provinceName = picker.locate.state;
    _currCardItem.city = picker.locate.cityId;
    _currCardItem.cityName = picker.locate.city;
    _currCardItem.district = picker.locate.districtId;
    _currCardItem.districtName = picker.locate.district;
    CustomTableViewCell * cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (cell) {
        cell.inputTextField.text = [NSString stringWithFormat:@"%@",picker.locate.state];
    }
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    if (cell) {
        cell.inputTextField.text = [NSString stringWithFormat:@"%@",picker.locate.city];
    }
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    if (cell) {
        cell.inputTextField.text = [NSString stringWithFormat:@"%@",picker.locate.district];
    }
}
#pragma mark - 照片选择
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
        if (sender.tag == 0) {
            _currCardItem.idcard_img_one = image;
        }else if (sender.tag == 1){
            _currCardItem.idcard_img_two = image;
        }else if (sender.tag == 2){
            _currCardItem.idcard_img_three = image;
        }else if (sender.tag == 3){
            _currCardItem.shop_head_img = image;
        }else if (sender.tag == 4){
            _currCardItem.shop_inner_img = image;
        }else if (sender.tag == 5){
            _currCardItem.shop_cash_img = image;
        }
    };
}
#pragma mark 银行卡选择
//银行列表
- (NSArray *)_openResource{
    NSString * jsonStr = @"[{\"code\":\"00000000\",\"name\":\"选择开户行\"}, {\"code\":\"01000000\",\"name\":\"邮储银行\"},   {\"code\":\"01020000\",\"name\":\"工商银行\"},   {\"code\":\"01040000\",\"name\":\"中国银行\"},   {\"code\":\"01050000\",\"name\":\"建设银行\"},   {\"code\":\"03010000\",\"name\":\"交通银行\"},   {\"code\":\"03020000\",\"name\":\"中信银行\"},   {\"code\":\"03030000\",\"name\":\"光大银行\"},   {\"code\":\"03040000\",\"name\":\"华夏银行\"},   {\"code\":\"03050000\",\"name\":\"民生银行\"},   {\"code\":\"03060000\",\"name\":\"广发银行\"},   {\"code\":\"03070000\",\"name\":\"平安银行\"},   {\"code\":\"03080000\",\"name\":\"招商银行\"},   {\"code\":\"03090000\",\"name\":\"兴业银行\"},   {\"code\":\"04031000\",\"name\":\"北京银行\"}]";
    NSArray * array = [NSArray yy_modelArrayWithClass:[BankItem class] json:jsonStr];
    NSMutableArray * bandsArray = @[].mutableCopy;
    NSMutableArray * codeArray = @[].mutableCopy;
    for (BankItem * item in array) {
        [codeArray addObject:item.code];
        [bandsArray addObject:item.name];
    }
    return @[bandsArray,codeArray];;
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSources[section]).count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0 || indexPath.section == 1) ? 46.f : thirdHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = CommonBackgroudColor;
    view.frame = CGRectMake(0, 0, SCreenWidth, 25);
    UILabel * label = [JJWBase createLabel:CGRectMake(5, 0, SCreenWidth- 10, 25) font:[UIFont systemFontOfSize:14] text:(section == 1) ? @"商户信息" :@"" defaultSizeTxt:@"" color:MainTextColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [view addSubview:label];
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
        _currCardItem.account_name = beString;
    }else if (textField.tag == 103) {
        _currCardItem.account = beString;
    }else if (textField.tag == 104) {
        if (beString.length > 18) {
            return NO;
        }
        _currCardItem.idcard_number = beString;
    }else if (textField.tag == 105) {
        if (beString.length > 11) {
            return NO;
        }
        _currCardItem.account_mobile = beString;
    }else if (textField.tag == 203) {
        _currCardItem.address_detail = beString;
    }
    else if (textField.tag == 1002) {
        _currCardItem.open_branch = beString;
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
-(BankCardItem *)currCardItem {
    if (!_currCardItem) {
        _currCardItem = [[BankCardItem alloc]init];
    }
    return _currCardItem;
}



@end
