//
//  BaseWebController.m
//  CollectFans
//
//  Created by 李威 on 16/12/9.
//  Copyright © 2016年 liwei. All rights reserved.
//

#import "BaseWebController.h"
#import "BaseTabbarController.h"
#import "LSNavigationController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "ShareView.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ArbitrarilyTool.h"

NSString *wx_pay = @"wxpay"; // 微信支付
NSString *share_class = @"share"; // 分享
NSString *tel_class = @"tel"; // 电话
NSString *pay_class = @"pay"; // 支付

@interface BaseWebController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler> {
    NSDictionary *_shareDic;
}

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation BaseWebController

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:YES];
    
    [self deleteWebCache];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.wkWebView evaluateJavaScript:@"WEB__reload()" completionHandler:^(id _Nullable item, NSError * _Nullable error) {

    }];
}
- (void)backAction {
    //判断是否能返回到H5上级页面
    
    if (self.wkWebView.canGoBack == YES) {
        //返回上级页面
        [self.wkWebView goBack];

    } else {
        //退出控制器
        [self closeAction];

    }

}

- (UIProgressView *)progressView {
    
    if (!_progressView) {
        
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, NaviH+StatusHeight, kScreenWidth, 3)];
        _progressView.backgroundColor = [UIColor grayColor];
        _progressView.progressTintColor = MainTopColor;
        
    }
    
    return _progressView;
}
- (WKWebView *)wkWebView {
    
    if (!_wkWebView) {
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [[WKPreferences alloc] init];
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        config.userContentController = [[WKUserContentController alloc] init];
        config.processPool = [[WKProcessPool alloc] init];
        
        [config.userContentController addScriptMessageHandler:self name:@"JAMS__mark"];
       
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NaviH+StatusHeight, kScreenWidth, kScreenHeight-NaviH-StatusHeight-SafeAreaH) configuration:config];
        
        for (UIScrollView* view in _wkWebView.subviews) {
            
            if ([view isKindOfClass:[UIScrollView class]]) {
                
                view.bounces = NO;
            }
        }
        
        _wkWebView.backgroundColor = [UIColor whiteColor];
        
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.UIDelegate = self;
        
        [_wkWebView setOpaque:NO];
        
    }
    
    return _wkWebView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySuccNotiAction) name:PAY_SUCC_NOTI object:nil];
   
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 0, 40, 44);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:BundleTabeImage(@"web_close.png") forState:UIControlStateNormal];
    [button setImage:BundleTabeImage(@"web_close.png") forState:UIControlStateNormal | UIControlStateHighlighted];
    button.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 12, 20);
    [button addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationBar addSubview:button];
    
    [self.view addSubview:self.wkWebView];
    
    [self.view addSubview:self.progressView];
    
    // 通过监听estimatedProgress可以获取它的加载进度 还可以监听它的title ,URL, loading
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    NSString *url;

//    if ([_urlStr containsString:Qz_Zm] || [_urlStr containsString:Qz_Cz]) {
//        if ([_urlStr containsString:@"?"]) {
//            url = [NSString stringWithFormat:@"%@&user_id=%@&api_token=%@&api_type=2&source_type=1&api_id=%@",_urlStr,Encrypt_Id,Api_Token,Api_Id];
//        }else {
//            url = [NSString stringWithFormat:@"%@?user_id=%@&api_token=%@&api_type=2&source_type=1&api_id=%@",_urlStr,Encrypt_Id,Api_Token,Api_Id];
//        }
//
//    } else {
//        url = _urlStr;
//    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [self.wkWebView loadRequest:request];
   
}
//退出控制器
- (void)closeAction {
    
//    if ([StorageManager objForKey:Web_Pay]) {
//        [StorageManager setObj:nil forKey:Web_Pay];
//    }
//
//    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
//
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"JAMS__mark"];
//
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:PAY_SUCC_NOTI object:nil];
//
//    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)paySuccNotiAction {
    
    [LJCProgressHUD showStatueText:@"支付成功"];
    
    [self.wkWebView evaluateJavaScript:@"WEB__reload('pay')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
    }];
    
}
- (void)deleteWebCache {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                
                                WKWebsiteDataTypeDiskCache,
                                
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                
                                WKWebsiteDataTypeMemoryCache,
                                
                                //WKWebsiteDataTypeLocalStorage,
                                
                                //WKWebsiteDataTypeCookies,
                                
                                //WKWebsiteDataTypeSessionStorage,
                                
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                
                                //WKWebsiteDataTypeWebSQLDatabases
                                
                                ]];
        
        //// All kinds of data
        
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
            
        }];
        
    } else {
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        
        NSError *errors;
        
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
     
    }
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
        
    } else if ([keyPath isEqualToString:@"title"]) {
        
        
        
    } else if ([keyPath isEqualToString:@"URL"]) {
        
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progressView.progress = self.wkWebView.estimatedProgress;
        
    }
    
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        
        if (newprogress == 1) {
            
            self.progressView.hidden = YES;
            
            [self.progressView setProgress:0 animated:NO];
            
        } else {
            
            self.progressView.hidden = NO;
            
            [self.progressView setProgress:newprogress animated:YES];
            
        }
    }
}

