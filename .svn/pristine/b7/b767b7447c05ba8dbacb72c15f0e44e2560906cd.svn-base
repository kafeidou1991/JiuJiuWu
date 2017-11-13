//
//  MyRateVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/10/24.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "MyRateVC.h"
#import "MyRateListCell.h"
#import "MyRateItem.h"

@interface MyRateVC ()

@end

@implementation MyRateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的费率";
}
-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token,@"channel_type":@"0"};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:CashScale params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[MyRateItem class] json:responseObject].mutableCopy;
        if (weakSelf.dataSources.count > 0) {
            [self createTableView];
        }else {
            [self createEmptyView];
        }
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
    }];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"cellID";
    MyRateListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MyRateListCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyRateItem * item = [self.dataSources objectAtIndex:indexPath.row];
    [cell updateCell:item];
    return cell;
}









@end
