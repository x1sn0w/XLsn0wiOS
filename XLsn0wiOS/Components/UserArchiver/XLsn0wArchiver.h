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
#import <Foundation/Foundation.h>

@class XLsn0wArchiverModel;

@interface XLsn0wArchiver : NSObject

/// 用户信息
+ (void)insertUserModel:(XLsn0wArchiverModel *)model;///保存用户信息                 增/改
+ (XLsn0wArchiverModel *)selectFromUserModel;///根据当前用户属性的值取到缓存的用户属性    查
+ (void)deleteUserModel;///删除用户信息 重新init/new                                删

@end

@interface ArchiveTool : NSObject

//归档
+ (BOOL)archiveModel:(id)aModel toPath:(NSString *)path withKey:(NSString *)archivingDataKey;
//从指定位置解档
+ (id)unarchiveFromPath:(NSString *)path withKey:(NSString *)archivingDataKey;

//根据key获得存储地址
+ (NSString *)pathWithKey:(NSString *)pathKey;

@end

@interface NSObject (property)

/*!
 @brief 根据当前类获取当前类的所有属性名称
 @param cls 当前类 Class类型
 @return 当前类的所有属性名称
 */
- (NSArray *)getProperties:(Class)cls;

/*!
 @brief 循环属性所对应的名称
 @param properties 循环后执行的block key为当前属性的名称
 */
- (void)enumerateProperties:(void(^)(id key))properties;

@end
