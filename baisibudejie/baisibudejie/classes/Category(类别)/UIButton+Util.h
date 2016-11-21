//
//  UIButton+Util.h
//  baisibudejie
//
//  Created by HJY on 2016/11/21.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)

+ (UIButton *)createBtnTitle:(NSString *)title bgImageName:(NSString *)bgImageName highlightBgImageName:(NSString *)highlightBgImageName target:(id)target action:(SEL)action;

@end
