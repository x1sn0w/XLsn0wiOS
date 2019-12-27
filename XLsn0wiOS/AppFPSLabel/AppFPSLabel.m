
#import "AppFPSLabel.h"
#import "YYWeakProxy.h"

@interface AppFPSLabel ()
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
}
@end

@implementation AppFPSLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 初始化
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    
    _font = [UIFont fontWithName:@"Courier" size:14];
    if (_font)
    {
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    else
    {
        _font = [UIFont fontWithName:@"Georgia" size:14];
        _subFont = [UIFont fontWithName:@"Georgia" size:4];
    }
    
    // 开启定时器
    _link = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(update:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)update:(CADisplayLink *)link {
    // 第一次进来
    if(_lastTime == 0)
    {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    
    // 两帧间隔时间
    NSTimeInterval delta = link.timestamp - _lastTime;
    
    // 过滤刷新次数
    if (delta < 1) return;
    
    // 计算FPS
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
//    self.text = [NSString stringWithFormat:@"Test %d FPS", (int)round(fps)];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Test %d FPS",(int)round(fps)]];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(5, attributedText.length - 3-5)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(attributedText.length - 3, 3)];
    [attributedText addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, attributedText.length)];
    
    [attributedText addAttribute:NSFontAttributeName
                           value:[UIFont boldSystemFontOfSize:14]
                           range:NSMakeRange(0, 4)];
    [attributedText addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(attributedText.length - 4, 1)];
    self.attributedText = attributedText;
}

- (void)dealloc {
    [_link invalidate];
    NSLog(@"timer release");
}

@end
