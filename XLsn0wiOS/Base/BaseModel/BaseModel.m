
#import "BaseModel.h"

@implementation BaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    [super setValue:value forKey:key];
}

/*

@property (nonatomic, copy) NSMutableArray<doctorPrescriptionListModel *> *doctorPrescriptionList;///添加NSMutableArray字段名
 
+ (NSDictionary *)modelContainerPropertyGenericClass {///嵌套NSMutableArray数组字段名
    return @{@"doctorPrescriptionList" : [doctorPrescriptionListModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {///替换字段名
    return @{@"userId":@"id"};
}
 
*/

@end
