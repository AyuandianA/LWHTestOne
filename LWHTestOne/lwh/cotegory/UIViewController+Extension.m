

#import "UIViewController+Extension.h"
#import <objc/message.h>

/**
 这个类目是为了打印dealloc存在的，方便检测内存泄漏
 */
@implementation UIViewController (Extension)

+(void)load
{
    Method dealloc = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method ym_dealloc = class_getInstanceMethod(self, @selector(ym_dealloc));
    method_exchangeImplementations(dealloc, ym_dealloc);
}

-(void)ym_dealloc
{
//    NSLog(@"dealloc-->%@",NSStringFromClass([self class]));
    
    [self ym_dealloc];
}

@end

