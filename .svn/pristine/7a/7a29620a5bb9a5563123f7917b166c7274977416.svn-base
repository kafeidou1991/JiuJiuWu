//
//  ServicePlaceVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2017/11/10.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#import "ServicePlaceVC.h"
#import "ServiceVC.h"

@interface ServicePlaceVC ()

@end

@implementation ServicePlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 100, 100, 100);
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tap{
    [self.navigationController pushViewController:[[ServiceVC alloc]init] animated:YES];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController pushViewController:[[ServiceVC alloc]init] animated:YES];
}

//配置客服信息
- (ZCKitInfo *)setupService {
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    //  初始化配置信息
    [self setZCLibInitInfoParam:initInfo];
    
    //自定义用户参数
    [self customUserInformationWith:initInfo];
    
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    
    
    // 自定义UI(设置背景颜色相关)
    [self customerUI:uiInfo];
    
    // 自定义提示语相关设置
    
    
    // 之定义商品和留言页面的相关UI
    //    [self customerGoodAndLeavePageWithParameter:uiInfo];
    
    // 未读消息
    //    [self customUnReadNumber:uiInfo];
    
    // 测试模式
#ifdef DEBUG
    [ZCSobot setShowDebug:YES];
#else
    [ZCSobot setShowDebug:NO];
#endif
    
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    
    return uiInfo;
}
//  初始化配置信息
- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = SobotKitAppKey;
    initInfo.titleType = @"2";
    initInfo.customTitle = @"客服";
    //    initInfo.skillSetId = _groupIdTF.text;
    //    initInfo.skillSetName = _groupNameTF.text;
    //    initInfo.receptionistId = _aidTF.text;
    //    initInfo.robotId = _robotIdTF.text;
    //    initInfo.tranReceptionistFlag = _aidTurn;
    //    initInfo.scopeTime = [_historyScopeTF.text intValue];
}
// 自定义用户信息参数
- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    DloginData * info = [JJWLogin sharedMethod].loginData;
    initInfo.userId         = info.user_id;
    //    initInfo.email        = [user valueForKey:@"email"];
    //    initInfo.avatarUrl    = [user valueForKey:@"avatarUrl"];
    //    initInfo.sourceURL    = [user valueForKey:@"sourceURL"];
    //    initInfo.sourceTitle  = [user valueForKey:@"sourceTitle"];
    //    initInfo.serviceMode  = _type;
    
    // 以下字段为方便测试使用，上线打包时注掉
    initInfo.phone       = info.mobile;
    initInfo.nickName    = info.nickname;
    // 微信，微博，用户的真实昵称，生日，备注性别 QQ号
    // 生日字段用户传入的格式，例：20170323，如果不是这个格式，初始化接口会给过滤掉
    //    initInfo.qqNumber = [user valueForKey:@"qqNumber"];
    //    initInfo.userSex = [user valueForKey:@"userSex"];
    initInfo.realName = info.nickname;
    //    initInfo.weiBo = [user valueForKey:@"weiBo"];
    //    initInfo.weChat = [user valueForKey:@"weChat"];
    //    initInfo.userBirthday = [user valueForKey:@"userBirthday"];
    //    initInfo.userRemark = [user valueForKey:@"userRemark"];
    //     initInfo.customInfo = @{
    //                            @"标题1":@"自定义1",
    //                            @"内容1":@"我是一个自定义字段。",
    //                            @"标题2":@"自定义字段2",
    //                            @"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",
    //                            @"标题3":@"自定义字段字段3",
    //                            @"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",
    //                            @"标题4":@"自定义4",
    //                            @"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"
    //                            };
    
}

