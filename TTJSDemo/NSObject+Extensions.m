//
//  NSObject+Extensions.m
//  TTJSDemo
//
//  Created by zhang liangwang on 17/3/20.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "NSObject+Extensions.h"

@implementation NSObject (Extensions)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    
    //方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    if (signature == nil) {
        
//        @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
        [NSException raise:@"没有签名" format:@"%@方法找不到",NSStringFromSelector(aSelector)];
    }
    
    // NSInvocation 方法名 方法参数 方法返回值
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; //除去self _cmd
    paramsCount = MIN(paramsCount, objects.count);
    
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([objects isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i+2];
    }
    
    // 方法调用
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) {
        
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}

@end
