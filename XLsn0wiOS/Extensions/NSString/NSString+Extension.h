
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define XLsn0wAppendString(firstStr,...) [NSString JoinedWithSubStrings:firstStr,__VA_ARGS__,nil]

#define AppendText(firstStr,...)         [NSString JoinedWithSubStrings:firstStr,__VA_ARGS__,nil]

@interface NSString (Extension)

- (BOOL)isChinese;//判断是否是纯汉字

- (BOOL)includeChinese;//判断是否含有汉字

- (CGSize)sizeWithFont:(UIFont *)font
           constHeight:(CGFloat)constHeight;

- (CGSize)sizeWithFont:(UIFont *)font
            constWidth:(CGFloat)constWidth;

+ (NSString*)getStringFromDictionary:(NSDictionary *)dictionary;

- (NSAttributedString *)attributedTextFromFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;


- (float)autoTextWidthForFontSize:(float)fontSize
                       textHeight:(float)textHeight;

+ (NSString *)convertDateFromTimestamp:(NSString *)timestamp;

+ (NSString *)JoinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION;

+ (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font
               maxSize:(CGSize)maxSize;

+ (NSString *)convertJSONString:(id)obj;
+ (NSString *)convertJSONStringFromObject:(id)obj;

/**
 *  时间戳转时间格式（格式：yyyy-MM-dd）
 *
 *  @param str 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getDateFromTimestampString:(NSString *)str;

/**
 *  时间戳转时间格式（格式：yyyy.MM.dd HH:mm）
 *
 *  @param time 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getDateFromTimestampStringInt:(NSInteger)time;

+ (NSString *)dateFromTimestampString:(NSInteger)time;

//时间戳转MM月DD日
+ (NSString *)getDateTimestampStringInt:(NSInteger)time;
// 获取当前时间后七天的时间;
+ (NSString *)getNewDataLastWeekWithTime:(NSString *)timeStr;

+ (NSString *)changDateFormet:(NSString *)timeStr;


+ (NSString *)getNewDataLastWeekDataWithTime:(NSString *)timeStr;

+ (NSString *)getTodayYYYY_MM_dd:(NSString *)timeStampString;

+ (NSString *)priceFormat:(NSString *)priceString;
+ (NSString *)priceFormatFromDouble:(double)doubleValue;
- (NSString *)priceFormat;
+ (NSString *)convertPriceFormat:(NSNumber *)fromNumber;

/// 获取字符串最大高度
- (CGFloat)getMaxHeightFromConstWidth:(CGFloat)width
                             textFont:(UIFont *)font;

@end
