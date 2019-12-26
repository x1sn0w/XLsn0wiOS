
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface XLsn0wCoordinateConvert : NSObject

/**
 *  地球坐标转换为火星坐标
 *
 *  @param location 地球坐标
 *
 *  @return 返回转换后的火星坐标
 */
+ (CLLocation *)transformToMars:(CLLocation *)location;

@end
