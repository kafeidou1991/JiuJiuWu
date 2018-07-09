//
//  LevelUpCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/25.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "LevelUpCell.h"
#import "LevelItem.h"

@interface LevelUpCell ()
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)selectAction:(UIButton *)sender;


@end

@implementation LevelUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)updateCell:(LevelItem *)item {
    self.levelLabel.text = item.level_name;
    self.rateLabel.text = [NSString stringWithFormat:@"费率：%g‰",item.scale.floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%ld",item.price.integerValue];
}
- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_selectBlock) {
        _selectBlock();
    }
}
@end
