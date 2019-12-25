
#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

static char tapKey;
#pragma mark - 添加单击手势
- (void)tapHandle:(TapAction)block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &tapKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    TapAction blcok = objc_getAssociatedObject(self, &tapKey);
    if (blcok) {
        blcok();
    }
}

#pragma mark 抖动
- (void)shakeView {
    //view抖动
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.repeatCount = 1;
    anim.values = @[@-4,@4,@-4,@4];
    [self.layer addAnimation:anim forKey:nil];
}

- (void)shakeRotation:(CGFloat)rotation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.repeatCount = 2;
    anim.duration = .2;
    anim.values = @[@0,@(rotation),@0,@(-rotation),@0];
    [self.layer addAnimation:anim forKey:nil];
}

- (CGFloat)bottomFromSuperView{
    return self.superview.height - self.y - self.height;
}

static char indexPathKey;
- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, &indexPathKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char rowKey;
- (void)setRow:(NSInteger)row {
    objc_setAssociatedObject(self, &rowKey, @(row), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)row {
    return [objc_getAssociatedObject(self, &rowKey) integerValue];
}

static char sectionKey;
- (void)setSection:(NSInteger)section {
    objc_setAssociatedObject(self, &sectionKey, @(section), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)section {
    return [objc_getAssociatedObject(self, &sectionKey) integerValue];
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.top = bottom - self.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    self.left = right - self.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (instancetype)cornerAllCornersWithCornerRadius:(CGFloat)cornerRadius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    return self;
}

- (void)addShadow {
    UIView *shadowView = [UIView new];
    [self.superview addSubview:shadowView];
    shadowView.frame = self.bounds;
    ///添加阴影
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    shadowView.layer.shadowOpacity = 0.8;
    shadowView.layer.shadowRadius = 7;
    shadowView.layer.cornerRadius = 7;
    shadowView.clipsToBounds = NO;
    [shadowView addSubview:self];
}

/*XLsn0w*
 直接给View添加阴影不显示阴影效果
 分析原因：因为代码中设置了masksToBounds属性为YES了，将后面设置的阴影效果给裁剪掉了，所以我们看不到阴影效果，
 如果我们将masksToBounds属性为NO，就可以看到阴影效果, 但这样就会失去圆角效果（尽管会出现阴影效果）,
 所以需要向一个两全其美的办法来解决这个问题。给View添加一个父视图，在父视图上添加阴影效果就好，这样就不会对原来View的圆角造成影响了。
 
 clipsToBounds 是指视图上的子视图,如果超出父视图的部分就截取掉,
 masksToBounds 却是指视图的图层上的子图层,如果超出父图层的部分就截取掉
 */
- (void)addShadowForRadius:(CGFloat)radius
             shadowOpacity:(CGFloat)shadowOpacity
              shadowOffset:(CGSize)shadowOffset
               shadowColor:(UIColor*)shadowColor {///添加阴影
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = radius;
    self.layer.cornerRadius = radius;
    self.clipsToBounds = NO;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(TZOscillatoryAnimationType)type{
    NSNumber *animationScale1 = type == TZOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == TZOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

+ (void)showOnlyBigOscillatoryAnimationWithLayer:(CALayer *)layer {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:@(1.2) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:@(1.4) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.2) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}
+ (void)showOnlyRestoreOscillatoryAnimationWithLayer:(CALayer *)layer {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:@(0.8) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}


@end
