# Mall-OC


```
cookie

NSString *baseURL = @"";

- (void)login{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置自动管理Cookies
    //manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"account"] = @"";
    params[@"password"] = @"123456";
    [manager GET:[NSString stringWithFormat:@"%@%@", baseURL, @"/api/web/login/memberlogin"] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*
        // 获取 Cookie
        NSHTTPURLResponse *response =  (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaderFieldsDic = response.allHeaderFields;
        NSString *setCookie = allHeaderFieldsDic[@"Set-Cookie"];
        if (setCookie != nil) {
            NSString *cookie = [[setCookie componentsSeparatedByString:@";"] objectAtIndex:0];
            // 这里对cookie进行存储
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"cookie"];
        }
         */
        NSLog(@"%@", responseObject);
        //[self deleteCookie];
        [self collectData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)collectData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /*
    // 设置自动管理Cookies
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Set-Cookie"];
    }
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"productid"] = @"43";
    [manager GET:[NSString stringWithFormat:@"%@%@", baseURL, @"/api/web/room/product/getone"] parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 退出登录后清除cookie
- (void)deleteCookie {
    NSString * urlString = [NSString stringWithFormat:@"%@%@", baseURL, @"/api/web/login/memberlogin"];
    NSURL * url = [NSURL URLWithString:urlString];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    for (int i = 0; i < [cookies count]; i++) {
          NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
          //NSLog(@"cookie%@",cookie);
          [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}
```
