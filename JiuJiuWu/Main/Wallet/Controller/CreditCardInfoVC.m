//
//  CreditCardInfoViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/6/29.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "CreditCardInfoVC.h"
#import "CreditCardTableViewCell.h"
#import "TwoCreditInfoTableViewCell.h"
//#import "VerifyIdentityViewController.h"
#import "SelectBandVC.h"
#import "UIViewController+MJPopupViewController.h"
//#import "ConfirmPayViewController.h"

typedef NS_ENUM(NSInteger, PayCardType){
    PayCreditCardType = 0, //信用卡
    PayCashCardType  //银行卡
};

static const CGFloat pickHeight = 120.f;

@interface CreditCardInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
    SelectBandVC * selectBandVC;
    CreditCardsList * creditList;
    QuickPayInfoItem * selectItem ; //当前选择的银行卡
//    BOOL isCanEditCardNum; //是否能编辑银行卡号 （从接口过来的 不能编辑 新增卡可以编辑）
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (strong, nonatomic) NSArray * pickSource;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cvvLabel;

@property (nonatomic, assign) PayCardType payType;

@end

@implementation CreditCardInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷支付";
    self.view.backgroundColor = CommonBackgroudColor;
    selectItem = [[QuickPayInfoItem alloc]init];
    selectItem.bank_type = @"选择开户行";
//    isCanEditCardNum = YES;
    
    self.payType = PayCreditCardType;
    self.dataSource = @[@"银行卡类型",@"所属银行",@"开户行地址",@"银行卡号",@"姓名",@"有效期"].mutableCopy;
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"下一步" Block:^(UIButton * btn) {
        if (STRISEMPTY(weakSelf.cardNumLabel.text) ||
            STRISEMPTY(weakSelf.nameLabel.text) ||
            [selectItem.bank_type isEqualToString:@"选择开户行"] ||STRISEMPTY(selectItem.bank_type)||
            [selectItem.bank_name isEqualToString:@""] ||
            (STRISEMPTY(weakSelf.dateLabel.text) && self.payType == PayCreditCardType)  ||
            (STRISEMPTY(weakSelf.cvvLabel.text) && self.payType == PayCreditCardType)){
            
            [JJWBase alertMessage:@"请完善基本信息" cb:nil];
        }else{
            QuickPayInfoItem * info = [[QuickPayInfoItem alloc]init];
            info.acct_type = (self.payType == PayCreditCardType)? @"CREDIT" :@"DEBIT";
            info.account = self.cardNumLabel.text;
            info.account_name = self.nameLabel.text;
            info.account_expire_date = self.dateLabel.text;
            info.account_cvv = self.cvvLabel.text;
            info.bank_name = selectItem.bank_name;
            info.bank_code = selectItem.bank_code;
            info.bank_type = selectItem.bank_type;
            info.bankShowName = selectItem.bankShowName;
            [info saveProdfile];
            
//            ConfirmPayViewController * viVC = [[ConfirmPayViewController alloc]init];
//            viVC.amount = self.amount;
//            viVC.cardNumber = self.cardNumLabel.text;
//            [weakSelf.navigationController pushViewController:viVC animated:YES];
        }
        
    }];
}
- (void)afterProFun {
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token};
    [JJWNetworkingTool PostWithUrl:CreditCardList params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        creditList = [CreditCardsList yy_modelWithJSON:responseObject];
        if (creditList.credit_list.count > 0) {
            for (QuickPayInfoItem * item in creditList.credit_list) {
                if (STRISEMPTY(item.bank_type)) {
                    item.bank_type = @"选择开户行";
                }
                 item.bankShowName = [NSString stringWithFormat:@"%@%@",item.bank_type,item.account.length > 4 ?[NSString stringWithFormat:@"(%@)", [item.account substringFromIndex:item.account.length - 4]]: (STRISEMPTY(item.account)? @"":[NSString stringWithFormat:@"(%@)",item.account])];
            }
            self.pickSource = [NSArray arrayWithArray:creditList.credit_list];
            selectItem = self.pickSource.firstObject;
            [self.pickView selectRow:0 inComponent:0 animated:YES];
            [self.pickView reloadAllComponents];
            [self.tableView reloadData];
            [self setTopInfo];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void) setTopInfo {
    self.cardTypeLabel.text = selectItem.bankShowName;
    self.cardNumLabel.text = selectItem.account;
    self.nameLabel.text = selectItem.account_name;
    self.cvvLabel.text = selectItem.account_cvv;
    self.dateLabel.text = selectItem.account_expire_date;
}
#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 5) {
        static NSString * cellId = @"cellId";
        CreditCardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"CreditCardTableViewCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 0 || indexPath.row == 1) {
            cell.textField.enabled = NO;
            if (indexPath.row == 0) {
                cell.textField.text = STRISEMPTY(selectItem.bankShowName) ? @"选择开户行" : selectItem.bankShowName;
            }else{
                cell.textField.text = selectItem.bank_type;
            }
        }else{
            cell.textField.enabled = YES;
        }
        if (indexPath.row == 3) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            cell.textField.keyboardType = UIKeyboardTypeDefault;
        }
        if (indexPath.row == 2) {
            cell.textField.text = selectItem.bank_name;
        }else if (indexPath.row == 3) {
            cell.textField.text = selectItem.account;
        }else if (indexPath.row == 4){
            cell.textField.text = selectItem.account_name;
        }
        
        if (indexPath.row == 2) {
            cell.textField.placeholder = @"信用卡开户行完整名称，具体到支行";
        }else if (indexPath.row == 3){
            cell.textField.placeholder = @"请输入银行卡号码";
        }else if (indexPath.row  == 4){
            cell.textField.placeholder = @"请输入持卡人姓名";
        }else{
            cell.textField.placeholder = @"";
        }
        
        cell.textField.tag = indexPath.row;
        cell.textField.delegate = self;
        cell.titleLabel.text = self.dataSource[indexPath.row];
        
        return cell;
    }else{
        static NSString * cellId = @"cellLastId";
        TwoCreditInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"TwoCreditInfoTableViewCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.leftView.rightTextfield.tag = 100;
        cell.rightView.rightTextfield.tag = 101;
        cell.leftView.rightTextfield.delegate = cell.rightView.rightTextfield.delegate = self;
        cell.leftView.rightTextfield.keyboardType = cell.rightView.rightTextfield.keyboardType = UIKeyboardTypeNumberPad;
        cell.leftView.rightTextfield.text = selectItem.account_expire_date;
        cell.rightView.rightTextfield.text = selectItem.account_cvv;
        cell.leftView.rightTextfield.placeholder = @"例：0430";
        cell.rightView.rightTextfield.placeholder = @"例：127";
        return cell;
    }
}



