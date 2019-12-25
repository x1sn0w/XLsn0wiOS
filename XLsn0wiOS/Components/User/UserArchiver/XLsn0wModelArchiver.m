/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 **********************************************************************************************/
#import "XLsn0wModelArchiver.h"
#import <objc/runtime.h>

#define KUserArchivePathKey @"userInfo.archive"
#define KEY @"UserArchiver"

@implementation XLsn0wArchiver

#pragma mark 保存用户信息
+ (void)insertUserModel:(UserArchiverModel *)model {
    BOOL success = [ArchiveTool archiveModel:model toPath:[ArchiveTool pathWithKey:KUserArchivePathKey] withKey:KEY];
    if (!success) {
        NSLog(@"存储用户信息失败");
    }
}

#pragma mark 取出用户信息
+ (UserArchiverModel *)selectFromUserModel {
    UserArchiverModel *model = [ArchiveTool unarchiveFromPath:[ArchiveTool pathWithKey:KUserArchivePathKey] withKey:KEY];
    if (!model) {
        model = [[UserArchiverModel alloc] init];
    }
    return model;
}

+ (void)deleteUserModel {
    UserArchiverModel *model = [[UserArchiverModel alloc] init];
    [self insertUserModel:model];
}

@end

@implementation ArchiveTool

+ (BOOL)archiveModel:(id)aModel toPath:(NSString *)path withKey:(NSString *)archivingDataKey{
    //归档
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // archivingDate的encodeWithCoder方法被调用
    [archiver encodeObject:aModel forKey:archivingDataKey];
    [archiver finishEncoding];
    //写入文件
    return [data writeToFile:path atomically:YES];
}

+ (id)unarchiveFromPath:(NSString *)path withKey:(NSString *)archivingDataKey{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //获得类
    //initWithCoder方法被调用
    id archivingData = [unarchiver decodeObjectForKey:archivingDataKey];
    [unarchiver finishDecoding];
    return archivingData;
}

+ (NSString *)pathWithKey:(NSString *)pathKey{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:pathKey];
    //NSLog(@"%@",filePath);
    return filePath;
}

@end

@implementation NSObject (property)

//返回当前类的所有属性名称
- (NSArray *)getProperties:(Class)cls{
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    return mArray.copy;
}

//循环属性所对应的名称
- (void)enumerateProperties:(void(^)(id key))properties {
    NSArray *names = [self getProperties:[self class]];
    for (id key in names) {
        properties(key);
    }
}

@end
