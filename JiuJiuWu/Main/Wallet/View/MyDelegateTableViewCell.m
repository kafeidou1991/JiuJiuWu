//
//  MyDelegateTableViewCell.m
//  YZF
//
//  Created by 张竟巍 on 2017/4/3.
//  Copyright © 2017年 Beijing Yi Cheng Agel Ecommerce Ltd. All rights reserved.
//

#import "MyDelegateTableViewCell.h"
#import "NSDate+Category.h"

@interface MyDelegateTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *registLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *Opation1Label;
@property (weak, nonatomic) IBOutlet UIButton *Opation1Btn;
@property (weak, nonatomic) IBOutlet UILabel *Opation2Label;
@property (weak, nonatomic) IBOutlet UIButton *Opation2Btn;
@property (weak, nonatomic) IBOutlet UILabel *Opation3Label;
@property (weak, nonatomic) IBOutlet UIButton *Opation3Btn;
@property (weak, nonatomic) IBOutlet UILabel *Opation4Label;
@property (weak, nonatomic) IBOutlet UIButton *Opation4Btn;


@end

@implementation MyDelegateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(void)updateCell:(DelegateItem *)item :(BOOL)isShop{
//    if (isShop) {
//        self.titleNameLabel.text = @"商户姓名";
//        self.Opation1Label.text = @"状态";
//        self.Opation2Label.text = @"收款笔数";
//        self.Opation3Label.text = @"收款金额";
////        self.Opation4Label.text = @"代理级别";
//        [self.Opation4Label setHidden:YES];
//        [self.Opation4Btn setHidden:YES];
//        [self.Opation1Btn setImage:[UIImage new] forState:UIControlStateNormal];
//        [self.Opation1Btn setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, 0)];
//        [self.Opation1Btn setTitle:[self _config:item.status] forState:UIControlStateNormal];
//
////        [self.Opation2Btn setImage:[UIImage imageNamed:@"medelegate_4"] forState:UIControlStateNormal];
//        [self.Opation2Btn setTitle:item.income_count forState:UIControlStateNormal];
//        [self.Opation3Btn setTitle:item.income_amount forState:UIControlStateNormal];
////        [self.Opation4Btn setTitle:[self agentLevelStr:item.agent_level] forState:UIControlStateNormal];
//
//    }else{
//        self.titleNameLabel.text = @"代理商姓名";
//        [self.Opation1Btn setTitle:item.sub_mer_count forState:UIControlStateNormal];
//        [self.Opation2Btn setTitle:item.sub_agent forState:UIControlStateNormal];
//        [self.Opation3Btn setTitle:item.dist_amount forState:UIControlStateNormal];
//        [self.Opation4Btn setTitle:item.dist_count forState:UIControlStateNormal];
//    }
//    self.shopLabel.text = item.merchant_name;
//    self.nameLabel.text = item.member_name;
//    self.telLabel.text = item.mobile;
//    self.registLabel.text = [[NSDate dateWithTimeIntervalSince1970:item.create_time.integerValue]toString];
//    self.agentLevelLabel.text = [self agentLevelStr:item.agent_level];
//}

- (IBAction)editDelegateAction:(UIButton *)sender {
    if (_editBlock) {
        _editBlock();
    }
}
- (NSString *)agentLevelStr:(NSString *)agent_level{
    //    1:高级合伙人2：初级合伙人3:金牌会员4:普通会员
    NSString * temp = @"";
    switch (agent_level.integerValue) {
        case 1:
            temp = @"高级合伙人";
            break;
        case 2:
            temp = @"初级合伙人";
            break;
        case 3:
            temp = @"金牌会员";
            break;
        case 4:
            temp = @"普通会员";
            break;
        default:
            temp = @"商户";
            break;
    }
    return temp;
}

//1正常 2待激活 3待完善商户信息 4待完善结算账户 5待上传资质
-(NSString *)_config:(NSString *)status{
    NSString * temp = @"";
    switch (status.integerValue) {
        case 1:
            temp = @"正常";
            break;
        case 2:
            temp = @"待激活";
            break;
        case 3:
            temp = @"待完善信息";
            break;
        case 4:
            temp = @"待完善账户";
            break;
        case 5:
            temp = @"待上传资质";
            break;
        case 6:
            temp = @"正在审核";
            break;
        default:
            temp = status;
            break;
    }
    return temp;
}

@end
