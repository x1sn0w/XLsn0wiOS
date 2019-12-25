
#import "UIResponder+Extension.h"

static __weak id currentFirstResponder;

@implementation UIResponder (Extension)

+ (id)getFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
