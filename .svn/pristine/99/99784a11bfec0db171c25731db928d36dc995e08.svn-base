//
//  SettingViewController.m
//  YZF
//
//  Created by 张竟巍 on 2017/3/27.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "SettingVC.h"




@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = CommonBackgroudColor;
    //@"交易密码",@"手势密码"  //苹果审核 去除 ,@"检查更新"
    self.dataSources = @[@[@"商户信息",@"结算信息",@"更换手机号"],@[@"登录密码"],@[@"设备",@"联系我们",@"关于我们"]].mutableCopy;
    [self createTableView];
    if (!STRISEMPTY([JJWLogin sharedMethod].loginData.token)) {
        self.tableView.tableFooterView = [self _createFootView];
    }else{
        self.tableView.tableFooterView = [UIView new];
    }
    
    
    // 添加内部测试隐藏功能，点击6次可切换网络
    // 如后期，需要增加导航栏右侧按键，可以将此功能转移或移除
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"   " style:UIBarButtonItemStyleDone target:self action:@selector(touchForInnertest)];
}

- (UIView *) _createFootView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:themeColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = [UIColor whiteColor];
    btn.showsTouchWhenHighlighted = NO;
    btn.layer.borderWidth = 1.f;
    btn.layer.borderColor = themeColor.CGColor;
    [btn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(8, 60, SCreenWidth - 2 * 8, 40);
    [view addSubview:btn];
    return view;
}
- (void)exitAction{
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:Logout params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
    [[JJWLogin sharedMethod]removeLoingData];
    [weakSelf.navigationController popViewControllerAnimated:YES];
    if (_exitBlock) {
        _exitBlock();
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString * title = ((NSArray *)self.dataSources[indexPath.section])[indexPath.row];
//    if ([title isEqualToString:@"关于我们"]) {
//        AboutOurViewController * VC = [[AboutOurViewController alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
//        return;
//    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSources.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)self.dataSources[section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"Identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = ((NSArray *)self.dataSources[indexPath.section])[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

// 多次点击进入内部测试
- (void)touchForInnertest{
    
    static NSInteger touchCount = 1;
    
    if (touchCount++ > 5) {
        [self innerTest];
        touchCount = 0;
    }
}
// 内部测试功能
- (void)innerTest{
    NSString * temp = @"当前无选择：默认";
    NSNumber * number = [[NSUserDefaults standardUserDefaults]objectForKey:@"INNER_TEST_CODE"];
    if (number) {
        temp = number.integerValue == 1 ? @"当前选择：测试环境" : @"当前选择：正式环境";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络环境切换" message:temp preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *localTestHuo = [UIAlertAction actionWithTitle:@"测试环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"INNER_TEST_CODE"];
    }];
    
    UIAlertAction *localTestLin = [UIAlertAction actionWithTitle:@"正式环境" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@(2) forKey:@"INNER_TEST_CODE"];
    }];
    
    UIAlertAction *defaultA = [UIAlertAction actionWithTitle:@"恢复默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"INNER_TEST_CODE"];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:localTestHuo];
    [alert addAction:localTestLin];
    [alert addAction:defaultA];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
