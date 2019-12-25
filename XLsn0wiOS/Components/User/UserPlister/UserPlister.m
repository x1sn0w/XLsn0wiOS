
#import "UserPlister.h"

@interface UserPlister ()

@property (nonatomic, copy) NSString *plistPath;

@end

@implementation UserPlister

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static UserPlister* singleton;
    dispatch_once(&onceToken,^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (NSString *)UserPlistPath {
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [documentsPath stringByAppendingPathComponent:@"UserPlist.plist"];
}


- (void)writeToFile:(NSDictionary *)loginData {
    NSDictionary *usrData = @{};
    [usrData writeToFile:[self UserPlistPath] atomically:YES];
}

- (NSDictionary *)getUserData {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self UserPlistPath]]) {
        NSDictionary *usrData = [[NSDictionary alloc] initWithContentsOfFile:[self UserPlistPath]];
        return usrData;
    }
    else {
        return nil;
    }
}


- (void)loginOut {
    NSDictionary *usrData = @{};
    [usrData writeToFile:[self UserPlistPath] atomically:YES];
    
}


- (void)deleteUserData {
    _LogStatus = LoginStatusInit;
    NSString *path = [self UserPlistPath];
    NSFileManager *manager;
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
}

- (void)createUserPlist {
    self.plistPath = [XLsn0wDocumentDirectory stringByAppendingPathComponent:@"UserPlist.plist"];
}

- (void)insertUserId:(NSNumber*)userId
                name:(NSString *)name
                 sex:(NSString *)sex
            username:(NSString *)username
        headportrait:(NSString *)headportrait {

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:name forKey:@"name"];
    [dic setObject:sex forKey:@"sex"];
    [dic setObject:username forKey:@"username"];
    [dic setObject:headportrait forKey:@"headportrait"];
    
    NSMutableArray *rootArray = [[NSMutableArray alloc] initWithObjects:dic, nil];
    BOOL isWrite = [rootArray writeToFile:self.plistPath atomically:YES];

    if (isWrite == true){
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
}

- (id)selectValueForKey:(NSString *)key {
    XLsn0wLog(@"plist=== %@", [XLsn0wDocumentDirectory stringByAppendingPathComponent:@"UserPlist.plist"]);
    NSMutableArray *rootArray = [[NSMutableArray alloc] initWithContentsOfFile:self.plistPath];
    
    XLsn0wLog(@"rootArray=== %@", rootArray);
    id value = [rootArray[0] objectForKey:key];
    return value;
}

- (NSNumber*)userId {
    return [UserSharedPlist selectValueForKey:@"userId"];
}

- (NSString*)name {
    return [UserSharedPlist selectValueForKey:@"name"];
}

- (NSString*)sex {
    return [UserSharedPlist selectValueForKey:@"sex"];
}

- (NSString*)birthday {
    return [UserSharedPlist selectValueForKey:@"birthday"];
}

- (NSString*)username {
    return [UserSharedPlist selectValueForKey:@"username"];
}

- (NSString*)headportrait {
    return [UserSharedPlist selectValueForKey:@"headportrait"];
}

@end

@implementation CurrentUser

+ (instancetype)shareManager {
    static CurrentUser *manager= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CurrentUser alloc]init];
    });
    return manager;
}

+ (NSNumber *)doctorId {
    return [NSNumber numberWithInteger:[CurrentUser getCurrentUserID]];
}

+ (NSString *)doctorIdString {
    return [[NSNumber numberWithInteger:[CurrentUser getCurrentUserID]] stringValue];
}

///UserId
+ (NSInteger)getCurrentUserID {
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    if (user) {
        return [user[@"id"] integerValue];
    }
    return 0;
}

///phoneNumber
+ (NSString *)getCurrentUserPhone {
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    if (user) {
        if (NotNilAndNull(user[@"phoneNumber"])) {
            //            NSLog(@"%@",user);
            return user[@"phoneNumber"];
        }else {
            return @"";
        }
    }
    return @"";
}

+ (NSString *)RongCloudUserId {
   return [self getCurrentUserPhone];
}

///UserName
+ (NSString *)getCurrentUserName {
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    if (user) {
        if (NotNilAndNull(user[@"realName"])) {
            return user[@"realName"];
        }else if (NotNilAndNull(user[@"phoneNumber"])){
            return user[@"phoneNumber"];
        }
        return @"暂无用户名";
    }
    return @"";
}

///UserAvatar
+ (NSString *)getCurrentUserPhoto {
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    if (user) {
        if (NotNilAndNull(user[@"headImage"])) {
            return user[@"headImage"];
        }else {
            return nil;
        }
    }
    return @"";
}

@end

