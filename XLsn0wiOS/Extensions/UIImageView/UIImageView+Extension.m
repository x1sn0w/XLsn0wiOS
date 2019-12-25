
#import "UIImageView+Extension.h"
#import "ImportHeader.h"

@implementation UIImageView (Extension)

- (void)setImageFromURLString:(NSString *)url
        placeholderImageNamed:(NSString *)placeholderImageNamed {
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageNamed:placeholderImageNamed]];
}

- (void)setImageFromURLString:(NSString *)url
            placeholderAvatar:(NSString *)placeholderAvatar {
    if (isNotNull(url)) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderAvatar]];
    } else {
        self.image = [UIImage imageNamed:@"placeholderAvatar"];
    }
}

- (void)setImageFromURLString:(NSString *)url placeholderImageName:(NSString *)placeholderImageName {
    if (isNotNull(url)) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderImageName]];
    } else {
        self.image = [UIImage imageNamed:@"PlaceholderImg"];
    }
}

- (void)setImageFromURLString:(NSString *)url {
    if (isNotNull(url)) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"PlaceholderImg"]];
    } else {
        self.image = [UIImage imageNamed:@"PlaceholderImg"];
    }
}

///居中裁剪
- (void)centerClip {
    [self setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.contentMode =  UIViewContentModeScaleAspectFill;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.clipsToBounds  = YES;
}

- (void)setImageFromUrl:(NSString *)url {
    if (isNotNull(url)) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage* image = [[UIImage alloc] initWithData:imageData];
//            XLsn0wLog(@"imageData = %@", imageData);
            if (imageData != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //在这里做UI操作(UI操作都要放在主线程中执行)
                    self.image = image;
                });
            } else {
//                self.image = placeholderAppImage;
            }
        });
    }
}

@end
