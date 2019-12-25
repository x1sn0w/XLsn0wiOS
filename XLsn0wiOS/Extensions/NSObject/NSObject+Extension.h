//
//  NSObject+Extension.h
//  ChineseMedicine
//
//  Created by Mac on 2019/7/3.
//  Copyright © 2019 fbw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)

@property (nonatomic, strong) NSDictionary* responseData;

+ (void)swizzleClassMethod:(Class)className
            originSelector:(SEL)originSelector
             otherSelector:(SEL)otherSelector;

+ (void)swizzleInstanceMethod:(Class)className
               originSelector:(SEL)originSelector
                otherSelector:(SEL)otherSelector;

/**
 获取全设备底部安全区域高度
 
 @return 安全区域高度
 */
- (CGFloat)getBottomSafeAreaHeight;

/**
 获取全设备底部TabBar高度
 
 @return TabBar高度
 */
- (CGFloat)getBottomTabBarHeight;

/**
 获取全设备顶部总高度(状态栏+导航栏)
 
 @return 顶部总高度(状态栏+导航栏)
 */
- (CGFloat)getTopTotalHeight;

/**
 获取全设备顶部导航栏高度
 
 @return 导航栏高度
 */
- (CGFloat)getTopNavBarHeight;

/**
 获取全设备顶部状态栏高度
 
 @return 状态栏高度
 */
- (CGFloat)getTopStatusBarHeight;

- (NSMutableArray *)getFilterArrayFromSourceArray:(NSMutableArray *)sourceArray;

/**
 获取富文本字符串Rect
 
 @param contentString 字符串 内容
 @param contentFont   字符串 字体
 @param contentWidth  字符串 宽度(常量)
 @param lineSpacing   字符串 行间距
 
 @return 富文本字符串Rect
 */
- (CGRect)getAttributedStringRectFromContentString:(NSString*)contentString
                                       contentFont:(UIFont*)contentFont
                                      contentWidth:(CGFloat)contentWidth
                                       lineSpacing:(CGFloat)lineSpacing;


- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath
               fromTableView:(UITableView *)tableView;

/// 刷新多行Cell
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                 fromTableView:(UITableView *)tableView;

- (int)getRCIMTotalUnreadCount;
- (void)preventGestureConflicts:(UIScrollView *)scrollView
           navigationController:(UINavigationController *)navigationController;

/// 禁止某个页面侧滑返回
- (void)disableSlideBackFromNavigationController:(UINavigationController *)navigationController
                                       self_view:(UIView *)self_view;

- (void)make3DTouch;

- (NSString *)getPriceRMBFormatStringFromCGFloatPrice:(CGFloat)priceCGFloat;

@end

NS_ASSUME_NONNULL_END
