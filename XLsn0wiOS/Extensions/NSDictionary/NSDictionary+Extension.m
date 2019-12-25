//
//  NSDictionary+Extension.m
//  ChineseMedicine
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSPlaceholderDictionary") originSelector:@selector(initWithObjects:forKeys:count:) otherSelector:@selector(xlsn0w_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)xlsn0w_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
{
    for (int i=0; i<cnt; i++) {
        if (objects[i] == nil) {
            //            [NHCallStackSymbols callStackSymbols:self andObjectValue:[NSString stringWithFormat:@"NSDictionary value: key:"]];
            return nil;
        }
    }
    return [self xlsn0w_initWithObjects:objects forKeys:keys count:cnt];
}

+ (NSDictionary *)convertJSON:(id)responseObject {
    NSDictionary *JSONDictionary = [NSDictionary dictionary];
    NSError* error;
    if (isNotNull(responseObject)) {
        //将返回的数据转成json数据格式
        JSONDictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                           error:&error];
        if (error) {
            XLsn0wLog(@"NSDictionary (Extension) convertJSON error = %@", error);
            [TipShow showCenterText:@"后台传输非JSON格式, 无法解析" delay:2];
        }
    }
    return JSONDictionary;
}

+ (NSDictionary *)convertJSONString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        obj = [self changeType:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}
//将NSArray中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        obj = [self changeType:obj];
        [resArr addObject:obj];
    }
    return resArr;
}
//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}
//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}
//主要方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj {
    if ([myObj isKindOfClass:[NSDictionary class]]) {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]]) {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]]) {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]]) {
        return [self nullToString];
    }
    else {
        return myObj;
    }
}

@end
