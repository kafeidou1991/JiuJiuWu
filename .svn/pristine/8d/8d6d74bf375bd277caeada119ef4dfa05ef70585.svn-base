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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@end

@implementation ShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell:(NSDictionary *)dict {
    UIImage * image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    self.imageWidth.constant = image.size.width;
    self.imageHeight.constant = image.size.height;
    self.centerImageV.image = image;
    self.titleLabel.text = [dict objectForKey:@"title"];
}

- (void)updateMeCenterCell:(NSDictionary *)dict {
    self.centerImageV.contentMode = UIViewContentModeCenter;
    UIImage * image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    self.imageWidth.constant = 50;
    self.imageHeight.constant = 50;
    self.centerImageV.image = image;
    self.titleLabel.text = [dict objectForKey:@"title"];
}


@end
