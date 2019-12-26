//
//  NSDictionary+Extension.h
//  ChineseMedicine
//
//  Created by Mac on 2019/4/19.
//  Copyright © 2019 fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

+ (NSDictionary *)convertJSON:(id)responseObject;
+ (NSDictionary *)convertJSONString:(NSString *)jsonString;

/*
 *把服务器返回的 替换为“”
 *json表示获取到的带有NULL对象的json数据
 *NSDictionary *newDict = [NSDictionary changeType:json];
 */
+ (id)changeType:(id)myObj;

@end

NS_ASSUME_NONNULL_END
