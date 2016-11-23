//
//  BDJMenuViewController.h
//  baisibudejie
//
//  Created by HJY on 2016/11/23.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import "BaseViewController.h"

/*精华和最新界面公共的分类*/
@interface BDJMenuViewController : BaseViewController

//标题列表数据
@property (nonatomic, strong)NSArray *subMenus;

//右边按钮的图片
@property (nonatomic, copy)NSString *righrImageName;

//右边按钮的高亮图片
@property (nonatomic, copy)NSString *righrHLImageName;

//右边按钮的点击事件
@property (nonatomic, strong)void (^rightBtnVlock)(void);

@end
