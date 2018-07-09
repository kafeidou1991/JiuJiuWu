
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
#import "ManageCardHeadView.h"
#import <AipOcrSdk/AipOcrSdk.h>


@interface ManageCardVC ()<UITextFieldDelegate,HZAreaPickerDelegate,UIAlertViewDelegate>{
    SelectBandVC * selectBandVC;
    NSDictionary *addressData; //地址信息 为了用id获取name 显示用
    NSArray * banksListArray; //储存支持银行卡列表
}
@property (nonatomic, strong) DloginData * currCardItem;

@end

@implementation ManageCardVC{
    // baiduOCR 默认的识别成功的回调
    void (^_successHandler)(id);
    // baiduOCR默认的识别失败的回调
    void (^_failHandler)(NSError *);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = (_type == BindRegisterCardType) ? @"绑定收款银行卡" : @"银行卡信息";
    [self initData];
    [self createGroupTableView];
    self.tableView.tableHeaderView = [self createHeadView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提交实名" Block:^(UIButton * btn) {
        [weakSelf checkBankInfo];
    }];
    
}
- (void)initData {
    [self initBaiDuOCR];
    self.dataSources = @[@[@{@"title":@"结算银行",@"placeholder":@"选择结算银行"},
                           @{@"title":@"结算卡号",@"placeholder":@"请输入结算卡号"},
                           @{@"title":@"手机预留号",@"placeholder":@"请输入银行预留手机号"},
                           @{@"title":@"对公账号",@"placeholder":@"请输入对公银行行号"}],
                         
                         @[@{@"title":@"省",@"placeholder":@"选择商户所在省"},
                           @{@"title":@"市",@"placeholder":@"选择商户所在市"},
                           @{@"title":@"区/县",@"placeholder":@"选择商户所在区/县"},
                           @{@"title":@"详细地址",@"placeholder":@"请输入商户详细地址"}]].mutableCopy;
    addressData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    self.currCardItem = [[JJWLogin sharedMethod].loginData yy_modelCopy];
    if (!STRISEMPTY(self.currCardItem.province)) {
        _currCardItem.provinceName = [self getProvinceName];
    }
    if (!STRISEMPTY(self.currCardItem.city)) {
        _currCardItem.cityName = [self getCityName];
    }
    if (!STRISEMPTY(self.currCardItem.district)) {
        _currCardItem.districtName = [self getDistrictName];
    }
}
//MARK: 头部信息
- (ManageCardHeadView *)createHeadView {
    ManageCardHeadView * headView = [[NSBundle mainBundle]loadNibNamed:@"ManageCardHeadView" owner:nil options:nil].firstObject;
    headView.frame = CGRectMake(0, 0, SCreenWidth, SCreenWidth * 9/16 + 2 * 10);
    //银行卡
    [headView.bankCardView sd_setImageWithURL:[NSURL URLWithString:[self.currCardItem.idcard_img_three configDomain]] placeholderImage:[UIImage imageNamed:@"card_placehold_2"]];
    WeakSelf
    headView.clickBlock = ^{
        [weakSelf bankCardOCROnline];
    };
    return headView;
}
- (void)refreshHeaderView {
    ManageCardHeadView * headView = (ManageCardHeadView *)self.tableView.tableHeaderView;
    //正面
    if (self.currCardItem.idcard_img_three_img) {
        headView.bankCardView.image = self.currCardItem.idcard_img_three_img;
    }else {
        [headView.bankCardView sd_setImageWithURL:[NSURL URLWithString:[self.currCardItem.idcard_img_three configDomain]] placeholderImage:[UIImage imageNamed:@"card_placehold_2"]];
    }
}
#pragma mark - 上传银行卡信息
- (void)checkBankInfo {
    if (STRISEMPTY(_currCardItem.bank_name)) {
        [JJWBase alertMessage:@"请选择结算银行!" cb:nil];
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
    if (_currCardItem.account_type.integerValue == 2 && STRISEMPTY(_currCardItem.open_branch)) {
        [JJWBase alertMessage:@"请输入对公银行行号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.province) || STRISEMPTY(_currCardItem.city) || STRISEMPTY(_currCardItem.district)) {
        [JJWBase alertMessage:@"请选择商户地址!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.address_detail)) {
        [JJWBase alertMessage:@"请输入商户详细地址!" cb:nil];
        return;
    }
    if (IMAGEISEMPTY(_currCardItem.idcard_img_three_img)) {
        [JJWBase alertMessage:@"请完善银行卡认证信息!" cb:nil];
        return;
    }
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSMutableDictionary * dict = @{
                            @"token":[JJWLogin sharedMethod].loginData.token,
                            @"account":_currCardItem.account,
                            @"province":_currCardItem.province,
                            @"city":_currCardItem.city,
                            @"district":_currCardItem.district,
                            @"account_mobile":_currCardItem.account_mobile,
                            @"bank_code":_currCardItem.bank_code,
                            @"address_detail":_currCardItem.address_detail,
                            @"account_type":_currCardItem.account_type}.mutableCopy;
    //行号
    if (_currCardItem.account_type.integerValue == 2){
        [dict setObject:_currCardItem.open_branch forKey:@"open_branch"];
    }
    //上传图片
    if (!IMAGEISEMPTY(_currCardItem.idcard_img_three_img)) {
        [dict setObject:[self base64Str:_currCardItem.idcard_img_three_img] forKey:@"idcard_img_three"];
    }
    [JJWNetworkingTool PostWithUrl:UpdateBankInfo params:dict.copy isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"绑定成功!" cb:nil];
        //更新本地数据
        [self saveUpdateDate:responseObject];
        [[JJWLogin sharedMethod]saveLoginData:self.currCardItem];
        
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
- (void)saveUpdateDate:(id)result {
    DloginData * tempData = [DloginData yy_modelWithJSON:result];
    self.currCardItem.account = tempData.account;
    self.currCardItem.account_mobile = tempData.account_mobile;
    self.currCardItem.account_type = tempData.account_type;
    self.currCardItem.province = tempData.province;
    self.currCardItem.district = tempData.district;
    self.currCardItem.city = tempData.city;
    self.currCardItem.address_detail = tempData.address_detail;
    self.currCardItem.idcard_img_three = tempData.idcard_img_three;
    self.currCardItem.idcard_img_three_img = nil;
    self.currCardItem.open_branch = tempData.open_branch;
    self.currCardItem.bank_code = tempData.bank_code;
    self.currCardItem.realname_checked = tempData.realname_checked;
}
- (NSString *) base64Str:(UIImage *)image {
    NSData * data = UIImageJPEGRepresentation(image, 0.0);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    static NSString * firstCellId = @"firstCellId";
    static NSString * secondCellId = @"secondCellId";
    if (indexPath.section == 0) {
        if (indexPath.row != 3) {
            CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.accessoryType = (indexPath.row == 0) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
            cell.inputTextField.keyboardType = UIKeyboardTypePhonePad;
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
            __block DloginData * weakItem = _currCardItem;
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
    }
    return nil;
}
- (void)inputContent:(CustomTableViewCell *)cell Row:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = _currCardItem.bank_name;
                break;
            case 1:
                cell.inputTextField.text = _currCardItem.account;
                break;
            case 2:
                cell.inputTextField.text = _currCardItem.account_mobile;
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.provinceName];
                break;
            case 1:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.cityName];
                break;
            case 2:
                cell.inputTextField.text = [NSString stringWithFormat:@"%@",_currCardItem.districtName];
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
        __block DloginData * weakItem = _currCardItem;
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
#pragma mark 银行卡选择
-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    WeakSelf
    [JJWNetworkingTool GetWithUrl:BankList params:@{} isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        banksListArray = [NSArray yy_modelArrayWithClass:[BankItem class] json:responseObject];
        //构建第一个
        BankItem * firstItem = [[BankItem alloc]init];
        firstItem.is_close = @"0";firstItem.bank_name = @"选择开户银行";
        firstItem.bank_code = @"0000000000";firstItem.use_type = @"1";
        NSMutableArray * tempArray =@[firstItem].mutableCopy;
        for (BankItem * item in banksListArray) {
            if (item.is_close.integerValue == 0) {
                [tempArray addObject:item];
            }
        }
        //去除关闭的通道
        banksListArray = tempArray.copy;
        
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
//银行列表
- (NSArray *)_openResource{
    NSMutableArray * bandsArray = @[].mutableCopy;
    NSMutableArray * codeArray = @[].mutableCopy;
    for (BankItem * item in banksListArray) {
        [codeArray addObject:item.bank_code];
        [bandsArray addObject:item.bank_name];
    }
    return @[bandsArray,codeArray];
}
- (void)setBankCardInfo:(NSString *)bankName {
    if (STRISEMPTY(bankName)) {
        [JJWBase alertMessage:@"该银行无法识别，请手动选择" cb:nil];
        return;
    }
    BOOL isExist = NO;
    for (BankItem * item in banksListArray) {
        if ([item.bank_name isEqualToString:bankName]) {
            self.currCardItem.bank_name = bankName;
            self.currCardItem.bank_code = item.bank_code;
            isExist = YES;
            break;
        }
    }
    if (!isExist) {
        [JJWBase alertMessage:@"该银行无法识别，请手动选择" cb:nil];
    }
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSources[section]).count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0 ? 0 : 25.f);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    if (section == 0) {
        return view;
    }
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
        _currCardItem.account = beString;
    }else if (textField.tag == 102) {
        if (beString.length > 11) {
            return NO;
        }
        _currCardItem.account_mobile = beString;
    }else if (textField.tag == 203) {
        _currCardItem.address_detail = beString;
    }
    else if (textField.tag == 1003) {
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
    btn.backgroundColor = JJWThemeColor;
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

- (NSString *)getProvinceName {
    NSArray * baseProvinces = [addressData valueForKey:@"province"];
    for (NSDictionary * dict in baseProvinces) {
        NSString * pid = [dict objectForKey:@"pid"];
        if ([pid isEqualToString:_currCardItem.province]) {
            return [dict objectForKey:@"name"];
        }
    }
    return @"";
}
- (NSString *)getCityName {
    NSArray * baseCities = [addressData valueForKey:@"city"];
    for (NSDictionary * dict in baseCities) {
        NSString * pid = [dict objectForKey:@"cid"];
        if ([pid isEqualToString:_currCardItem.city]) {
            return [dict objectForKey:@"name"];
        }
    }
    return @"";
}
- (NSString *)getDistrictName {
    NSArray * baseAreas = [addressData valueForKey:@"area"];
    for (NSDictionary * dict in baseAreas) {
        NSString * pid = [dict objectForKey:@"aid"];
        if ([pid isEqualToString:_currCardItem.district]) {
            return [dict objectForKey:@"name"];
        }
    }
    return @"";
}
//MARK: initBaiDuOCR
- (void)initBaiDuOCR {
#warning 【必须！】请在 ai.baidu.com中新建App, 绑定BundleId后，在此填写授权信息
#warning 【必须！】上传至AppStore前，请使用lipo移除AipBase.framework、AipOcrSdk.framework的模拟器架构，参考FAQ：ai.baidu.com/docs#/OCR-iOS-SDK/top
    //     授权方法：在此处填写App的Api Key/Secret Key
    [[AipOcrService shardService] authWithAK:@"hNk22j81qtIStK3sRaTrmkCg" andSK:@"Ka5uI6tLOtKphgSVDcy1mKoTR72qUqDv"];
    [self configCallback];
}
- (void)bankCardOCROnline{
    WeakSelf
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard
                                 andImageHandler:^(UIImage *image) {
                                     weakSelf.currCardItem.idcard_img_three_img = image;
                                     [[AipOcrService shardService] detectBankCardFromImage:image
                                                                            successHandler:_successHandler
                                                                               failHandler:_failHandler];
                                     
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"%@", result);
        if(result[@"result"]){
            if([result[@"result"] isKindOfClass:[NSDictionary class]]){
                
                [result[@"result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    //赋值
                    if ([key isEqualToString:@"bank_card_number"]) {
                        weakSelf.currCardItem.account = [obj stringByReplacingOccurrencesOfString:@" " withString:@""];
                    }else if ([key isEqualToString:@"bank_card_type"]){
                        //卡片类型
                    }else if ([key isEqualToString:@"bank_name"]){
                        [weakSelf setBankCardInfo:obj];
                    }
                }];
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //识别成功
            [weakSelf.tableView reloadData];
            [weakSelf refreshHeaderView];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        }];
    };
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
