//
//  XYAlertViewManager.m
//  DDMates
//
//  Created by Samuel Liu on 7/25/12.
//  Copyright (c) 2012 TelenavSoftware, Inc. All rights reserved.
//

#import "XYAlertViewManager.h"
#import "XYLoadingView.h"
#import "XYAlertView.h"
#import "UIImage+load.h"
#import "UIView+cate.h"

#define AlertViewWidth 280.0f
//#define AlertViewHeight 175.0f
CGFloat AlertViewHeight = 175.f;

CGRect XYScreenBounds()
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    if (UIDeviceOrientationUnknown == orient)
        orient = UIInterfaceOrientationPortrait;

    if (UIInterfaceOrientationIsLandscape(orient))
    {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}

@implementation XYAlertViewManager

static XYAlertViewManager *sharedAlertViewManager = nil;

+(XYAlertViewManager*)sharedAlertViewManager
{
    @synchronized(self)
    {
        if(!sharedAlertViewManager)
            sharedAlertViewManager = [[XYAlertViewManager alloc] init];
    }
    
    return sharedAlertViewManager;
}

-(id)init 
{
    self = [super init];
    if(self)
    {
        _alertViewQueue = [[NSMutableArray alloc] init];
        _isDismissing = NO;
    }
    
    return self;
}

-(void)dealloc
{
    [_alertViewQueue removeAllObjects];
    [_loadingTimer invalidate];
}

#pragma mark - private

-(UIImage*)buttonImageByStyle:(XYButtonStyle)style state:(UIControlState)state
{
    switch(style)
    {
        default:
        case XYButtonStyleGray:
            return [[UIImage imageNamed:(state == UIControlStateNormal ? @"alertView_button_gray.png" : @"alertView_button_gray_pressed.png")] stretchableImageWithLeftCapWidth:22 topCapHeight:22];
        case XYButtonStyleGreen:
            return [[UIImage imageNamed:(state == UIControlStateNormal ? @"alertView_button_green.png" : @"alertView_button_green_pressed.png")] stretchableImageWithLeftCapWidth:22 topCapHeight:22];
    }
}

-(void)prepareLoadingToDisplay:(XYLoadingView*)entity
{
    CGRect screenBounds = XYScreenBounds();
    if(!_blackBG)
    {
        _blackBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
        _blackBG.backgroundColor = [UIColor blackColor];
        _blackBG.opaque = YES;
        _blackBG.alpha = 0.5f;
        _blackBG.userInteractionEnabled = YES;
    }
    
    _alertView = nil;
    _alertView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertView_loading.png"]];
    _alertView.center = CGPointMake(screenBounds.size.width / 2, screenBounds.size.height / 2);
    
    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, 30)];
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.backgroundColor = [UIColor clearColor];
    _loadingLabel.textColor = [UIColor whiteColor];
    _loadingLabel.font = [UIFont boldSystemFontOfSize:14];
    _loadingLabel.text = entity.message;
    _loadingLabel.numberOfLines = 2;
}

