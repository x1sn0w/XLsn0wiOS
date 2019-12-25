

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationManagerAction)(NSString *country,
                                     NSString* province,
                                     NSString* city,
                                     NSString* area,
                                     CLLocationDegrees latitude,
                                     CLLocationDegrees longitude);

typedef void(^LocationManagerErrorAction)(NSError *error);

#define XLsn0wLocationSharedManager [XLsn0wLocationManager shared]

@interface XLsn0wLocationManager : NSObject

@property (nonatomic, copy) LocationManagerAction locationAction;
@property (nonatomic, copy) LocationManagerErrorAction locationErrorAction;

+ (XLsn0wLocationManager *)shared;

- (void)startLocation;

@end
