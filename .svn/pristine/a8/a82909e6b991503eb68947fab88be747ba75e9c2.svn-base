//
//  MyCertificationVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/7.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "MyCertificationVC.h"
#import "CustomTableViewCell.h"
#import "CompanyInfoCell.h"
#import "BankCardItem.h"
#import "MyCertificationHeadView.h"
#import <AipOcrSdk/AipOcrSdk.h>


@interface MyCertificationVC ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) DloginData * currCardItem;
@end

@implementation MyCertificationVC{
    // baiduOCR 默认的识别成功的回调
    void (^_successHandler)(id);
    // baiduOCR默认的识别失败的回调
    void (^_failHandler)(NSError *);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证信息";
    self.currCardItem = [[JJWLogin sharedMethod].loginData yy_modelCopy];
    self.dataSources = @[@{@"title":@"姓名：",@"placeholder":@"请输入身份证姓名"},
                           @{@"title":@"身份证号：",@"placeholder":@"请输入身份证号"},
                           @{@"title":@"详细地址：",@"placeholder":@"请输入地址"},
                           @{@"title":@"有效期：",@"placeholder":@"请输入有效期(yyyy-MM-dd)"}].mutableCopy;
    [self initBaiDuOCR];
    [self createTableView];
    self.tableView.tableHeaderView = [self createHeadView];
    WeakSelf
    self.tableView.tableFooterView = [self _createFootView:@"提 交" Block:^(UIButton * btn) {
        [weakSelf nextAction];
    }];
}
//MARK: headView
- (MyCertificationHeadView *)createHeadView {
    MyCertificationHeadView * headView = [[NSBundle mainBundle]loadNibNamed:@"MyCertificationHeadView" owner:nil options:nil].firstObject;
    CGFloat picWidth = SCreenWidth - 2 * 10.f;
    headView.frame = CGRectMake(0, 0, SCreenWidth, picWidth * 9/16 * 2 + 3 * 10.f);
    //正面
    [headView.idCardFrontView sd_setImageWithURL:[NSURL URLWithString:[self.currCardItem.idcard_img_one configDomain]] placeholderImage:[UIImage imageNamed:@"card_placehold_0"]];
    //反面
    [headView.idCardBackView sd_setImageWithURL:[NSURL URLWithString:[self.currCardItem.idcard_img_two configDomain]] placeholderImage:[UIImage imageNamed:@"card_placehold_1"]];
    WeakSelf
    headView.clickBlock = ^(int index) {
        if (index == 0) {
            [weakSelf idcardOCROnlineFront];
        }else {
            [weakSelf idcardOCROnlineBack];
        }
    };
    return headView;
}
- (void)refreshHeaderView {
    MyCertificationHeadView * headView = (MyCertificationHeadView *)self.tableView.tableHeaderView;
    //正面
    if (self.currCardItem.idcard_img_one_img) {
        headView.idCardFrontView.image = self.currCardItem.idcard_img_one_img;
    }else {
        [headView.idCardFrontView sd_setImageWithURL:[NSURL URLWithString:[self.currCardItem.idcard_img_one configDomain]] placeholderImage:[UIImage imageNamed:@"card_placehold_0"]];
    }
    //反面
    if (self.currCardItem.idcard_img_two_img) {
        headView.idCardBackView.image = self.currCardItem.idcard_img_two_img;
    }else {
        [headView.idCardBackView sd_setImageWithURL:[NSURL URLWithString:[self.currCardItem.idcard_img_two configDomain]] placeholderImage:[UIImage imageNamed:@"card_placehold_1"]];
    }
}
//MARK: 提交
- (void)nextAction {
    if (STRISEMPTY(_currCardItem.account_name)) {
        [JJWBase alertMessage:@"请输入身份证姓名!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.idcard_number)) {
        [JJWBase alertMessage:@"请输入身份证号!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.idcard_address)) {
        [JJWBase alertMessage:@"请输入地址!" cb:nil];
        return;
    }
    if (STRISEMPTY(_currCardItem.idcard_expired_time)) {
        [JJWBase alertMessage:@"请输入有效期!" cb:nil];
        return;
    }
    //图片必须全部上传 否则会把之前的给顶掉
    if (IMAGEISEMPTY(_currCardItem.idcard_img_one_img) || IMAGEISEMPTY(_currCardItem.idcard_img_two_img)) {
        [JJWBase alertMessage:@"请认证身份证信息!" cb:nil];
        return;
    }
    WeakSelf
    [self hudShow:self.view msg:STTR_ater_on];
    NSMutableDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,
                                   @"account_name":_currCardItem.account_name,
                                   @"idcard_number":_currCardItem.idcard_number,
                                   @"idcard_address":_currCardItem.idcard_address,
                                   @"idcard_img_one":[self base64Str:_currCardItem.idcard_img_one_img],
                                   @"idcard_img_two":[self base64Str:_currCardItem.idcard_img_two_img],
                                   @"idcard_expired_time":_currCardItem.idcard_expired_time
                                   }.mutableCopy;
    [JJWNetworkingTool PostWithUrl:UpdateUserIDCardInfo params:dict.copy isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:@"认证成功!" cb:nil];
        //更新本地数据
        [self saveUpdateDate:responseObject];
        
        [[JJWLogin sharedMethod]saveLoginData:self.currCardItem];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
- (void)saveUpdateDate:(id)result {
    self.currCardItem.account_name = [result objectForKey:@"account_name"];
    self.currCardItem.idcard_number = [result objectForKey:@"idcard_number"];
    self.currCardItem.idcard_address = [result objectForKey:@"idcard_address"];
    self.currCardItem.idcard_expired_time = [result objectForKey:@"idcard_expired_time"];
    self.currCardItem.idcard_img_one = [result objectForKey:@"idcard_img_one"];
    self.currCardItem.idcard_img_two = [result objectForKey:@"idcard_img_two"];
    //清楚本地图片
    self.currCardItem.idcard_img_one_img = nil;
    self.currCardItem.idcard_img_two_img = nil;
}
- (NSString *) base64Str:(UIImage *)image {
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.inputTextField.keyboardType = (indexPath.row == 0 || indexPath.row == 2) ? UIKeyboardTypeDefault : UIKeyboardTypePhonePad;
    cell.inputTextField.tag = indexPath.row + 100;
    cell.inputTextField.delegate = self;
    [cell updateBindCardCell:self.dataSources[indexPath.row] textAlignment:NSTextAlignmentRight];
    [self inputContent:cell Row:indexPath];
    return cell;
}
- (void)inputContent:(CustomTableViewCell *)cell Row:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            cell.inputTextField.text = _currCardItem.account_name;
            break;
        case 1:
            cell.inputTextField.text = _currCardItem.idcard_number;
            break;
        case 2:
            cell.inputTextField.text = _currCardItem.idcard_address;
            break;
        case 3:
            cell.inputTextField.text = _currCardItem.idcard_expired_time;
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
        _currCardItem.account_name = beString;
    }else if (textField.tag == 101) {
        _currCardItem.idcard_number = beString;
    }else if (textField.tag == 102) {
        _currCardItem.idcard_address = beString;
    }else if (textField.tag == 103) {
        _currCardItem.idcard_expired_time = beString;
    }
    return YES;
}

