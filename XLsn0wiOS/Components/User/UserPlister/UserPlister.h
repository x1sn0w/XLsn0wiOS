//
//  UserPlist.h
//  TimeForest
//
//  Created by TimeForest on 2018/10/24.
//  Copyright © 2018 TimeForest. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserSharedPlist [UserPlister shared]

typedef NS_ENUM(NSInteger, LoginStatus) {
    LoginStatusInit = 0,
    LoginStatusSucceed,
    LoginStatusFail
};

@interface UserPlister : NSObject

+ (instancetype)shared;

@property (nonatomic, unsafe_unretained) LoginStatus LogStatus;

- (void)createUserPlist;
- (void)insertUserId:(NSNumber*)userId
                name:(NSString *)name
                 sex:(NSString *)sex
            username:(NSString *)username
        headportrait:(NSString *)headportrait;
- (id)selectValueForKey:(NSString *)key;

- (NSNumber*)userId;

- (NSString*)name;

- (NSString*)sex;

- (NSString*)birthday;

- (NSString*)username;

- (NSString*)headportrait;



@end


@interface CurrentUser : NSObject

@property (nonatomic, copy)   NSString    *HuanZheName;//选择患者
@property (nonatomic, assign) NSInteger    HuanZheSex;
@property (nonatomic, assign) NSInteger    HuanZheAge;
@property (nonatomic, assign) NSInteger    HuanZheId;
@property (nonatomic, strong) NSMutableArray *KaiFangMedicine;//开方药物
@property (nonatomic, strong) NSMutableArray *KaiFangKeShu;
@property (nonatomic, assign) NSInteger    ExcelNum;
@property (nonatomic, assign) NSInteger    MedicineType;
@property (nonatomic, assign) NSInteger    PopToMedinceForZiBeiLiangFang;
@property (nonatomic, assign) NSInteger    MessAdin;
@property (nonatomic, copy)   NSString   *chooseHuanZhe;
@property (nonatomic, copy)   NSString   *ssssss;

+ (instancetype)shareManager;

+ (NSNumber *)doctorId;
+ (NSString *)doctorIdString;
+ (NSString *)RongCloudUserId;
+ (NSInteger)getCurrentUserID;
+ (NSString *)getCurrentUserName;
+ (NSString *)getCurrentUserPhoto;
+ (NSString *)getCurrentUserPhone;

@end
