
#import "XLsn0wActionSheetConfig.h"

#define kLCActionSheetButtonHeight              49.0f

#define kLCActionSheetRedColor                  kLCActionSheetColor(254, 67, 37)

#define kLCActionSheetTitleFont                 [UIFont systemFontOfSize:16]

#define kLCActionSheetButtonFont                [UIFont systemFontOfSize:16]

#define kLCActionSheetAnimationDuration         0.3f

#define kLCActionSheetDarkOpacity               0.5f

#define kLCActionSheetBlurBgColorNormal         [[UIColor whiteColor] colorWithAlphaComponent:0.5]
//#define kLCActionSheetBlurBgColorHighlighted    [[UIColor whiteColor] colorWithAlphaComponent:0.1]


@implementation XLsn0wActionSheetConfig

+ (XLsn0wActionSheetConfig *)config {
    static id _config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[self alloc] initSharedInstance];
    });
    return _config;
}

+ (instancetype)shared {
    return self.config;
}

- (instancetype)initSharedInstance {
    if (self = [super init]) {
        self.titleFont                = kLCActionSheetTitleFont;
        self.buttonFont               = kLCActionSheetButtonFont;
        self.destructiveButtonColor   = kLCActionSheetRedColor;
        self.titleColor               = App999999TitleColor;
        self.buttonColor              = App333333TitleColor;
        
        self.buttonHeight             = kLCActionSheetButtonHeight;
        self.animationDuration        = kLCActionSheetAnimationDuration;
        self.darkOpacity              = kLCActionSheetDarkOpacity;
        
        self.titleEdgeInsets          = UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f);
        self.buttonEdgeInsets         = UIEdgeInsetsMake(8.0, 15.0, 8.0, 15.0);
//        self.actionSheetEdgeInsets    = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        
        self.separatorColor           = kLCActionSheetColorA(150.0f, 150.0f, 150.0f, 0.3f);
        self.blurBackgroundColor      = kLCActionSheetBlurBgColorNormal;
        
        self.cancelButtonColor        = self.buttonColor;
        self.cancelButtonBgColor      = [UIColor clearColor];
        self.buttonBgColor            = [UIColor clearColor];
        self.destructiveButtonBgColor = [UIColor clearColor];
        self.buttonCornerRadius       = 0.0f;
    }
    return self;
}

- (instancetype)init {
    return XLsn0wActionSheetConfig.config;
}

- (NSInteger)cancelButtonIndex {
    return 0;
}

@end