-(void)prepareAlertToDisplay:(XYAlertView*)entity
{
    CGRect screenBounds = XYScreenBounds();
    if(!_blackBG)
    {
        _blackBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
        _blackBG.backgroundColor = [UIColor blackColor];
        _blackBG.opaque = YES;
        _blackBG.alpha = 0.5f;
        _blackBG.userInteractionEnabled = YES;
    }
    
 //   CGSize customLabSize =

    
    CGSize msgSize = CGSizeMake(240, 60);
    msgSize = [entity.message boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
    CGFloat stup = msgSize.height - 60.f;
    AlertViewHeight = 200.f+stup;
    
    
    
    
    UIImage *image = [UIImage imageColor:[UIColor colorWithRed:255.f/255.f green:255/255.f blue:255/255.f alpha:1.f] size:CGSizeMake(AlertViewWidth, AlertViewHeight)];
    _alertView = nil;
    _alertView = [[UIImageView alloc] initWithImage:[image stretchableImageWithLeftCapWidth:10 topCapHeight:20]];
    //_alertView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"alertView_bg.png"] stretchableImageWithLeftCapWidth:34 topCapHeight:44]];
    _alertView.userInteractionEnabled = YES;
    _alertView.frame = CGRectMake(0, 0, AlertViewWidth, AlertViewHeight);
    _alertView.center = CGPointMake(screenBounds.size.width / 2, screenBounds.size.height / 2);
    [_alertView maskBound:0.1f radius:3.f brodercolor:[UIColor clearColor]];
    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _alertView.frame.size.width, 40)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = themeColor;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _titleLabel.text = entity.title;
    [_alertView addSubview:_titleLabel];
    
    UILabel *_messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, _titleLabel.frame.size.height + 5, _alertView.frame.size.width - 25*2, _alertView.frame.size.height - _titleLabel.frame.size.height - 55)];
    _messageLabel.textAlignment = NSTextAlignmentLeft;
    _messageLabel.backgroundColor = [UIColor clearColor];
    _messageLabel.textColor = UIColorFromRGB(0x313131);
    _messageLabel.font = [UIFont systemFontOfSize:14.0];
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.numberOfLines = 0;
    _messageLabel.text = entity.message;
    [_alertView addSubview:_messageLabel];

    UIImage *cancelImage = [UIImage imageNamed:@"cancelAlert"];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(_alertView.frame.size.width - cancelImage.size.width - 10, 10, cancelImage.size.width, cancelImage.size.height);
    [cancelBtn setImage:cancelImage forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 0;
    [_alertView addSubview:cancelBtn];
    /*
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(70, _alertView.frame.size.height - 30 - 10, _alertView.frame.size.width - 2*70, 30);
    sureBtn.layer.cornerRadius = 3.0f;
    sureBtn.layer.borderColor = [Config defaultConfig].themeColor.CGColor;
    sureBtn.layer.borderWidth = 0.5f;
    [sureBtn setTitleColor:[Config defaultConfig].themeColor forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.tag = 1;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [sureBtn addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:sureBtn];
    */
  
//    float buttonWidth =  (AlertViewWidth-1)*0.5f;// (AlertViewWidth - 100.0f) / entity.buttons.count;
    
    float buttonPadding = 10.0f;// 100.0f / (entity.buttons.count - 1 + 2 * 2);
    float buttonWidth = (AlertViewWidth - (entity.buttons.count+1)*buttonPadding)/entity.buttons.count;
    if (entity.buttons.count == 1) {
        buttonWidth = AlertViewWidth - 2*70;
    }
    CGFloat by = _messageLabel.frame.size.height+_messageLabel.frame.origin.y+5.f;
    CGFloat bh = AlertViewHeight-by;
    
    UIView *linev_X  = [[UIView alloc] initWithFrame:CGRectMake(0, by, AlertViewWidth, 0.5f)];
    linev_X.backgroundColor = [UIColor colorWithRed:166.f/255.f green:166.f/255.f blue:166.f/255.f alpha:1.f];
    
    UIView *linev_y  = [[UIView alloc] initWithFrame:CGRectMake(AlertViewWidth/2, by, 0.5f, bh)];
    linev_y.backgroundColor = [UIColor colorWithRed:166.f/255.f green:166.f/255.f blue:166.f/255.f alpha:1.f];
    
    for(int i = 0; i < entity.buttons.count; i++)
    {
        NSString *buttonTitle = [entity.buttons objectAtIndex:i];
       // XYButtonStyle style = [[entity.buttonsStyle objectAtIndex:i] intValue];

        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:buttonTitle forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _button.layer.cornerRadius = 3.0f;
        _button.layer.borderColor = themeColor.CGColor;
        _button.layer.borderWidth = 0.5f;
        [_button setTitleColor:themeColor forState:UIControlStateNormal];
       // _button.titleLabel.shadowOffset = CGSizeMake(1, 1);
        
//        [_button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_button setBackgroundImage:[self buttonImageByStyle:style state:UIControlStateNormal]
//                           forState:UIControlStateNormal];
//        [_button setBackgroundImage:[self buttonImageByStyle:style state:UIControlStateHighlighted]
//                           forState:UIControlStateHighlighted];
       
        [_button setBackgroundImage:image forState:UIControlStateNormal];
      //  [_button setBackgroundImage:[UIImage imageColor:[UIColor colorWithRed:136.f/255.f green:136.f/255.f blue:136.f/255.f alpha:1.f] size:CGSizeMake(buttonWidth, bh)] forState:UIControlStateNormal];
        if (entity.buttons.count == 1) {
            _button.frame = CGRectMake(70, by+1, _alertView.frame.size.width - 2*70, bh-buttonPadding);
        }else
            _button.frame = CGRectMake((buttonPadding + buttonWidth) * i + buttonPadding, by+1,
                                   buttonWidth, bh-buttonPadding);
        _button.tag = i;

        [_button addTarget:self action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:_button];
    }
    
//    [_alertView addSubview:linev_X];[_alertView addSubview:linev_y];

}

