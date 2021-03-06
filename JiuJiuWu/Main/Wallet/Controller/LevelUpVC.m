//
//  LevelUpVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/25.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "LevelUpVC.h"
#import "LevelItem.h"
#import "LevelUpCell.h"
#import "UIViewController+MJPopupViewController.h"
#import "PayTypeVC.h"
#import "ConfirmPayVC.h"

@interface LevelUpVC (){
    PayTypeVC * payTypeVC;
}
@property (nonatomic, strong) NSIndexPath * lastIndexPath;
@end

@implementation LevelUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要升级";
    
}
//提交支付
- (void)commitePay {
    if (!_lastIndexPath) {
        [JJWBase alertMessage:@"请选择你要升级的会员~" cb:nil];
        return;
    }
    LevelItem * item = self.dataSources[_lastIndexPath.section];
    if (item.price.integerValue == 0) {
        [JJWBase alertMessage:@"您已经属于该等级的会员了~" cb:nil];
        return;
    }
    WeakSelf
//    if (!payTypeVC) {
//        payTypeVC = [[PayTypeVC alloc]init];
//    }
//    payTypeVC.block = ^(PayType type) {
//        [weakSelf dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
//        ConfirmPayVC * VC = [[ConfirmPayVC alloc]init];
//        VC.item = item;
//        [weakSelf.navigationController pushViewController:VC animated:YES];
//    };
//    [self presentPopupViewController:payTypeVC animationType:MJPopupViewAnimationSlideBottomBottom];
    ConfirmPayVC * VC = [[ConfirmPayVC alloc]init];
    VC.item = item;
    [weakSelf.navigationController pushViewController:VC animated:YES];
}
-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"user_id":[JJWLogin sharedMethod].loginData.user_id,
                            @"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool GetWithUrl:GetLevelList params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[LevelItem class] json:responseObject].mutableCopy;
        if (weakSelf.dataSources.count > 0) {
            [weakSelf createTableView];
            weakSelf.tableView.tableFooterView = [weakSelf _createFootView:@"升   级" Block:^(UIButton * btn) {
                [weakSelf commitePay];
            }];
        }else {
            [self createEmptyView];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSources.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, SCreenWidth, 20.f);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellId";
    LevelUpCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"LevelUpCell" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell updateCell:self.dataSources[indexPath.section]];
    WeakSelf
    cell.selectBlock = ^{
        if (weakSelf.lastIndexPath) {
            LevelUpCell * lastCell = [tableView cellForRowAtIndexPath:weakSelf.lastIndexPath];
            if (lastCell) {
                lastCell.selectBtn.selected = !lastCell.selectBtn.selected;
            }
        }
        weakSelf.lastIndexPath = indexPath;
    };
    
    return cell;
}
- (UIView *) _createFootView:(NSString *)title Block:(void(^)(UIButton *))block{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, 60)];
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





@end
