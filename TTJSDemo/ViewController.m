//
//  ViewController.m
//  TTJSDemo
//
//  Created by zhang liangwang on 17/3/16.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "ViewController.h"

#import "TTProgressView.h"

#import "KeychainItemWrapper.h"
#import "NSObject+Extensions.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webview;

@end

@implementation ViewController

// 横竖屏切换
//note: viewWillLayoutSubviews只能用在ViewController里，在view里面没有响应
//- (void)viewWillLayoutSubviews {
//    
//    [self shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
//}
//
//
//- (void)shouldRotateToOrientation:(UIDeviceOrientation)orientation {
//    
//    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
//        
//        //竖屏
//        
//    } else {
//        
//        //横屏
//    }
//    
//}

/*
typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
    UIDeviceOrientationUnknown,
    UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
    UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
    UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
    UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
    UIDeviceOrientationFaceUp,              // Device oriented flat, face up
    UIDeviceOrientationFaceDown             // Device oriented flat, face down
} __TVOS_PROHIBITED;
*/






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.webview.delegate = self;
    self.webview.scalesPageToFit = true;
    [self.view addSubview:self.webview];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"]]];
    
}
//
- (void)call:(NSString *)param1 param2:(NSString *)param2 {
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    NSLog(@"success---param1%@----param2%@",param1,param2);
}


//MARK:- UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"--webViewDidStartLoad-");
    
    
}

//MARK:-OC调用JS
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSLog(@"--title--%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title;"]);
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    // OC调用JS
//    [webView stringByEvaluatingJavaScriptFromString:@"login();"];

//    NSLog(@"----str---%@",str);
}

//MARK:-JS调用OC
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // 拿到全路径
    NSString *url = request.URL.absoluteString;
    NSString *scheme = @"tomtop://"; //截取路径头(事先定义好的)
    if ([url hasPrefix:scheme]){
        // 拿到scheme后面的路径 path = call_param2_?param1&param2
        NSString *path = [url substringFromIndex:scheme.length];
        // ?分割路径
        NSArray *subpaths = [path componentsSeparatedByString:@"?"];
        // 方法名
        NSString *methodName = [[subpaths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        // 方法参数
        NSArray *params = nil;
        if (subpaths.count == 2) { //表示有参数
            params = [[subpaths lastObject] componentsSeparatedByString:@"&"];
        }
        
        [self performSelector:NSSelectorFromString(methodName) withObjects:params];
        
        return false;
    };
    
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}































































@end
