
#import "UITextView+Extension.h"
#import "XLsn0wiOSHeader.h"

@interface UITextView ()

@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数

@end

@implementation UITextView (Extension)

static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static const void *limitLengthKey = &limitLengthKey;

#pragma mark -- setter/getter方法

//显示占位符label的setter/getter方法
-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);
}

//显示字数label的setter/getter方法
- (void)setWordCountLabel:(UILabel *)wordCountLabel {
    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)wordCountLabel {
    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);
}

//供外接访问的占位字符串，以便设置占位文字的setter/getter方法
- (void)setPlaceholder:(NSString *)placeholder {
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}

- (NSString *)placeholder {
    return objc_getAssociatedObject(self, &PLACEHOLD);
}

//供外接访问的最大输入字数，设置最大文字个数的setter/getter方法
- (NSNumber *)limitLength {
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self addLimitLengthObserver:[limitLength intValue]];
    [self setWordcountLable:limitLength];
}

#pragma mark -- 配置占位符标签
- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self];
    // 占位字符
    
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = [UIFont systemFontOfSize:13.];
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    [self addSubview:self.placeholderLabel];
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
}

#pragma mark -- 设置字数限制标签
- (void)setWordcountLable:(NSNumber *)limitLength {
    //字数限制
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 65, CGRectGetHeight(self.frame) - 20, 60, 20)];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.font = [UIFont systemFontOfSize:13.];
    if (self.text.length > [limitLength integerValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,limitLength];
    [self addSubview:self.wordCountLabel];
}

#pragma mark -- 注册限制位数的通知
- (void)addLimitLengthObserver:(int)length {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 限制输入的位数
- (void)limitLengthEvent {
    
    if ([self.text length] > [self.limitLength intValue]) {
        
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}

#pragma mark -- NSNotification
- (void)textFieldChanged:(NSNotification *)notification {
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        
        if (self.text.length == 0) {
            
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.limitLength) {
        
        NSInteger wordCount = self.text.length;
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
#pragma mark -- 想提示用户输入已经超出最大字数可以打开此行代码
            //            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"超过最大字数" message:@"您已经超出了最大字数,超出部分将无法显示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            [view show];
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%@",(long)wordCount,self.limitLength];
    }
}

-(BOOL)isShowToolBar {
    return NO;
}
-(void)setIsShowToolBar:(BOOL)isShowToolBar {
    if (isShowToolBar) {
        self.inputAccessoryView = [self tooBarForKeyboardTools];
    }
}

-(UIToolbar *)tooBarForKeyboardTools {
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    imageview.image = [UIImage xlsn0w_imageWithColor:NavBgColor];
    [bar addSubview: imageview];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    [button setTitle:@"隐藏"forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hideKeyboardTools) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:TabBarTitleColor forState:UIControlStateNormal];
    [bar addSubview:button];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexibleitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:self action:nil];
    NSArray *items = @[flexibleitem,buttonItem];
    [bar setItems:items animated:YES];
    return  bar;
}

-(void)hideKeyboardTools {
    [self resignFirstResponder];
}

@end
