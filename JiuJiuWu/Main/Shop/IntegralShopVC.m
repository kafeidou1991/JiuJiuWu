//
//  IntegralShopVC.m
//  JiuJiuWu
//
//  Created by 张竟巍 on 2018/6/13.
//  Copyright © 2018年 付志敏. All rights reserved.
//

#import "IntegralShopVC.h"
#import "ScrollLabelHelp.h"

@interface IntegralShopVC ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) UIView * statusView;;
@end

@implementation IntegralShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self.view addSubview:self.statusView];
    self.webView.frame = CGRectMake(0, STATUS_BAR_HEIGHT, SCreenWidth, SCreenHegiht - kTabBarHeight - STATUS_BAR_HEIGHT);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:kLoginSuccess object:nil];
    
}
- (void)loginSuccess {
    [self afterProFun];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadWebView:self.urlString];
}

-(void)reloadWebView:(NSString *)url {
    if (STRISEMPTY(url)) {
        return;
    }
    self.urlString = url;
    NSURL *URL = [NSURL URLWithString:self.urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    //需要本地组装 cookie
    [self addCookies:URL];
    
    [self.webView loadRequest:request];
}
- (void)addCookies:(NSURL *)URL{
    NSString *  cookieStr = self.responseObject[@"cookie"];
    NSArray * arr = [cookieStr componentsSeparatedByString:@";"];
    NSMutableArray *myMuArr=[NSMutableArray array];
    for (NSString * ss in arr) {
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        
        
        NSArray * array = [ss componentsSeparatedByString:@"="];
        [cookieProperties setObject:array[0] forKey:NSHTTPCookieName];
        
        [cookieProperties setObject:array[1] forKey:NSHTTPCookieValue];
        [cookieProperties setObject:@"shop.jiujiuwu.cn" forKey:NSHTTPCookieDomain];
        
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        
        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
        
        NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:cookieProperties];
        
        [myMuArr addObject:cookie1];
        
    }
    NSArray *mmmArr=[NSArray arrayWithArray:myMuArr];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:mmmArr forURL:URL mainDocumentURL:URL];
}
//设置导航栏隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHome = [viewController isKindOfClass:[self class]];
    [navigationController setNavigationBarHidden:isHome animated:YES];
}
-(void)afterProFun {
    [self hudShow:self.view msg:STTR_ater_on];
    NSDictionary * dict = @{@"token":[JJWLogin sharedMethod].loginData.token};
    WeakSelf
    [JJWNetworkingTool PostWithUrl:ShopLogin params:dict isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf hudclose];
        weakSelf.responseObject = responseObject;
        NSString * url = [responseObject objectForKey:@"data"][@"redirect"];
        if (!STRISEMPTY(url)) {
            [weakSelf reloadWebView:url];
        }else {
            [weakSelf jxt_showAlertWithTitle:@"温馨提示" message:@"商城链接为空" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.addActionDefaultTitle(@"我知道了");
            } actionsBlock:nil];
        }
        
    } failed:^(NSError *error, id chaceResponseObject) {
        [weakSelf hudclose];
        [JJWBase alertMessage:error.domain cb:nil];
        if ([error.domain containsString:@"未激活!"]) {
            self.responseObject = @{@"cookie": error.userInfo[@"result"][@"cookie"],};
            NSString * url = [error.userInfo[@"result"] objectForKey:@"data"][@"redirect"];
            if (!STRISEMPTY(url)) {
                [weakSelf reloadWebView:url];
            }
        }else {
            [weakSelf loadLocalHTMLString:@"404"];
        }
    }];
}
-(UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCreenWidth, STATUS_BAR_HEIGHT)];
        _statusView.backgroundColor = JJWThemeColor;
    }
    return _statusView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
