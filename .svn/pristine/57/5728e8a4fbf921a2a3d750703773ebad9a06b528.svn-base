//
//  SUEmptyView.h
//  wyzc
//
//  Created by sunjun on 14-8-4.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(void);

@interface SUEmptyView : UIView

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel     *desLabel;
@property(nonatomic,strong) UILabel     *detailLabel;
@property(nonatomic,strong) UIButton    *refreshButton;
@property(nonatomic,strong) UIView      *netWorkView;
@property(nonatomic,copy)  RefreshBlock    refreshCallBack;

-(void) setDestext:(NSString *)str;

-(void) setSubDestext:(NSString *)str;

-(void) removeAllSubView;

-(void) setNetwork:(BOOL) isConnect;

-(void) setButtonTitle:(NSString *)title;

-(void) setRefreshButtonHiden:(BOOL)flag;

@end
