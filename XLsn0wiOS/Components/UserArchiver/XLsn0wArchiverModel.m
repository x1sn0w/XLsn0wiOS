
#import "XLsn0wArchiverModel.h"
#import "XLsn0wArchiver.h"

@implementation XLsn0wArchiverModel

//归档（序列化）
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self enumerateProperties:^(id key) {
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }];
}

//解归档（反序列化）
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        __weak typeof(self) weakSelf = self;
        [self enumerateProperties:^(id key) {
            id value = [aDecoder decodeObjectForKey:key];
            [weakSelf setValue:value forKey:key];
        }];
    }
    return self;
}

@end
