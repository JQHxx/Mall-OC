//
//  MineViewController.m
//  Mall
//
//  Created by midland on 2019/8/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "MineViewController.h"
#import "BaseWebBrowserViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface MineViewController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
{
    UILabel *label;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"我的";
    // [self setupUI];
    
    // 1. 创建Sign in with Apple Button
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDButton *button = [[ASAuthorizationAppleIDButton alloc]init];
        button.frame = CGRectMake(30, self.view.bounds.size.height - 180, self.view.bounds.size.width - 60, 50);

        [button addTarget:self action:@selector(handleAuthorization) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // `handleAuthorization`的实现参阅：2. 跟用户提出授权请求.
        // 创建好button后，可以安装需求安装到所需的位置， 比如 self.view.addSubview(button)

    } else {
        // Fallback on earlier versions
    }
    
}

// 2. 跟用户提出授权请求.
- (void) handleAuthorization {
    if (@available(iOS 13.0, *)) {
        // 基于用户的Apple ID授权用户，生成用户授权请求的一种机制
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        // 创建新的AppleID 授权请求
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        // 在用户授权期间请求的联系信息
        appleIDRequest.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        // 由ASAuthorizationAppleIDProvider创建的授权请求 管理授权请求的控制器
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest]];
        // 设置授权控制器通知授权请求的成功与失败的代理
        authorizationController.delegate = self;
        // 设置提供 展示上下文的代理，在这个上下文中 系统可以展示授权界面给用户
        authorizationController.presentationContextProvider = self;
        // 在控制器初始化期间启动授权流
        [authorizationController performRequests];
    } else {
        // iOS13以前的版本不支持， 用户界面可以提示
    }
}


- (void) setupUI {
    self.view.backgroundColor = [UIColor adaptColor:[UIColor redColor] darkColor:[UIColor blackColor]];
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    label.text = @"ViewController 跟随手机进行暗黑适配";
    label.font = [UIFont systemFontOfSize:20.0];
    label.numberOfLines = 0;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"objc"];
    [array addObject:@"swift"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"key"] = @"value";
    // dict[@"itmes"] = array;
    NSString *json = [JSONUtil queryStringFrom:dict];
    NSLog(@"json: %@", json);
    json = [JSONUtil clearParams:json];
    NSLog(@"json: %@", json);
    
    
    NSString *json1 = [JSONUtil dictToJSON:dict];
    NSLog(@"json1: %@", json1);
    json1 = [JSONUtil clearParams:json1];
    NSLog(@"json2: %@", json1);
    
    /*
    BaseWebBrowserViewController *webVC = [[BaseWebBrowserViewController alloc]init];
    [webVC loadWeb:@"https://www.baidu.com" loadType: WKWebViewLoadTypeRemote title:@"百度首页"];
    [self.navigationController pushViewController:webVC animated:YES];
     */
}

// 系统模式切换才会改变
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    NSLog(@"traitCollectionDidChange");
    
    self.view.backgroundColor = [UIColor adaptColor:[UIColor redColor] darkColor:[UIColor blackColor]];
    // label.textColor = [UIColor adaptColor:[UIColor redColor] darkColor:[UIColor darkGrayColor]];

}

// 单个界面不遵循暗黑模式
//- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
//    return [DarkModel isDarkMode] ? UIUserInterfaceStyleDark : UIUserInterfaceStyleLight;
//}


#pragma mark - ASAuthorizationControllerPresentationContextProviding
- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return self.view.window;
}

#pragma mark - ASAuthorizationControllerDelegate
// 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    // 请求完成，但是有错误
    NSLog(@"Handle error：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"授权请求失败未知原因";
            break;
            
        default:
            break;
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    
    // 用户登录使用ASAuthorizationAppleIDCredential
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        // 拿到用户的验证信息，这里可以跟自己服务器所存储的信息进行校验，比如用户名是否存在等。
        /*
         用户emai: credential.email
         用户名信息：credential.fullName
         苹果提供的用户ID：credential.user
         验证信息状态：credential.state
         refresh token: let code = credential.authorizationCode, let codeStr = String(data: code, encoding: .utf8)
         access token: let idToken = credential.identityToken, let tokeStr = String(data: idToken, encoding: .utf8)
         */
        
        ASAuthorizationAppleIDCredential *appleIDCredential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        NSString *user = appleIDCredential.user;
        // NSString *familyName = appleIDCredential.fullName.familyName;
        // NSString *givenName = appleIDCredential.fullName.givenName;
        // NSString *email = appleIDCredential.email;
        // keychain 保存user
        //  需要使用钥匙串的方式保存用户的唯一信息
        [YostarKeychain save:KEYCHAIN_IDENTIFIER(@"userIdentifier") data:user];
        NSLog(@"%@", user);
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        
        // Sign in using an existing iCloud Keychain credential.
          // 用户登录使用现有的密码凭证
          ASPasswordCredential *passwordCredential = (ASPasswordCredential *)authorization.credential;
          // 密码凭证对象的用户标识 用户的唯一标识
          NSString *user = passwordCredential.user;
          // 密码凭证对象的密码
          NSString *password = passwordCredential.password;
          NSLog(@"%@ %@", user, password);
    } else {
        NSLog(@"授权信息均不符");
    }
}

@end
