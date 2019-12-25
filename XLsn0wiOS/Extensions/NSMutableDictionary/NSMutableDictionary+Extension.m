//
//  NSMutableDictionary+Extension.m
//  ChineseMedicine
//
//  Created by Mac on 2019/7/4.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (Extension)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self swizzleInstanceMethod:NSClassFromString(@"__NSDictionaryM") originSelector:@selector(setObject:forKey:) otherSelector:@selector(setObject_xlsn0w:forKey:)];
//    });
//}
//
//- (void)setObject_xlsn0w:(id)anObject forKey:(id<NSCopying>)aKey {
//    if (anObject!=nil) {
//        //        NSCAssert(aKey == nil, @"aKey当前是nil");
//        [self setObject_xlsn0w:anObject forKey:aKey];
//    } else {
//        //        [NHCallStackSymbols callStackSymbols:self andObjectValue:[NSString stringWithFormat:@"NSMutableDictionary value:%@ key:%@",anObject,aKey]];
//        NSAssert(NO, @"设置了字典的value为nil");
//    }
//}

@end
