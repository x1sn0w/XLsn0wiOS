//
//  XLsn0wHighLightButton.m
//  ChineseMedicine
//
//  Created by mac on 2019/9/27.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "XLsn0wHighLightButton.h"

@implementation XLsn0wHighLightButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = self.highlightedColor;
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.backgroundColor = nil;
        });
    }
}

@end
