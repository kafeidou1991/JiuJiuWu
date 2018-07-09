//
//  LuckyDrawVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/29.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "LuckyDrawVC.h"
#import "MyLucyListCell.h"

@interface LuckyDrawVC ()

@end

@implementation LuckyDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抽奖记录";
}

-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:GetLuckyList params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.dataSources = [NSArray yy_modelArrayWithClass:[MyLuckyDrawItem class] json:responseObject].mutableCopy;
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
-(void)refreshAction {
    [self afterProFun];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyLucyListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyLucyListCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([MyLucyListCell class]) owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyLuckyDrawItem * item = [self.dataSources objectAtIndex:indexPath.row];
    [cell updateCell:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}


@end
