# Mall-OC


```
cookie

- (void)login{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置自动管理Cookies
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [manager POST:@"https://www.wanandroid.com/user/login?username=jqhee&password=123456" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 获取 Cookie
        NSHTTPURLResponse *response =  (NSHTTPURLResponse *)task.response;
        //NSLog(@"currentRequest: %@  task.response:%@", task.currentRequest.allHTTPHeaderFields, response.allHeaderFields[@"Set-Cookie"]);
        NSDictionary *allHeaderFieldsDic = response.allHeaderFields;
        NSString *setCookie = allHeaderFieldsDic[@"Set-Cookie"];
        if (setCookie != nil) {
            NSString *cookie = [[setCookie componentsSeparatedByString:@";"] objectAtIndex:0];
            // 这里对cookie进行存储
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:@"cookie"];
        }
        NSLog(@"%@", responseObject);
        [self collectData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)collectData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置自动管理Cookies
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    // 如果已有Cookie, 则把你的cookie符上
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"];
    if (cookie != nil) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Set-Cookie"];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [manager GET:@"https://www.wanandroid.com/lg/collect/list/0/json" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
```
