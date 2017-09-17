//
//  ShareCell.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/9/17.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ShareCell.h"

@interface ShareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *centerImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation ShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 6.f;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell:(NSDictionary *)dict {
    self.centerImageV.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    self.titleLabel.text = [dict objectForKey:@"title"];
}


@end