//MARK: initBaiDuOCR
- (void)initBaiDuOCR {
#warning 【必须！】请在 ai.baidu.com中新建App, 绑定BundleId后，在此填写授权信息
#warning 【必须！】上传至AppStore前，请使用lipo移除AipBase.framework、AipOcrSdk.framework的模拟器架构，参考FAQ：ai.baidu.com/docs#/OCR-iOS-SDK/top
    //     授权方法：在此处填写App的Api Key/Secret Key
    [[AipOcrService shardService] authWithAK:@"hNk22j81qtIStK3sRaTrmkCg" andSK:@"Ka5uI6tLOtKphgSVDcy1mKoTR72qUqDv"];
    [self configCallback];
}
//正面识别
- (void)idcardOCROnlineFront {
    WeakSelf
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                                 andImageHandler:^(UIImage *image) {
                                     weakSelf.currCardItem.idcard_img_one_img = image;
                                     [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                                                  withOptions:nil
                                                                               successHandler:_successHandler
                                                                                  failHandler:_failHandler];
                                 }];
    
    [self presentViewController:vc animated:YES completion:nil];
}
//背面识别
- (void)idcardOCROnlineBack{
    WeakSelf
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack
                                 andImageHandler:^(UIImage *image) {
                                     //保存图片
                                     weakSelf.currCardItem.idcard_img_two_img = image;
                                     [[AipOcrService shardService] detectIdCardBackFromImage:image
                                                                                 withOptions:nil
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
        NSMutableString *message = [NSMutableString string];
        if(result[@"words_result"]){
            if([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
                
                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    NSString * tempObj = @"";
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                        tempObj = obj[@"words"];
                    }else{
                        [message appendFormat:@"%@: %@\n", key, obj];
                        tempObj = obj;
                    }
                    //赋值
                    if ([key isEqualToString:@"姓名"]) {
                        weakSelf.currCardItem.account_name = tempObj;
                    }else if ([key isEqualToString:@"公民身份号码"]){
                        weakSelf.currCardItem.idcard_number = tempObj;
                    }else if ([key isEqualToString:@"住址"]){
                        weakSelf.currCardItem.idcard_address = tempObj;
                    }else if ([key isEqualToString:@"失效日期"]){
                        weakSelf.currCardItem.idcard_expired_time = tempObj;
                    }
                }];
            }else if([result[@"words_result"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *obj in result[@"words_result"]){
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@\n", obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@\n", obj];
                    }
                }
            }
        }else{
            [message appendFormat:@"%@", result];
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
