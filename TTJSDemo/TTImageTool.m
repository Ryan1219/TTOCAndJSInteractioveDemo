//
//  TTImageTool.m
//  TTJSDemo
//
//  Created by zhang liangwang on 17/3/17.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTImageTool.h"

@implementation TTImageTool

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    
    
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGRect rect = (CGRect){0, 0, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, false, [UIScreen mainScreen].scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return image;
    
}

@end





















































