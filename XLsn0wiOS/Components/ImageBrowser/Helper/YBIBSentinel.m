//
//  YBIBSentinel.m
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBIBSentinel.h"
#import <libkern/OSAtomic.h>

@implementation YBIBSentinel {
    int32_t _value;
}

- (int32_t)value {
    return _value;
}

///忽略方法被弃用警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (int32_t)increase {
    return OSAtomicIncrement32(&_value);
}
#pragma clang diagnostic pop

@end
