
#import "XLsn0wError.h"

#define LLErrorDomain @" An Error Has Occurred"
//首先需要知道NSError的构建参数，
//1.domain：—— 错误域 (自定义，作用我不是很清楚暂且理解为提示作用吧)
//2.code： —— 错误编码(自己定义，编码应当与错误内容匹配，相当于看到404就知道是访问不了)
//3.userInfo：——错误原因(自己定义，给出错误的原因)

typedef enum {
    LLErrorDefult = 0,
    LLErrorConnect   ,
    LLErrorNotFind,
    LLErrorMatch
} LLErrorFailed;

@implementation XLsn0wError

#pragma mark —— 定义错误
/**返回一个错误*/
+ (NSError *)errorWithCode:(LLErrorFailed)code{
    NSString * localizedDescription;
    switch (code) {
        case LLErrorConnect:
            localizedDescription = @"网络链接错误";
            break;
        case LLErrorNotFind:
            localizedDescription = @"没有找到";
            break;
            case LLErrorMatch:
            localizedDescription = @"匹配错误";
            break;
        default:
            localizedDescription = @"输入错误";
            break;
    }

    NSDictionary * userInfo = [NSDictionary dictionaryWithObject:localizedDescription forKey:NSLocalizedDescriptionKey];
    NSError *aError = [NSError errorWithDomain:LLErrorDomain code:code userInfo:userInfo];
    return aError;
}

@end