-(void)updateLoadingAnimation
{
    CGAffineTransform transform = _alertView.transform;
    transform = CGAffineTransformRotate(transform, M_PI / 20);
    _alertView.transform = transform;
}

-(void)checkoutInStackAlertView
{
    if(_alertViewQueue.count > 0)
    {
        id entity = [_alertViewQueue lastObject];

        [_loadingTimer invalidate];
        _loadingTimer = nil;
        [_alertView removeFromSuperview];
        [_blackBG removeFromSuperview];
        [_loadingLabel removeFromSuperview];
        
        if([entity isKindOfClass:[XYAlertView class]])
        {
            [self prepareAlertToDisplay:entity];
            [self showAlertViewWithAnimation:entity];
        }
        else if([entity isKindOfClass:[XYLoadingView class]])
        {
            [self prepareLoadingToDisplay:entity];
            [self showLoadingViewWithAnimation:entity];
        }
    }
}

-(void)onButtonTapped:(id)sender
{
    [self dismiss:[_alertViewQueue lastObject] button:(int)((UIButton*)sender).tag];
}

#pragma mark - animation

-(void)showAlertViewWithAnimation:(id)entity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    
    if([entity isKindOfClass:[XYAlertView class]])
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //    if(!keyWindow)
        {
            NSArray *windows = [UIApplication sharedApplication].windows;
            if(windows.count > 0) keyWindow = [windows lastObject];
    //            keyWindow = [windows objectAtIndex:0];
        }
        
        _blackBG.alpha = 0.0f;
        _blackBG.frame = keyWindow.frame;
        CGRect frame = _alertView.frame;
        frame.origin.y = -AlertViewHeight;
       // _alertView.frame = frame;
        _alertView.alpha = 0.f;
        _alertView.center = keyWindow.center;
        [keyWindow addSubview:_blackBG];
        [keyWindow addSubview:_alertView];
        
        [UIView animateWithDuration:0.2f animations:^{
            _blackBG.alpha = 0.5f;
            _alertView.alpha = 1.f;
            _alertView.center = keyWindow.center;
            //_alertView.center = CGPointMake(XYScreenBounds().size.width / 2, XYScreenBounds().size.height / 2);
        }
                         completion:^(BOOL finished) {
                             
                         }];
    }
    });
}

-(void)dismissAlertViewWithAnimation:(id)entity button:(int)buttonIndex
{
    if([entity isKindOfClass:[XYAlertView class]])
    {
        [UIView animateWithDuration:0.2f
                         animations:
         ^{
             _blackBG.alpha = 0.0f;
             _alertView.alpha = 0.f;
             CGRect frame = _alertView.frame;
             frame.origin.y = -AlertViewHeight;
            // _alertView.frame = frame;
         }
                         completion:^(BOOL finished)
         {
             [_alertView removeFromSuperview];
             [_blackBG removeFromSuperview];
             
             [_alertViewQueue removeLastObject];
             _isDismissing = NO;

             if(((XYAlertView*)entity).blockAfterDismiss)
                 ((XYAlertView*)entity).blockAfterDismiss(buttonIndex);

             [self checkoutInStackAlertView];
         }];
    }
}

-(void)showLoadingViewWithAnimation:(id)entity
{
    if([entity isKindOfClass:[XYLoadingView class]])
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //    if(!keyWindow)
        {
            NSArray *windows = [UIApplication sharedApplication].windows;
            if(windows.count > 0) keyWindow = [windows lastObject];
    //            keyWindow = [windows objectAtIndex:0];
        }
        
        _blackBG.alpha = 0.0f;
        CGRect frame = _alertView.frame;
        frame.origin.y = -AlertViewHeight;
        _alertView.center = keyWindow.center;
        _alertView.frame = frame;
        frame = _loadingLabel.frame;
        frame.origin.y = XYScreenBounds().size.height;
        _loadingLabel.frame = frame;
        [keyWindow addSubview:_blackBG];
        [keyWindow addSubview:_alertView];
        [keyWindow addSubview:_loadingLabel];
        
        _loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateLoadingAnimation) userInfo:nil repeats:YES];
        
        [UIView animateWithDuration:0.2f animations:^{
            _blackBG.alpha = 0.5f;
            _alertView.alpha = 1.f;
            _alertView.center = CGPointMake(XYScreenBounds().size.width / 2, XYScreenBounds().size.height / 2);
            CGRect frame = _loadingLabel.frame;
            frame.origin.y = _alertView.frame.origin.y + _alertView.frame.size.height + 10;
            _loadingLabel.frame = frame;
        }
                         completion:^(BOOL finished) {
                         }];
    }
}

