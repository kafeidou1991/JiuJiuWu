//
//  JJWMarco.h
//  JiuJiuWu
//
//  Created by 付志敏 on 17/12/27.
//  Copyright © 2017年 张竟巍. All rights reserved.
//

#ifndef JJWMarco_h
#define JJWMarco_h


#define kJJWSmallMargin 4
#define kJJWDefaultMargin 8
#define kJJWUIMargin 15

#define kJJWBackgroundColor [UIColor qmui_colorWithHexString:@"#f5f5f5"]
#define kJJWTitleColor [UIColor qmui_colorWithHexString:@"#333333"]
#define kJJWContenColor [UIColor qmui_colorWithHexString:@"#666666"]
#define kJJWTagColor [UIColor qmui_colorWithHexString:@"#999999"]
#define kJJWSeparatorColor [UIColor qmui_colorWithHexString:@"#e7eaf1"]

#define kJJWLabel_NoData @"无"

/**判空*/
#define kJJWStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define kJJWNumberIsEmpty(num) ([num isKindOfClass:[NSNull class]] || num == nil)
#define kJJWArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kSCTDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.count == 0)

#define UIFont_PFSCR_Make(size) [JJWCommonHelper pingFang_SC_RegularSize:size]
#define UIFont_PFSCB_Make(size) [JJWCommonHelper pingFang_SC_BoldSize:size]

#define JJWUserDefaultCofigKit  [JJWUserDefaultTool getInstall]

#define PGY_AppId @"b07a857097c4a1500d9a56d1e405c3a6"

#define JJWViewBorderRadius(view,radius)\
[view.layer setCornerRadius:(radius)];\
[view.layer setMasksToBounds:YES];

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IS_IOS_11 (IOS_VERSION >= 11.0 ? YES : NO)

//文件
#define JJWImageMake(img) [UIImage imageNamed:img]
#define JJWImageFile(filePath,imageType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:filePath ofType:imageType]]

//相关H5连接
//升级
#define JJWApplyForCreditCardURL @"http://www.jiujiuwu.cn/mobile/share/credit_apply"

#endif /* JJWMarco_h */