// 设置UI部分
-(void) customerUI:(ZCKitInfo *) kitInfo{
    kitInfo.isCloseAfterEvaluation = YES;
    // 点击返回是否触发满意度评价（符合评价逻辑的前提下）
    kitInfo.isOpenEvaluation = NO;
    // 如果isShowTansfer=NO 通过记录机器人未知说辞的次数，设置显示转人工按钮，默认1次;
    //    kitInfo.unWordsCount = _robotUnknowCount.text;
    // 是否显示语音按钮
    kitInfo.isOpenRecord = YES;
    
    // 是否显示转人工按钮
    kitInfo.isShowTansfer    = YES;
    // 评价完人工是否关闭会话
    kitInfo.isCloseAfterEvaluation = YES;
    
    /**
     *  自定义信息
     */
    // 顶部导航条标题文字 评价标题文字 系统相册标题文字 评价客服（立即结束 取消）按钮文字
    //    kitInfo.titleFont = [UIFont systemFontOfSize:30];
    
    // 返回按钮      输入框文字   评价客服是否有以下情况 label 文字  提价评价按钮
    //    kitInfo.listTitleFont = [UIFont systemFontOfSize:22];
    
    //没有网络提醒的button 没有更多记录label的文字    语音tipLabel的文字   评价不满意（4个button）文字  占位图片的lablel文字   语音输入时间label文字   语音输入的按钮文字
    //    kitInfo.listDetailFont = [UIFont systemFontOfSize:25];
    
    // 录音按钮的文字
    //    kitInfo.voiceButtonFont = [UIFont systemFontOfSize:25];
    // 消息提醒 （转人工、客服接待等）
    //    kitInfo.listTimeFont = [UIFont systemFontOfSize:22];
    
    // 聊天气泡中的文字
    //    kitInfo.chatFont  = [UIFont systemFontOfSize:22];
    
    // 聊天的背景颜色
    //    kitInfo.backgroundColor = [UIColor redColor];
    
    // 导航、客服气泡、线条的颜色
    kitInfo.customBannerColor  = JJWThemeColor;
    
    // 左边气泡的颜色
    //        kitInfo.leftChatColor = [UIColor redColor];
    
    // 右边气泡的颜色
    //        kitInfo.rightChatColor = [UIColor redColor];
    
    // 底部bottom的背景颜色
    //    kitInfo.backgroundBottomColor = [UIColor redColor];
    
    // 底部bottom的输入框线条背景颜色
    //    kitInfo.bottomLineColor = [UIColor redColor];
    
    // 提示气泡的背景颜色
    //    kitInfo.BgTipAirBubblesColor = [UIColor redColor];
    
    // 顶部文字的颜色
    //    kitInfo.topViewTextColor  =  [UIColor redColor];
    
    // 提示气泡文字颜色
    //        kitInfo.tipLayerTextColor = [UIColor redColor];
    
    // 评价普通按钮选中背景颜色和边框(默认跟随主题色customBannerColor)
    //        kitInfo.commentOtherButtonBgColor=[UIColor redColor];
    
    // 评价(立即结束、取消)按钮文字颜色(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonColor = [UIColor redColor];
    
    //评价提交按钮背景颜色和边框(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonBgColor = [UIColor redColor];
    
    //    评价提交按钮点击后背景色，默认0x089899, 0.95
    //    kitInfo.commentCommitButtonBgHighColor = [UIColor yellowColor];
    
    // 左边气泡文字的颜色
    //    kitInfo.leftChatTextColor = [UIColor redColor];
    
    // 右边气泡文字的颜色[注意：语音动画图片，需要单独替换]
    //    kitInfo.rightChatTextColor  = [UIColor redColor];
    
    // 时间文字的颜色
    //    kitInfo.timeTextColor = [UIColor redColor];
    
    // 客服昵称颜色
    //        kitInfo.serviceNameTextColor = [UIColor redColor];
    
    
    // 提交评价按钮的文字颜色
    //    kitInfo.submitEvaluationColor = [UIColor redColor];
    
    // 相册的导航栏背景颜色
    
    //    kitInfo.imagePickerColor = _selectedColor;
    // 相册的导航栏标题的文字颜色
    //    kitInfo.imagePickerTitleColor = [UIColor redColor];
    
    // 左边超链的颜色
    //        kitInfo.chatLeftLinkColor = [UIColor blueColor];
    
    // 右边超链的颜色
    //        kitInfo.chatRightLinkColor =[UIColor redColor];
    
    // 提示客服昵称的文字颜色
    //    kitInfo.nickNameTextColor = [UIColor redColor];
    // 相册的导航栏是否设置背景图片(图片来自SobotKit.bundle中ZCIcon_navcBgImage)
    //    kitInfo.isSetPhotoLibraryBgImage = YES;
    
    // 富媒体cell中线条的背景色
    //    kitInfo.LineRichColor = [UIColor redColor];
    
    //    // 语音cell选中的背景颜色
    //    kitInfo.videoCellBgSelColor = [UIColor redColor];
    //
    //    // 商品cell中标题的文字颜色
    //    kitInfo.goodsTitleTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中摘要的文字颜色
    //    kitInfo.goodsDetTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中标签的文字颜色
    //    kitInfo.goodsTipTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中发送的文字颜色
    //    kitInfo.goodsSendTextColor = [UIColor redColor];
    
    // 发送按钮的背景色
    //        kitInfo.goodSendBtnColor = [UIColor yellowColor];
    
    // “连接中。。。”  button 的背景色和文字的颜色
    //    kitInfo.socketStatusButtonBgColor  = [UIColor yellowColor];
    //    kitInfo.socketStatusButtonTitleColor = [UIColor redColor];
    
    
    //    kitInfo.notificationTopViewLabelFont = [UIFont systemFontOfSize:20];
    //    kitInfo.notificationTopViewLabelColor = [UIColor yellowColor];
    //    kitInfo.notificationTopViewBgColor = [UIColor redColor];
    
    // 评价 已解决 未解决的 颜色
    //    kitInfo.satisfactionSelectedBgColor = [UIColor redColor];
    //    kitInfo.satisfactionTextSelectedColor = [UIColor blueColor];
    
    
}

// 未读消息数
- (void)customUnReadNumber:(ZCKitInfo *)uiInfo{
    // 未读消息
    //    _unReadMsgCount.hidden = YES;
    //    _unReadMsgCount.text = @"0";
    //    [ZCLibClient getZCLibClient].receivedBlock = ^(id obj,int unRead){
    //        NSLog(@"当前消息数：%d \n %@",unRead,obj);
    //        if(unRead>0){
    //            _unReadMsgCount.hidden = NO;
    //            _unReadMsgCount.text = [NSString stringWithFormat:@"%d",unRead];
    //        }else{
    //            _unReadMsgCount.hidden = YES;
    //            _unReadMsgCount.text = @"0";
    //        }
    //    };
    
}

@end
