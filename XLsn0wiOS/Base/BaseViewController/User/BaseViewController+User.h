//
//  BaseViewController+User.h
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController.h"
#import "ImportHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController (User)

- (UserArchiverModel *)user;
- (NSNumber *)userId;
- (NSNumber *)state;
- (NSString *)name;
- (NSString *)year;
- (NSString *)fee;
- (NSString *)gender;
- (NSString *)age;
- (NSString *)phoneNumber;
- (NSString *)avatarUrl;
- (NSString *)job;
- (NSString *)office;
- (NSString *)cardUrl;
- (NSString *)accountMoney;
- (NSNumber *)authState;

- (NSString *)doctorRole;
- (NSString *)doctorRoleName;

- (NSString *)userProvince;
- (NSString *)userCity;
- (NSString *)userArea;

- (NSNumber *)beforeState;

- (NSString *)beforeDoctorRole;

@end

NS_ASSUME_NONNULL_END
