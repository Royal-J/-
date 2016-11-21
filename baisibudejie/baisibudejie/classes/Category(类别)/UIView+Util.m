//
//  UIView+Util.m
//  baisibudejie
//
//  Created by HJY on 2016/11/21.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;   //----取值
    frame.origin.x = x;    //----赋值
    self.frame = frame;     //----把值返回
}

- (CGFloat)x {
    return self.frame.origin.x;
}


- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)y {
    return self.frame.origin.y;
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}
@end
