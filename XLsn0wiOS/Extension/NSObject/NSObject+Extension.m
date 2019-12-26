//
//  NSObject+Extension.m
//  ChineseMedicine
//
//  Created by Mac on 2019/7/3.
//  Copyright © 2019 fbw. All rights reserved.
//

//导航栏的高度
//状态栏的高度

//非iPhoneX：状态栏高度(20.f)+导航栏高度(44.f) = 64.f,    20 + 44

//iPhoneX系列：状态栏高度(44.f)+导航栏高度(44.f) = 88.f. = 44 + 44

#define kTopStatusBarHeight   [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTopNavBarHeight      44 ///恒定

//iphoneX-SafeArea的高度
#define kBottomSafeAreaHeight (kTopStatusBarHeight > 20 ? 34 : 0)

//TabBar+iphoneX-SafeArea的高度
#define kBottomTabBarHeight (49 + kBottomSafeAreaHeight)

//导航栏+状态栏的高度

#define kTopTotalHeight (kTopStatusBarHeight + kTopNavBarHeight)

#import "NSObject+Extension.h"
#import "XLsn0wiOSHeader.h"

@implementation NSObject (Extension)

+ (void)swizzleClassMethod:(Class)className
            originSelector:(SEL)originSelector
             otherSelector:(SEL)otherSelector {
    Method otherMehtod = class_getClassMethod(className, otherSelector);
    Method originMehtod = class_getClassMethod(className, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethod:(Class)className
               originSelector:(SEL)originSelector
                otherSelector:(SEL)otherSelector {
    Method otherMehtod = class_getInstanceMethod(className, otherSelector);
    Method originMehtod = class_getInstanceMethod(className, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}


/// 添加responseData属性
static char responseDataKey;
- (NSDictionary *)responseData {
    return objc_getAssociatedObject(self, &responseDataKey);
}

- (void)setResponseData:(NSDictionary *)responseData {
    objc_setAssociatedObject(self, &responseDataKey, responseData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 获取全设备底部安全区域高度

 @return 安全区域高度
 */
- (CGFloat)getBottomSafeAreaHeight {
    CGFloat BottomSafeAreaHeight = kBottomSafeAreaHeight;
    return BottomSafeAreaHeight;
}

/**
 获取全设备底部TabBar高度

 @return TabBar高度
 */
- (CGFloat)getBottomTabBarHeight {
    CGFloat BottomTabBarHeight = kBottomTabBarHeight;
    return BottomTabBarHeight;
}

/**
 获取全设备顶部总高度(状态栏+导航栏)
 
 @return 顶部总高度(状态栏+导航栏)
 */
- (CGFloat)getTopTotalHeight {
    CGFloat TopTotalHeight = kTopTotalHeight;
    return TopTotalHeight;
}

/**
 获取全设备顶部导航栏高度

 @return 导航栏高度
 */
- (CGFloat)getTopNavBarHeight {
    CGFloat TopNavBarHeight = kTopNavBarHeight;
    return TopNavBarHeight;
}

/**
 获取全设备顶部状态栏高度

 @return 状态栏高度
 */
- (CGFloat)getTopStatusBarHeight {
    CGFloat TopStatusBarHeight = kTopStatusBarHeight;
    return TopStatusBarHeight;
}

/*
 
 有序的去重
 1.开辟新的内存空间(使用containsObject：方法)
 判断是否存在，若不存在则添加到数组中，得到最终结果的顺序不发生变化
 NSArray *originalArray = @[@1, @2, @3, @1, @3];
 NSMutableArray *resultArray = [NSMutableArray array];
 
 for (NSString *item in originalArray) {
    if (![resultArray containsObject:item]) {
       [resultArray addObject:item];
    }
 }
 NSLog(@"resultArray : %@", resultArray);
 
 2.通过valueForKeyPath (@"@distinctUnionOfObjects.self")
 NSArray *originalArray = @[@1, @2, @3, @1, @3];
 NSArray *resultArray = [originalArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
 NSLog(@"result: %@", resultArray);
 
 模型对象的去重
 1.通过model类的唯一标识来判断
 定义一个简单的model类
 
 // Model.h
 @interface Model : NSObject
 
 @property (nonatomic, copy) NSString *ID;
 @property (nonatomic, copy) NSString *name;
 
 @end
 
 // Model.m
 @implementation Model
 
 @end
 
 ***** 去除数组中重复model对象
 //创建model类对象
 Model *model1 = [[Model alloc]init];
 model1.ID = @"1";
 Model *model2 = [[Model alloc]init];
 model1.ID = @"2";
 Model *model3 = [[Model alloc]init];
 model1.ID = @"3";
 Model *model4 = [[Model alloc]init];
 model1.ID = @"1";
 Model *model5 = [[Model alloc]init];
 model1.ID = @"3";
 //添加到数组中
 NSMutableArray *originalArray = [NSMutableArray arrayWithArray:@[model1,model2,model3,model4,model5]];
 
 NSMutableArray *resultArray = [NSMutableArray arrayWithArray:originalArray];
 //去重
 for (NSInteger x = 0; x < originalArray.count; x++) {
 
    for (NSInteger y = x+1;y < originalArray.count; y++) {
         Model *tempModel = originalArray[x];
        Model *model = originalArray[y];
        if ([tempModel.ID isEqualToString:model.ID]) {
            [resultArray removeObject:model];
          }
       }
    }
     NSLog(@"result: %@", resultArray);
 */

/**
 排序的去重
 
 很多时候可能会遇到需要去除NSArray重复的元素，用了很多方法。
 
 最方便快捷的是NSSet.但是NSSet去重后有时候数组元素的顺序会打乱。
 
 于是换了另外一种方法如下：

 @param sourceArray 没有去重的数组
 @return 排序去重后的数组
 */
- (NSMutableArray *)getFilterArrayFromSourceArray:(NSMutableArray *)sourceArray {
    NSMutableArray *filterArray = [NSMutableArray array];
    
    for (int i = 0; i < sourceArray.count; i++) {
        
        if ([filterArray containsObject:[sourceArray objectAtIndex:i]] == NO) {
            
            [filterArray addObject:[sourceArray objectAtIndex:i]];
            
        }
        
    }
    
    return filterArray;
}

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
                                       lineSpacing:(CGFloat)lineSpacing {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:contentString];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.lineSpacing = lineSpacing;
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, contentString.length)];
    
    [attributeString addAttribute:NSFontAttributeName value:contentFont range:NSMakeRange(0, contentString.length)];
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [attributeString boundingRectWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX) options:options context:nil];
    
    return rect;
}

//调整行间距
+ (NSMutableAttributedString *)atttibutedStringForString:(NSString *)string LineSpace:(CGFloat)lineSpace {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    return attributedString;
    
}

//返回字符串所占用的尺寸.
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize contentString:(NSString*)contentString{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [contentString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

///设置属性文字
+ (NSMutableAttributedString *)attributedStringForString:(NSString *)string
                                             attributeds:(NSDictionary *)attributeds
                                               hasPrefix:(NSString *)hasPrefix
                                               hasSuffix:(NSString *)hasSuffix {
    
    
    if (string.length == 0) {
        
        return nil;
    }
    
    if (hasSuffix.length ==0) {
        
        hasSuffix = @"";
    }
    
    if (hasPrefix.length == 0) {
        hasPrefix = @"";
        
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@",hasPrefix,string,hasSuffix];
    
    NSRange range = [str rangeOfString:string];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attributedString addAttributes:attributeds range:range];
    
    
    if ([attributeds objectForKey:@"NSParagraphStyle"]) {
        
        NSMutableParagraphStyle * paragraphStyle = [attributeds objectForKey:@"NSParagraphStyle"];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
        
    }
    
    
    return attributedString;
    
}

/// 刷新单行Cell
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath
               fromTableView:(UITableView *)tableView {
    [tableView reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationNone];
}

/// 刷新多行Cell
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
                 fromTableView:(UITableView *)tableView {
    [tableView reloadRowsAtIndexPaths:indexPaths
                     withRowAnimation:UITableViewRowAnimationNone];
}

- (void)preventGestureConflicts:(UIScrollView *)scrollView
           navigationController:(UINavigationController *)navigationController {
    for (UIGestureRecognizer *gestureRecognizer in navigationController.view.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            [scrollView.panGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
        }
    }
}
/// 禁止某个页面侧滑返回
- (void)disableSlideBackFromNavigationController:(UINavigationController *)navigationController
                                       self_view:(UIView *)self_view {
    id traget = navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:traget action:nil];
    [self_view addGestureRecognizer:pan];
}

- (void)make3DTouch {
    AudioServicesPlaySystemSound(1520);///3D Touch振动
}

- (NSString *)getPriceRMBFormatStringFromCGFloatPrice:(CGFloat)priceCGFloat {
    NSString* RMBPriceString = PriceDoubleFormat(priceCGFloat);
    return PriceRMBFormat(RMBPriceString.doubleValue);
}

@end
