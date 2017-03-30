//
//  TTProgressView.m
//  TTJSDemo
//
//  Created by zhang liangwang on 17/3/17.
//  Copyright © 2017年 zhangliangwang. All rights reserved.
//

#import "TTProgressView.h"

@implementation TTProgressView


- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat radius = rect.size.width / 2;
    
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat startAngle = - M_PI_2;
    
    CGFloat endAngle = - M_PI_2 + 2 * M_PI * self.progress;
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius-5 startAngle:startAngle endAngle:endAngle clockwise:true];
    [path stroke];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



































