
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)

- (void)setImageFromURLString:(NSString *)url
        placeholderImageNamed:(NSString *)placeholderImageNamed;
- (void)setImageFromUrl:(NSString *)url;
- (void)setImageFromURLString:(NSString *)url
         placeholderImageName:(NSString *)placeholderImageName;
- (void)setImageFromURLString:(NSString *)url
            placeholderAvatar:(NSString *)placeholderAvatar;

- (void)setImageFromURLString:(NSString *)url;

- (void)centerClip;

@end

NS_ASSUME_NONNULL_END