#pragma mark textField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * beString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 2) {
        selectItem.bank_name = beString;
    }else if (textField.tag == 3) {
        if (textField.text.length > 20 && ![string isEqualToString:@""]) {
            self.cardNumLabel.text = textField.text;
            return NO;
        }else{
            self.cardNumLabel.text = beString;
        }
        selectItem.account = self.cardNumLabel.text;
        selectItem.bankShowName = [NSString stringWithFormat:@"%@%@",selectItem.bank_type,selectItem.account.length > 4 ?[NSString stringWithFormat:@"(%@)", [selectItem.account substringFromIndex:selectItem.account.length - 4]]: (STRISEMPTY(selectItem.account)? @"":[NSString stringWithFormat:@"(%@)",selectItem.account])];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }else if (textField.tag == 4){
        self.nameLabel.text = beString;
        selectItem.account_name = self.nameLabel.text;
    }else if (textField.tag == 100) {
        if (textField.text.length > 3 && ![string isEqualToString:@""]) {
            self.dateLabel.text = textField.text;
            return NO;
        }else{
            self.dateLabel.text = beString;
        }
        selectItem.account_expire_date = self.dateLabel.text;
    }else if (textField.tag == 101) {
        if (textField.text.length > 2 && ![string isEqualToString:@""]) {
            self.cvvLabel.text = textField.text;
            return NO;
        }else{
            self.cvvLabel.text = beString;
        }
        selectItem.account_cvv = self.cvvLabel.text;
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if (textField.tag == 3) {
        self.cardNumLabel.text = @"";
        selectItem.account = self.cardNumLabel.text;
    }else if (textField.tag == 4){
        self.nameLabel.text = @"";
        selectItem.account_name = self.nameLabel.text;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf
    if (indexPath.row == 0) {
        if (creditList.credit_list.count > 0) {
            [self _openOrClosePickView];
        }
    }else if (indexPath.row == 1){
        NSArray * array = [self _openResource];
        NSArray * bandsArray = array[0];NSArray* codeArray = array[1];
        if (!selectBandVC) {
            selectBandVC = [[SelectBandVC alloc]init];
            selectBandVC.dataSources = bandsArray.mutableCopy;
        }
        __block QuickPayInfoItem * weakItem = selectItem;
        selectBandVC.selectBlock = ^(NSInteger row) {
            DLog(@"code = %@-----band = %@",codeArray[row],bandsArray[row]);
            weakItem.bank_type = bandsArray[row];
            weakItem.bank_code = codeArray[row];
            weakItem.bankShowName = [NSString stringWithFormat:@"%@%@",weakItem.bank_type,weakItem.account.length > 4 ?[NSString stringWithFormat:@"(%@)", [weakItem.account substringFromIndex:weakItem.account.length - 4]]: (STRISEMPTY(weakItem.account)? @"":[NSString stringWithFormat:@"(%@)",weakItem.account])];
            [weakSelf setTopInfo];
//            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf.tableView reloadData];
            [weakSelf dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        };
        [self presentPopupViewController:selectBandVC animationType:MJPopupViewAnimationFade];
    }else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
        CreditCardTableViewCell * cell = (CreditCardTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell.textField canBecomeFirstResponder]) {
            [cell.textField becomeFirstResponder];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//银行列表
- (NSArray *)_openResource{
    NSString * jsonStr = @"[{\"code\":\"00000000\",\"name\":\"选择开户行\"},{\"code\":\"01000000\",\"name\":\"邮储银行\"},{\"code\":\"01020000\",\"name\":\"工商银行\"},{\"code\":\"01040000\",\"name\":\"中国银行\"},{\"code\":\"01050000\",\"name\":\"建设银行\"},{\"code\":\"03010000\",\"name\":\"交通银行\"},{\"code\":\"03020000\",\"name\":\"中信银行\"},{\"code\":\"03030000\",\"name\":\"光大银行\"},{\"code\":\"03040000\",\"name\":\"华夏银行\"},{\"code\":\"03050000\",\"name\":\"民生银行\"},{\"code\":\"03060000\",\"name\":\"广发银行\"},{\"code\":\"03070000\",\"name\":\"平安银行\"},{\"code\":\"03080000\",\"name\":\"招商银行\"},{\"code\":\"03090000\",\"name\":\"兴业银行\"},{\"code\":\"04031000\",\"name\":\"北京银行\"},{\"code\":\"04083320\",\"name\":\"宁波银行\"},{\"code\":\"04123330\",\"name\":\"温州银行\"},{\"code\":\"04135810\",\"name\":\"广州银行\"},{\"code\":\"04202220\",\"name\":\"大连银行\"},{\"code\":\"04233310\",\"name\":\"杭州银行\"},{\"code\":\"04243010\",\"name\":\"南京银行\"},{\"code\":\"04392270\",\"name\":\"锦州银行\"},{\"code\":\"04416900\",\"name\":\"重庆银行\"},{\"code\":\"04422610\",\"name\":\"哈尔滨银行\"},{\"code\":\"04478210\",\"name\":\"兰州银行\"},{\"code\":\"04484210\",\"name\":\"南昌银行\"},{\"code\":\"04922600\",\"name\":\"龙江银行\"},{\"code\":\"05083000\",\"name\":\"江苏银行\"},{\"code\":\"14012900\",\"name\":\"上海农村商业银行\"},{\"code\":\"14136900\",\"name\":\"重庆农村商业银行\"}]";
    
    NSArray * array = [NSArray yy_modelArrayWithClass:[BankItem class] json:jsonStr];
    NSMutableArray * bandsArray = @[].mutableCopy;
    NSMutableArray * codeArray = @[].mutableCopy;
    for (BankItem * item in array) {
        [codeArray addObject:item.code];
        [bandsArray addObject:item.name];
    }
    return @[bandsArray,codeArray];;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.25 animations:^{
        self.pickView.top = SCreenHegiht - NAVIGATION_BAR_HEIGHT;
    }];
}
#pragma mark - pickView delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickSource.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.f;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:15]];
    }
    QuickPayInfoItem * item = self.pickSource[row];
    customLabel.text = item.bank_type;
    customLabel.textColor = [UIColor blackColor];
    return customLabel;
}
- (void) _openOrClosePickView{
    BOOL isOpen = (self.pickView.top == SCreenHegiht - NAVIGATION_BAR_HEIGHT - pickHeight)? NO : YES;
    if (isOpen) {
        [UIView animateWithDuration:0.25 animations:^{
            self.pickView.top = SCreenHegiht - NAVIGATION_BAR_HEIGHT - pickHeight;
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.pickView.top = SCreenHegiht - NAVIGATION_BAR_HEIGHT;
        }];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    CreditCardTableViewCell * cell = (CreditCardTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    QuickPayInfoItem * item = self.pickSource[row];
    cell.textField.text = item.bank_type;
    self.cardTypeLabel.text = item.bank_type;
    selectItem = item;
//    [self _deleteOrAppendCell:row];
    [self.tableView reloadData];
    [self _openOrClosePickView];
}
- (void) _deleteOrAppendCell:(NSInteger)row{
    if (self.payType == row) {
        return;
    }
    self.payType = row;
    if (self.payType == PayCashCardType) {
        [self.dataSource removeLastObject];
        self.dateLabel.text = @"";self.cvvLabel.text =@"";
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }else{
        [self.dataSource addObject:@"有效期"];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:5 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.25 animations:^{
        self.pickView.top = SCreenHegiht - NAVIGATION_BAR_HEIGHT;
    }];
}

- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 60)];
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
    btn.frame = CGRectMake(0, 10, self.tableView.width, 40);
    [view addSubview:btn];
    return view;
}












@end
