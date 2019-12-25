//
//  NSError+Extension.h
//  ChineseMedicine
//
//  Created by Mac on 2019/7/3.
//  Copyright © 2019 fbw. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSError (Extension)

+ (NSError *)returnErrorWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