- (void)setLoadCount:(NSUInteger)loadCount {
    
    if (!loadCount) {
        
        loadCount = 0;
    }
    
    _loadCount = loadCount;
    
    if (loadCount == 0) {
        
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
        
    }else {
        
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        
        if (newP > 0.95) {
            
            newP = 0.95;
            
        }
        
        [self.progressView setProgress:newP animated:YES];
        
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
//        NSLog(@"---%@",message.body);
    if ([message.name isEqualToString:@"JAMS__mark"]) {

        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *msgDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
         if ([msgDic[@"type"] isEqualToString:share_class]) {
            //
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(kScreenWidth-60, NaviH+StatusHeight, 60, 44);
            [button setImage:BundleTabeImage(@"share_btn_icon.png") forState:UIControlStateNormal];
            [button setImage:BundleTabeImage(@"share_btn_icon.png") forState:UIControlStateNormal | UIControlStateHighlighted];
            button.imageEdgeInsets = UIEdgeInsetsMake(9.5f, 20, 9.5f, 15);
            [button addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
             
             _shareDic = msgDic;
           
        } else {
            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
            
        }
        
        if ([msgDic[@"type"] isEqualToString:tel_class]) {
            
            NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",msgDic[@"phone"]];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        } else if ([msgDic[@"type"] isEqualToString:pay_class]) {
//            NSLog(@"----%@",msgDic);
//            [StorageManager setObj:@"1" forKey:Web_Pay];
//            if ([msgDic[@"method"] isEqualToString:wx_pay]) {
//
//                [LJCNetWorking POST_URL:Get_Bespeak_Pay params:@{@"typeid":msgDic[@"id"],@"method":msgDic[@"method"],@"type":msgDic[@"money_type"],@"extra_param":msgDic[@"extra_param"]} dataBlock:^(id data) {
//
//                    if (data) {
//
//                        if ([msgDic[@"method"] isEqualToString:wx_pay]) {
//
//                            LWHPDPaymentWeiXinPayModel *model = [LWHPDPaymentWeiXinPayModel modelWithDictionary:data[@"data"][@"sign"]];
//                            PayReq *request = [[PayReq alloc] init];
//                            request.partnerId = model.partnerid;//商户号
//                            request.prepayId= model.prepayid;//预支付交易会话
//                            request.package = model.package;
//                            request.nonceStr= model.noncestr;//随机字符串
//                            request.timeStamp= model.timestamp;//时间戳
//                            request.sign= model.sign;//签名
//                            [WXApi sendReq:request];
//
//                        } else {
//
//                            [[AlipaySDK defaultService] payOrder:[NSString stringWithFormat:@"%@",data[@"data"][@"response"]] fromScheme:AliPay_UrlSchemes callback:^(NSDictionary *resultDic) {
//
//                            }];
//
//                        }
//
//
//                    }
//                }];
//
//            } else {
//
//            }
            
        } else if ([msgDic[@"type"] isEqualToString:@"tiaozhuan"]) {
            
            NSString *str = msgDic[@"ios_tiaozhuan"];
            
            NSData *dicData = [str dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:dicData options:NSJSONReadingMutableContainers error:nil];

            if ([dataDic[@"webUrl"] isEmptyString]) {
                
                if ([dataDic[@"className"] isEqualToString:@"ConversationViewController"]) {
                    
                } else {
                    [ArbitrarilyTool atWillPush:dataDic[@"className"] withModelName:dataDic[@"modelName"] withModelParam:dataDic[@"modelParamName"] dic:dataDic[@"param"]];
                }
                
            } else {
                
                BaseWebController *web = [[BaseWebController alloc]init];
                web.urlStr = dataDic[@"webUrl"];
                web.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:web animated:YES];
                
            }
            
        }
        
    }
    
}
- (void)rightItemAction {

    if (!_shareDic) {
        
        return;
    }
    
    [ShareView shareViewManager].shareParam = _shareDic;
    
    [[ShareView shareViewManager] showShareView];
    
}

#pragma - mark WKWebViewDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    _loadCount++;
  
}
// 内容返回时
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    _loadCount --;
}
//失败
- (void)webView:(WKWebView *)webView didFailNavigation: (null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
    _loadCount --;
   
}

// 已经加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    if (!self.title) {
        
        self.title = self.wkWebView.title;
    }

    self.progressView.hidden = YES;
  
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSLog(@"111111111");
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];

    }
    
    return nil;
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
//    NSString *regex =@"[a-zA-z]+://[^\\s]*";
//
//    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//
//    if ([urlTest evaluateWithObject:message] && [message containsString:URL_YM] && [message containsString:@".jpg"]) {
//
//        ShareViewController *share = [[ShareViewController alloc]init];
//        share.imgUrl = message;
//        BaseNaviController *navi = [[BaseNaviController alloc]initWithRootViewController:share];
//
//        [self presentViewController:navi animated:YES completion:nil];
//
//        completionHandler();
//
//        return;
//    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
}
@end
