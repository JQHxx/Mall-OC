//
//  DMURLProtocol.m
//  Mall
//
//  Created by midland on 2019/9/27.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "DMURLProtocol.h"
#import "NSData+GZIP.h"
#import "DMURLSessionConfiguration.h"
#import "DMNetworkTrafficManager.h"
#import "TDNetworkTrafficLog.h"
#import "NSURLResponse+Core.h"
#import "NSURLRequest+Core.h"
#import "TDNetFlowDataSource.h"

static NSString *const DMHTTP = @"LPDHTTP";

@interface DMURLProtocol() <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLRequest *dm_request;
@property (nonatomic, strong) NSURLResponse *dm_response;
@property (nonatomic, strong) NSMutableData *dm_data;

@end

@implementation DMURLProtocol

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (void)start {
    DMURLSessionConfiguration *sessionConfiguration = [DMURLSessionConfiguration defaultConfiguration];
    for (id protocolClass in [DMNetworkTrafficManager manager].protocolClasses) {
        [NSURLProtocol registerClass:protocolClass];
    }
    if (![sessionConfiguration isSwizzle]) {
        [sessionConfiguration load];
    }
}

+ (void)end {
    DMURLSessionConfiguration *sessionConfiguration = [DMURLSessionConfiguration defaultConfiguration];
    [NSURLProtocol unregisterClass:[DMURLProtocol class]];
    if ([sessionConfiguration isSwizzle]) {
        [sessionConfiguration unload];
    }
}


/**
 需要监控的请求
 @param request 此次请求
 @return 是否需要监控
 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if (![request.URL.scheme isEqualToString:@"http"]) {
        return NO;
    }
    // 拦截过的不再拦截
    if ([NSURLProtocol propertyForKey:DMHTTP inRequest:request] ) {
        return NO;
    }
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:@YES
                        forKey:DMHTTP
                     inRequest:mutableReqeust];
    return [mutableReqeust copy];
}

- (void)startLoading {
    NSURLRequest *request = [[self class] canonicalRequestForRequest:self.request];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
#pragma clang diagnostic pop
    
    self.dm_request = self.request;
}

- (void)stopLoading {
    [self.connection cancel];
    
    //respose数据/下行流量
    NSUInteger lineLengthRespose = [self.dm_response dm_getLineLength];
    NSUInteger headerLengthRespose = [self.dm_response dm_getHeadersLength];
    NSUInteger bodyLengthRespose = 0;
    if ([self.dm_response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self.dm_response;
        NSData *data = self.dm_data;
        if ([[httpResponse.allHeaderFields objectForKey:@"Content-Encoding"] isEqualToString:@"gzip"]) {
            data = [self.dm_data gzippedData];
        }
        bodyLengthRespose = data.length;
    }
    long long totalRespose = lineLengthRespose + headerLengthRespose + bodyLengthRespose;
    //上行流量
    NSUInteger lineLengthRequest = [self.connection.currentRequest dgm_getLineLength];
    NSUInteger headerLengthRequest = [self.connection.currentRequest dgm_getHeadersLengthWithCookie];
    NSUInteger bodyLengthRequest = [self.connection.currentRequest dgm_getBodyLength];
    long long totalRequest = lineLengthRequest + headerLengthRequest + bodyLengthRequest;
    [[TDNetFlowDataSource shareInstance]setNetworkTrafficData:totalRequest withDownFlow:totalRespose];
    
    /*
    DMNetworkTrafficLog *model = [[DMNetworkTrafficLog alloc] init];
    model.path = self.request.URL.path;
    model.host = self.request.URL.host;
    model.type = DMNetworkTrafficDataTypeResponse;
    model.lineLength = [self.dm_response dm_getLineLength];
    model.headerLength = [self.dm_response dm_getHeadersLength];
    if ([self.dm_response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self.dm_response;
        NSData *data = self.dm_data;
        if ([[httpResponse.allHeaderFields objectForKey:@"Content-Encoding"] isEqualToString:@"gzip"]) {
            // 模拟压缩
            data = [self.dm_data gzippedData];
        }
        model.bodyLength = data.length;
    }
    model.length = model.lineLength + model.headerLength + model.bodyLength;
    [model settingOccurTime];
    [[DMDataManager defaultDB] addNetworkTrafficLog:model];
     */
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.client URLProtocol:self didFailWithError:error];
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    return YES;
}

#pragma mark - NSURLConnectionDataDelegate

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    if (response != nil) {
        self.dm_response = response;
        [self.client URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }

    
    /*
    DMNetworkTrafficLog *model = [[DMNetworkTrafficLog alloc] init];
    model.path = request.URL.path;
    model.host = request.URL.host;
    model.type = DMNetworkTrafficDataTypeRequest;
    model.lineLength = [connection.currentRequest dgm_getLineLength];
    model.headerLength = [connection.currentRequest dgm_getHeadersLengthWithCookie];
    model.bodyLength = [connection.currentRequest dgm_getBodyLength];
    model.length = model.lineLength + model.headerLength + model.bodyLength;
    [model settingOccurTime];
    [[DMDataManager defaultDB] addNetworkTrafficLog:model];
     */
    return request;
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    self.dm_response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
    [self.dm_data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[self client] URLProtocolDidFinishLoading:self];
}

- (NSMutableData *)dm_data {
    if (_dm_data == nil) {
        _dm_data = [NSMutableData data];
    }
    return _dm_data;
}

@end
