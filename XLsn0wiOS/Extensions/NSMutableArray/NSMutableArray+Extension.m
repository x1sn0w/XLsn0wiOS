//
//  NSMutableArray+Extension.m
//  ChineseMedicine
//
//  Created by Mac on 2019/7/4.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "NSMutableArray+Extension.h"

@implementation NSMutableArray (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(insertObject:atIndex:) otherSelector:@selector(insertObject_xlsn0w:atIndex:)];
        [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(objectAtIndex_xlsn0w:)];
    });
}

- (void)insertObject_xlsn0w:(id)anObject atIndex:(NSUInteger)index {
    if (anObject != nil && index<=self.count) {
        [self insertObject_xlsn0w:anObject atIndex:index];
    }
}

- (id)objectAtIndex_xlsn0w:(NSInteger)index {
    if (index < self.count) {
        return [self objectAtIndex_xlsn0w:index];
    } else {
        //        [NHCallStackSymbols callStackSymbols:self andObjectValue:[NSString stringWithFormat:@"NSMutableArray:%ld",index]];
        NSAssert(NO, @"数组越界了。。。。。。。");
        return nil;
    }
}

@end
