//
//  JSONUtil.m
//  Mall
//
//  Created by midland on 2019/10/14.
//  Copyright © 2019 JQHxx. All rights reserved.
//

#import "JSONUtil.h"

@implementation JSONUtil

+ (NSString *)queryStringFrom:(NSDictionary *)dic {
    NSString *query = @"{";
    for (id key in dic) {
        if ([[[dic objectForKey:key] class] isSubclassOfClass:[NSString class]]) {
            query = [query stringByAppendingFormat:@"%@:\"%@\"", key, [dic objectForKey:key]];
            query = [query stringByAppendingString:@","];
        }
        if ([[[dic objectForKey:key] class] isSubclassOfClass:[NSNumber class]]) {
            query = [query stringByAppendingFormat:@"%@:%@", key, [dic objectForKey:key]];
            query = [query stringByAppendingString:@","];
        }
        if ([[[dic objectForKey:key] class] isSubclassOfClass:[NSArray class]]) {
            NSData * JSONData;
            if ([dic objectForKey:key]) {
                JSONData = [NSJSONSerialization dataWithJSONObject:[dic objectForKey:key]
                                                           options:kNilOptions
                                                             error:nil];
            }
            NSString *string = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
            NSLog(@"string : %@",string);
            query = [query stringByAppendingFormat:@"%@:%@", key, string];
            query = [query stringByAppendingString:@","];
        }
        if ([[[dic objectForKey:key] class] isSubclassOfClass:[NSDictionary class]]) {
            NSData *jsonData;
            if ([dic objectForKey:key]) {
                jsonData = [NSJSONSerialization dataWithJSONObject:[dic objectForKey:key]
                                                           options:kNilOptions
                                                             error:nil];
            }
            if (jsonData) {
                NSString * string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSLog(@"string :%@",string);
                query = [query stringByAppendingFormat:@"%@:%@",key,string];
                query = [query stringByAppendingString:@","];
            }
        };

    }
    query = [query substringToIndex:([query length] - 1)];
    query = [query stringByAppendingString:@"}"];
    return query;
}

+ (NSString *)clearParams: (NSString *) query {
    NSString *clearLeftParenthesis = [query stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
    NSString *clearRightParenthesis = [clearLeftParenthesis stringByReplacingOccurrencesOfString:@"}" withString:@"%7D"];
    NSString *result = [clearRightParenthesis stringByReplacingOccurrencesOfString:@"\"" withString:@"%22"];
    result = [result stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return result;
}

+ (NSString *)dictToJSON:(NSDictionary *)dic {

    NSArray *keys = [dic allKeys];
    NSString *string = [NSString string];

    for (NSString *key in keys) {
        NSString *value = [dic objectForKey:key];
        value = [NSString stringWithFormat:@"\"%@\"",value];
        NSString *newkey = [NSString stringWithFormat:@"\"%@\"",key];
        if (!string.length) {
            string = [NSString stringWithFormat:@"%@:%@}",newkey,value];
        }else {
            string = [NSString stringWithFormat:@"%@:%@,%@",newkey,value,string];
        }
    }
    string = [NSString stringWithFormat:@"{%@",string];
    return string;
}

+ (NSString *)arrayToJSON:(NSArray *)array {

    NSString *string = [NSString string];
    for (int j = 0; j<array.count; j++) {
        NSDictionary *dic = array[j];
        NSArray *keys = [dic allKeys];
        for (int i = 0; i<keys.count; i++) {
            NSString *key = keys[i];
            NSString *value = [dic objectForKey:key];
            value = [NSString stringWithFormat:@"\"%@\"",value];
            key = [NSString stringWithFormat:@"\"%@\"",key];
            if (!string.length) {
                string = [NSString stringWithFormat:@"%@:%@}",key,value];
            } else if(i == 0){
                string = [NSString stringWithFormat:@"%@:%@}%@",key,value,string];
            }else {
                string = [NSString stringWithFormat:@"%@:%@,%@",key,value,string];
            }
        }
        if (j != array.count - 1) {
            string = [NSString stringWithFormat:@",{%@",string];
        } else {
            string = [NSString stringWithFormat:@"[{%@]",string];
        }
    }
    return string;
}

@end