-(void)dismissLoadingViewWithAnimation:(id)entity
{
    if([entity isKindOfClass:[XYLoadingView class]])
    {
        [UIView animateWithDuration:0.2f
                         animations:
         ^{
             _blackBG.alpha = 0.0f;
             CGRect frame = _alertView.frame;
             frame.origin.y = -AlertViewHeight;
             _alertView.frame = frame;
             frame = _loadingLabel.frame;
             frame.origin.y = XYScreenBounds().size.height;
             _loadingLabel.frame = frame;
         }
                         completion:^(BOOL finished)
         {
             [_loadingTimer invalidate];
             _loadingTimer = nil;
             [_alertView removeFromSuperview];
             [_blackBG removeFromSuperview];
             [_loadingLabel removeFromSuperview];

             [_alertViewQueue removeLastObject];

             _isDismissing = NO;

             [self checkoutInStackAlertView];
         }];
    }
}

#pragma mark - public

-(XYAlertView*)showAlertView:(NSString*)message
{
    XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"提醒"
                                                     message:message
                                                     buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                afterDismiss:nil];
    [self show:alertView];
    
    return alertView;
}

-(XYLoadingView*)showLoadingView:(NSString*)message
{
    XYLoadingView *loadingView = [XYLoadingView loadingViewWithMessage:message];
    [self show:loadingView];
    
    return loadingView;
}

-(void)show:(id)entity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    
    if([entity isKindOfClass:[XYAlertView class]] || [entity isKindOfClass:[XYLoadingView class]])
    {
        if(_isDismissing == YES && _alertViewQueue.count > 0)
        {
            [_alertViewQueue insertObject:entity atIndex:_alertViewQueue.count - 1];
        }
        else
        {
            [_alertViewQueue addObject:entity];
            
            [_loadingTimer invalidate];
            _loadingTimer = nil;
            [_alertView removeFromSuperview];
            [_blackBG removeFromSuperview];
            [_loadingLabel removeFromSuperview];
            
            if([entity isKindOfClass:[XYAlertView class]])
            {
                [self prepareAlertToDisplay:entity];
                [self showAlertViewWithAnimation:entity];
            }
            else if([entity isKindOfClass:[XYLoadingView class]])
            {
                [self prepareLoadingToDisplay:entity];
                [self showLoadingViewWithAnimation:entity];
            }
        }
    }
    });
}

-(void)dismiss:(id)entity
{
    [self dismiss:entity button:0];
}

-(void)dismiss:(id)entity button:(int)buttonIndex
{
    if(_alertViewQueue.count <= 0)
        return;

    if([entity isKindOfClass:[XYAlertView class]] || [entity isKindOfClass:[XYLoadingView class]])
    {
        _isDismissing = YES;
        
        if([entity isEqual:[_alertViewQueue lastObject]])
        {
            if([entity isKindOfClass:[XYAlertView class]])
                [self dismissAlertViewWithAnimation:entity button:buttonIndex];
            else if([entity isKindOfClass:[XYLoadingView class]])
                [self dismissLoadingViewWithAnimation:entity];
        }
        else
        {
            [_alertViewQueue removeObject:entity];
            if([entity isKindOfClass:[XYAlertView class]])
                ((XYAlertView*)entity).blockAfterDismiss(buttonIndex);
        }
    }
}

-(void)dismissLoadingView:(id)entity withFailedMessage:(NSString*)message
{
    if(_alertViewQueue.count <= 0)
        return;
    
    if([entity isEqual:[_alertViewQueue lastObject]] && [entity isKindOfClass:[XYLoadingView class]])
    {
        _isDismissing = YES;

        XYAlertView *alertView = [XYAlertView alertViewWithTitle:@"注意"
                                                         message:message
                                                         buttons:[NSArray arrayWithObjects:@"确定", nil]
                                                    afterDismiss:nil];
        
        [_alertViewQueue insertObject:alertView atIndex:_alertViewQueue.count - 1];

        [self dismissLoadingViewWithAnimation:entity];
    }
}

-(void)cleanupAllViews
{
    [_loadingTimer invalidate];
    _loadingTimer = nil;
    [_alertView removeFromSuperview];
    _alertView = nil;
    [_blackBG removeFromSuperview];
    [_loadingLabel removeFromSuperview];

    [_alertViewQueue removeAllObjects];
}

@end
