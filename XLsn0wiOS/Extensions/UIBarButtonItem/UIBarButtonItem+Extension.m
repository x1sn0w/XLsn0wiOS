
#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action {
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

+ (UIBarButtonItem *)initWithNormalImageBig:(NSString *)image target:(id)target action:(SEL)action
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height
{
    UIImage *normalImage = [UIImage imageNamed:image];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, height);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target font:(UIFont *)font action:(SEL)action
{
    NSInteger width = [UIBarButtonItem getWidthWithTitle:title];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, 40);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = font;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    [label sizeToFit];
    return label.frame.size.width;
}

/**
 *  没有图片调整的按钮
 */
//+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
//    UIButton *button = [[UIButton alloc] init];
//    //    button.backgroundColor = [UIColor redColor];
//    // 设置按钮的背景图片
//    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    if (highImageName != nil) {
//        [button setBackgroundImage: [UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
//    }
//    // 设置按钮的尺寸为背景图片的尺寸
//    button.size = button.currentBackgroundImage.size;
//    button.adjustsImageWhenHighlighted = NO;
//    //监听按钮的点击
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//
//    return [[UIBarButtonItem alloc] initWithCustomView:button];
//}
@end
