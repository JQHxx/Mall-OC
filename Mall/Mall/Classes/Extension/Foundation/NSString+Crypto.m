//
//  NSString+Crypto.m
//  Mall
//
//  Created by midland on 2019/10/16.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "NSString+Crypto.h"
#import "CommonCrypto/CommonDigest.h"


@implementation NSString (Crypto)

- (NSString *)md5HexDigest {
    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

@end
