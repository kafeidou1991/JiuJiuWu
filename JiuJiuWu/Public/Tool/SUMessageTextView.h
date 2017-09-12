//
//  SUMessageTextView.h
//  wyzc
//
//  Created by sunjun on 14-8-6.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (MessageInputView)

- (NSString *)stringByTrimingWhitespace;


- (NSUInteger)numberOfLines;


@end


@interface SUMessageTextView : UITextView
/**
 *  是否带输入框上面的箭头（用于消失键盘）（zhang）
 */
-(void)addTool;
/**
 *  提示用户输入的标语
 */
@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic, strong) UIFont * placeHolderFont;

/**
 *  标语文本的颜色
 */
@property (nonatomic, strong) UIColor *placeHolderTextColor;

/**
 *  获取自身文本占据有多少行
 *
 *  @return 返回行数
 */
- (NSUInteger)numberOfLinesOfText;

/**
 *  获取每行的高度
 *
 *  @return 根据iPhone或者iPad来获取每行字体的高度
 */
+ (NSUInteger)maxCharactersPerLine;

/**
 *  获取某个文本占据自身适应宽带的行数
 *
 *  @param text 目标文本
 *
 *  @return 返回占据行数
 */
+ (NSUInteger)numberOfLinesForMessage:(NSString *)text;



@end
