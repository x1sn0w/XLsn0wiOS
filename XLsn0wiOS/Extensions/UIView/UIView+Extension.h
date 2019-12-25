
#import <UIKit/UIKit.h>

typedef void (^TapAction)(void);

typedef enum : NSUInteger {
    TZOscillatoryAnimationToBigger,
    TZOscillatoryAnimationToSmaller,
} TZOscillatoryAnimationType;

@interface UIView (Extension)

- (void)tapHandle:(TapAction _Nullable )block;
- (void)shakeView;
- (void)shakeRotation:(CGFloat)rotation;

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat bottomFromSuperView;

@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property (nonatomic, strong) NSIndexPath* _Nullable indexPath;
@property (nonatomic) NSInteger section;
@property (nonatomic) NSInteger row;

//截图
- (nullable UIImage *)snapshotImage;
- (instancetype _Nullable)cornerAllCornersWithCornerRadius:(CGFloat)cornerRadius;///绘制圆角

//获取当前view所在的contronller
-(UIViewController * _Nullable)viewController;

+ (void)showOscillatoryAnimationWithLayer:(CALayer *_Nullable)layer
                                     type:(TZOscillatoryAnimationType)type;

//放大不收回两者结合使用
+ (void)showOnlyBigOscillatoryAnimationWithLayer:(CALayer *_Nullable)layer;
+ (void)showOnlyRestoreOscillatoryAnimationWithLayer:(CALayer *_Nullable)layer;

- (void)addShadow;
- (void)addShadowForRadius:(CGFloat)radius
             shadowOpacity:(CGFloat)shadowOpacity
              shadowOffset:(CGSize)shadowOffset
               shadowColor:(UIColor*_Nullable)shadowColor;

@end
