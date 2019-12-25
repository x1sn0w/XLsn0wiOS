//
//  UIButton+Extensions.h
//  TimeForest
//
//  Created by TimeForest on 2018/10/10.
//  Copyright © 2018年 TimeForest. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ButtonImgViewStyleTop,
    ButtonImgViewStyleLeft,
    ButtonImgViewStyleBottom,
    ButtonImgViewStyleRight,
} ButtonImgViewStyle;

typedef NS_ENUM(NSUInteger, ImagePositionType) {
    ImagePositionLeft,
    ImagePositionRight,
    ImagePositionTop,
    ImagePositionBottom
};

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle) {
    ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};

typedef void(^SGCountdownCompletionBlock)(void);

@interface UIButton (Extensions)

@property (nonatomic, assign) NSTimeInterval responseTimeInterval;/// 设置按钮的点击响应间隔时间 button.responseTimeInterval = 2.0;

/**
 * 设置 按钮 图片所在的位置
 * style   图片位置类型（上、左、下、右）
 * size    图片的大小
 * space 图片跟文字间的间距
 */

- (void)setImgViewStyle:(ButtonImgViewStyle)style
              imageSize:(CGSize)size
                  space:(CGFloat)space;

- (void)setImagePosition:(ImagePositionType)position
                   space:(CGFloat)space;

/** 倒计时，s倒计,带有回调 */
- (void)countdownWithSec:(NSInteger)sec completion:(SGCountdownCompletionBlock)block;
/** 倒计时,秒字倒计，带有回调 */
- (void)countdownWithSecond:(NSInteger)second completion:(SGCountdownCompletionBlock)block;

- (void)titleFont:(UIFont *)font;

@property (strong, nonatomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;

/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。
 
 */
-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
