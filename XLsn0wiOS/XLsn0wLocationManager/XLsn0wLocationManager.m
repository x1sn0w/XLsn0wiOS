
#import "XLsn0wLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "XLsn0wCoordinateConvert.h"
#import "XLsn0wLocationManagerAlert.h"

@interface XLsn0wLocationManager()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation XLsn0wLocationManager

+ (XLsn0wLocationManager *)shared {
    static XLsn0wLocationManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

- (void)startLocation {
    if([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currentLocation = [locations lastObject];
    //国内经纬度转换为火星坐标
    currentLocation = [XLsn0wCoordinateConvert transformToMars:currentLocation];
    [_locationManager stopUpdatingLocation];
    //获取经纬度
    CLLocationDegrees latitude = currentLocation.coordinate.latitude;///纬度
    CLLocationDegrees longitude = currentLocation.coordinate.longitude;///经度
    
    //反地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            
            NSString *country  = placemark.country;             ///中 国
            NSString *province = placemark.administrativeArea;  ///浙江省
            NSString *city     = placemark.locality;            ///嘉兴市
            NSString *area     = placemark.subLocality;         ///南湖区
            
            if (self.locationAction) {
                self.locationAction(country,
                                    province,
                                    city,
                                    area,
                                    latitude,
                                    longitude);
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            if([CLLocationManager locationServicesEnabled])
            {
                [XLsn0wLocationManagerAlert addSecConfirmAlertWithController:[UIApplication sharedApplication].keyWindow.rootViewController title:@"提示" message:@"定位服务授权被拒绝，是否前往设置开启？" confiemAction:^(UIAlertAction *action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                    }
                }];
            }
            else
            {
                
            }
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {

            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            break;
        }
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (self.locationErrorAction) {
        self.locationErrorAction(error);
    }
}

@end
