//
//  BaseViewController+User.m
//  ChineseMedicine
//
//  Created by Mac on 2019/5/13.
//  Copyright © 2019 fbw. All rights reserved.
//

#import "BaseViewController+User.h"

@implementation BaseViewController (User)

- (UserArchiverModel *)user {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user;
}

- (NSNumber *)userId {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.userId;
}

- (NSNumber *)state {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.state;
}

- (NSString *)cardUrl {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.cardUrl;
}

- (NSString *)accountMoney {
    NSNumber* accountMoney = [UserDefaulter selectValueFromKey:@"accountMoney"];
    return [[accountMoney stringValue] priceFormat];
}

- (NSString *)name {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    if (isNotNull(user.name)) {
        return user.name;
    } else {
        return @"";
    }
}

- (NSString *)year {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    if (isNotNull(user.year)) {
        return user.year;
    } else {
        return @"";
    }
}

- (NSString *)fee {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.fee;
}

- (NSString *)gender {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    if (isNotNull(user.gender)) {
        return user.gender;
    } else {
        return @"";
    }
}

- (NSString *)age {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    if (isNotNull(user.age)) {
        return user.age;
    } else {
        return @"";
    }
}

- (NSString *)phoneNumber {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.phoneNumber;
}

- (NSString *)avatarUrl {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.avatarUrl;
}

- (NSString *)job {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.job;
}

- (NSString *)office {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.office;
}

- (NSNumber *)authState {
    if ([UserDefaulter selectValueFromKey:@"authState"]) {
        NSNumber* authState = [UserDefaulter selectValueFromKey:@"authState"];
        return authState;
    } else {
        return nil;
    }
}

- (NSNumber *)beforeState {
    if ([UserDefaulter selectValueFromKey:@"beforeState"]) {
        NSNumber* beforeState = [UserDefaulter selectValueFromKey:@"beforeState"];
        return beforeState;
    } else {
        return nil;
    }
}

- (NSString *)beforeDoctorRole {
    if ([UserDefaulter selectValueFromKey:@"beforeDoctorRole"]) {
        NSString* doctorRole = [UserDefaulter selectValueFromKey:@"beforeDoctorRole"];
        return doctorRole;
    } else {
        return nil;
    }
}

- (NSString *)doctorRole {
    if ([UserDefaulter selectValueFromKey:@"doctorRole"]) {
        NSString* doctorRole = [UserDefaulter selectValueFromKey:@"doctorRole"];
        return doctorRole;
    } else {
        return nil;
    }
}

- (NSString *)doctorRoleName {
    if ([UserDefaulter selectValueFromKey:@"doctorRoleName"]) {
        NSString* doctorRole = [UserDefaulter selectValueFromKey:@"doctorRoleName"];
        return doctorRole;
    } else {
        return nil;
    }
}

- (NSString *)userProvince {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.userProvince;
}

- (NSString *)userCity {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.userCity;
}

- (NSString *)userArea {
    UserArchiverModel* user = [XLsn0wArchiver selectFromUserModel];
    return user.userArea;
}

@end
