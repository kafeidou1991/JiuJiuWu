
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

static CGFloat secondHeight = 300.f;

@interface ManageCardVC (){
    SelectBandVC * selectBandVC;
    BankItem * selectItem; //选择后的银行
}

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
    self.imagesArray = @[[UIImage new],[UIImage new],[UIImage new]].mutableCopy;
    selectItem = [[BankItem alloc]init];
    [self createGroupTableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提交实名" Block:^(UIButton * btn) {
        [weakSelf checkBankInfo];
    }];
    
}
//上传银行卡信息
- (void)checkBankInfo {
    NSString * idcard_number,* banck_code,* bank_name,* account,* idcard_img_one,* idcard_img_two,* idcard_img_three,* province,* city,* district;
    CustomTableViewCell * cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (STRISEMPTY(cell.inputTextField.text)) {
        [JJWBase alertMessage:@"请选择结算银行!" cb:nil];
        return;
    }
    bank_name = cell.inputTextField.text;
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (STRISEMPTY(cell.inputTextField.text)) {
        [JJWBase alertMessage:@"输入户主姓名!" cb:nil];
        return;
    }
    account = cell.inputTextField.text;
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (STRISEMPTY(cell.inputTextField.text)) {
        [JJWBase alertMessage:@"请输入结算卡号!" cb:nil];
        return;
    }
    banck_code = cell.inputTextField.text;
    cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (STRISEMPTY(cell.inputTextField.text)) {
        [JJWBase alertMessage:@"请输入身份证号!" cb:nil];
        return;
    }
    idcard_number = cell.inputTextField.text;
    for (UIImage * image in self.imagesArray) {
        if (image.size.width == 0) {
            [JJWBase alertMessage:@"请完善图片认证信息!" cb:nil];
            return;
        }
    }
    DLog(@"%@",selectItem);
    idcard_img_one = [self base64Str:_imagesArray[0]];
    idcard_img_two = [self base64Str:_imagesArray[1]];
    idcard_img_three = [self base64Str:_imagesArray[2]];
    province = city = district = @"";
//    user_id	string	是	用户ID
//    idcard_number	string	是	身份证号
//    banck_code	string	是	银行卡号
//    bank_name	string	是	银行名称
//    account	string	是	户主
//    idcard_img_one	string	是	身份证照片正面
//    idcard_img_two	string	是	身份证照片反面
//    idcard_img_three	string	是	手持身份证
//    province	int	是	省
//    city	int	是	市	
//    district	int	是	县
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,
                            @"idcard_number":idcard_number,
                            @"banck_code":banck_code,
                            @"bank_name":bank_name,
                            @"account":account,
                            @"idcard_img_one":idcard_img_one,
                            @"idcard_img_two":idcard_img_two,
                            @"idcard_img_three":idcard_img_three,
                            @"province":province,
                            @"city":city,
                            @"district":district};
    [JJWNetworkingTool PostWithUrl:UpdateBankInfo params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"成功!" cb:nil];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
    
    
    
    
    NSLog(@"%@",_imagesArray[0]);
    NSLog(@"%@",_imagesArray[1]);
    NSLog(@"%@",_imagesArray[2]);
}
- (NSString *) base64Str:(UIImage *)image {
    NSData * data = UIImageJPEGRepresentation(image, 0.0);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
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
        if (indexPath.row == 0 && !STRISEMPTY(selectItem.name)) {
            cell.inputTextField.text = selectItem.name;
        }
        return cell;
    }else {
        ManageCardCell * cell = [tableView dequeueReusableCellWithIdentifier:secondCellId];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ManageCardCell" owner:self options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        WeakSelf
        cell.block = ^(UIButton *sender) {
            [weakSelf.view endEditing:YES];
            [weakSelf openPhotoCameraAction:sender];
        };
        return cell;
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
        __block BankItem * weakItem = selectItem;
        selectBandVC.selectBlock = ^(NSInteger row) {
            DLog(@"code = %@-----band = %@",codeArray[row],bandsArray[row]);
            weakItem.name = bandsArray[row];
            weakItem.code = codeArray[row];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        };
        [self presentPopupViewController:selectBandVC animationType:MJPopupViewAnimationFade];
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
        _imagesArray[sender.tag] = image;
    };
}
#pragma mark 银行卡选择
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
