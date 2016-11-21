//
//  UIButton+Util.m
//  baisibudejie
//
//  Created by HJY on 2016/11/21.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)

//创建按钮的便利方法
+ (UIButton *)createBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName highlightBgImageName:(NSString *)highlightBgImageName target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if (title) {
        [btn setTitle:title forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    
    if (bgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:(UIControlStateNormal)];
    }
    
    if (highlightBgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:highlightBgImageName] forState:(UIControlStateHighlighted)];
    }
    
    if (action && target) {
        [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return btn;
}


@end
