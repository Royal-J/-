//
//  EssenceImageCell.h
//  baisibudejie
//
//  Created by HJY on 2016/11/22.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDJEssenceDetail;
@interface EssenceImageCell : UITableViewCell

//数据
@property (nonatomic, strong)BDJEssenceDetail *detailModel;

//便利创建cell的方法
+ (EssenceImageCell *)imageCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel;

@end
