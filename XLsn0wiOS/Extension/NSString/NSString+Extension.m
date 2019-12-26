
#import "NSString+Extension.h"
#import "XLsn0wiOSHeader.h"

@implementation NSString (Extension)

- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese {
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

+ (NSString *)convertDateFromTimestamp:(NSString *)timestamp {
    //    long long time=[timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    long long time = [timestamp longLongValue] / 1000;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:date];
    
    return timeString;
}

- (CGSize)sizeWithFont:(UIFont *)font
           constHeight:(CGFloat)constHeight {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, constHeight);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
            constWidth:(CGFloat)constWidth {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(constWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//字典转字符串
+ (NSString*)getStringFromDictionary:(NSDictionary *)dictionary {
    NSError *nilError = nil;
    NSData  *dictionaryData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&nilError];
    return [[NSString alloc] initWithData:dictionaryData encoding:NSUTF8StringEncoding];
}

- (NSAttributedString *)attributedTextFromFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = lineSpacing;
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
    return attributedText;
}

- (float)autoTextWidthForFontSize:(float)fontSize
                       textHeight:(float)textHeight {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight)
                                       options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return size.width;
}

+ (NSString *)priceFormat:(NSString *)priceString {
    /* 直接传入精度丢失有问题的Double类型*/
    NSString *doubleString = [NSString stringWithFormat:@"%.2f", [priceString doubleValue]];
    NSDecimalNumber *priceDecimalNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    NSString* priceFormatString = [priceDecimalNumber stringValue];
    return priceFormatString;
}

+ (NSString *)priceFormatFromDouble:(double)doubleValue {
    /* 直接传入精度丢失有问题的Double类型*/
    NSString *doubleString = [NSString stringWithFormat:@"%.2f", doubleValue];
    NSDecimalNumber *priceDecimalNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    NSString* priceFormatString = [priceDecimalNumber stringValue];
    return priceFormatString;
}

- (NSString *)priceFormat {
    /* 直接传入精度丢失有问题的Double类型*/
    NSString *doubleString = [NSString stringWithFormat:@"%.2f", [self doubleValue]];
    NSDecimalNumber *priceDecimalNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    NSString* priceFormatString = [priceDecimalNumber stringValue];
    return priceFormatString;
}

/// 获取字符串最大高度
- (CGFloat)getMaxHeightFromConstWidth:(CGFloat)width
                             textFont:(UIFont *)font {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    CGSize stringSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes context:nil].size;
    CGFloat maxHeight = stringSize.height;
    return maxHeight;
}

+ (NSString *)convertPriceFormat:(NSNumber *)fromNumber {
    NSString *descriptionString = [fromNumber description];
    
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+\\.\\d{2}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    
    
    
    NSArray *results = [regex matchesInString:descriptionString options:NSMatchingReportCompletion range:NSMakeRange(0, descriptionString.length)];
    
    
    
    for (NSTextCheckingResult *result in results) {
        
        NSLog(@"%@", [descriptionString substringWithRange:result.range]);
        
    }
    
    // 小数点的位置
    
    NSUInteger dotIndex = [descriptionString rangeOfString:@"."].location;
    
    if (dotIndex != NSNotFound && descriptionString.length - dotIndex > 2) { // 小数超过2位
        
        descriptionString = [descriptionString substringToIndex:dotIndex + 3];
        
    }
    
    //有个NSNumberFormatter类,不常用,可以把num转变成string,而不用先变成 float,再转变成str,会有精度损失
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    
    NSNumber* number = [fmt numberFromString:descriptionString];
    
    
    return number.stringValue;
}



///把任意OC对象转成JSON字符串
+ (NSString *)convertJSONString:(id)obj {
    NSError *error = nil;
    if (obj == nil) {
        return nil;
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] && error == nil) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        XLsn0wLog(@"convertJSONStringFromObject_error = %@", error);
        return nil;
    }
}

+ (NSString *)JoinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableArray *array = [NSMutableArray new];
    
    va_list args;
    
    if(firstStr){
        
        [array addObject:firstStr];
        
        va_start(args, firstStr);
        
        id obj;
        
        while ((obj = va_arg(args, NSString* ))) {
            [array addObject:obj];
        }
        
        va_end(args);
    }
    
    return [array componentsJoinedByString:@""];
}

+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

+ (NSString *)convertJSONStringFromObject:(id)object {
    if (object == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        XLsn0wLog(@"convertJSONStringFromObject_error = %@", error);
        return nil;
    }
}

/**
 *  时间戳转时间格式（格式：yyyy-MM-dd）
 *
 *  @param str 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getDateFromTimestampString:(NSString *)str {
    if (![str isEqual:[NSNull null]] && str.length > 10) {
        str = [str substringWithRange:NSMakeRange(0,10)];
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:str.intValue];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)getDateFromTimestampStringInt:(NSInteger)time {
    NSString *str = [NSString stringWithFormat:@"%lu",time];
    if (![str isEqual:[NSNull null]] && str.length > 10) {
        str = [str substringWithRange:NSMakeRange(0,10)];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:str.integerValue];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)getDateTimestampStringInt:(NSInteger)time {
    NSString *str = [NSString stringWithFormat:@"%lu",time];
    if (![str isEqual:[NSNull null]] && str.length > 10) {
        str = [str substringWithRange:NSMakeRange(0,10)];
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:str.integerValue];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)dateFromTimestampString:(NSInteger)time {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)getNewDataLastWeekWithTime:(NSString *)timeStr {
    NSDate *date = [self dateFromString:timeStr];
    
    NSInteger dis = 7; //前后的天数
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    
    NSDate *nextDat = [NSDate dateWithTimeInterval:oneDay*dis sinceDate:date];//后一天
    
    NSTimeInterval times = [nextDat timeIntervalSince1970];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:times];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

//将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy.MM.dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

+ (NSString *)changDateFormet:(NSString *)timeStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:timeStr];
    NSTimeInterval times = [destDate timeIntervalSince1970];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:times];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+ (NSString *)getNewDataLastWeekDataWithTime:(NSString *)timeStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *date= [dateFormatter dateFromString:timeStr];
    NSInteger dis = 7; //前后的天数
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    NSDate *nextDat = [NSDate dateWithTimeInterval:oneDay*dis sinceDate:date];//后一天
    NSTimeInterval times = [nextDat timeIntervalSince1970];
    return [self getDateFromTimestampStringInt:times];
}

+ (NSString *)getTodayYYYY_MM_dd:(NSString *)timeStampString {
    NSTimeInterval timeInterval = [timeStampString doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *Today = [dateFormatter stringFromDate:date];
    return Today;
}

@end
