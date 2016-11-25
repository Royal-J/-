//
//  EssenceTextCell.m
//  baisibudejie
//
//  Created by HJY on 2016/11/22.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import "EssenceTextCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BDJEssenceModel.h"

@interface EssenceTextCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

//评论视图的高度和top的偏移量
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCons;


@end


@implementation EssenceTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (EssenceTextCell *)textCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel {
    static NSString *cellId = @"textCellId";
    EssenceTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceTextCell" owner:nil options:nil] lastObject];
    }
    //数据
    cell.detailModel = detailModel;
    return cell;
}

//重写cell的detailModel属性的setter方法
- (void)setDetailModel:(BDJEssenceDetail *)detailModel {
    _detailModel = detailModel;
    
    //用户图片
    NSString *headerString = [detailModel.u.header firstObject];
    NSURL *url = [NSURL URLWithString:headerString];
    [self.userImageView sd_setImageWithURL:url];
    
    //用户名
    self.userNameLabel.text = detailModel.u.name;
    
    //发布时间
    self.passTimeLabel.text = detailModel.passtime;
    
    //文字
    self.descLabel.text = detailModel.text;
    
    //评论文字
    if (detailModel.top_comments.count > 0) {
        BDJEssenceComment *comment = [detailModel.top_comments firstObject];
        self.commentLabel.text = comment.content;
    }else{
        self.commentLabel.text = nil;
    }
    
    //强制cell布局一次
    [self layoutIfNeeded];
    
    
    if (detailModel.top_comments.count > 0) {
        self.commentViewYCons.constant = 10;
        self.commentViewHCons.constant = self.commentLabel.frame.size.height + 10 + 10;
    }else{
        //没有评论的部分
        
        self.commentViewHCons.constant = 0;
        self.commentViewYCons.constant = 0;
    }
    
    //标签
    NSMutableString *tagString = [NSMutableString string];
    for (NSInteger i=0; i<detailModel.tags.count; i++) {
        BDJEssenceTag *tag = detailModel.tags[i];
        [tagString appendFormat:@"%@ ", tag.name];
    }
    self.tagLabel.text = tagString;
    
    //顶、踩、分享、评论的数量
    [self.dingButton setTitle:detailModel.up forState:(UIControlStateNormal)];
    [self.caiButton setTitle:[detailModel.down stringValue] forState:(UIControlStateNormal)];
    [self.shareButton setTitle:[detailModel.forward stringValue] forState:(UIControlStateNormal)];
    [self.commentButton setTitle:detailModel.comment forState:(UIControlStateNormal)];

    //强制刷新一次
    [self layoutIfNeeded];
    
    //获取cell的高度
    detailModel.cellHeight = @(CGRectGetMaxY(self.dingButton.frame) + 10 + 10);
}


//更多按钮点击事件
- (IBAction)clickMoreBtn:(UIButton *)sender {
}
//播放按钮点击事件
- (IBAction)playAction:(UIButton *)sender {
}

//顶按钮
- (IBAction)dingAction:(UIButton *)sender {
}

//踩按钮
- (IBAction)caiAction:(UIButton *)sender {
}

//分享按钮
- (IBAction)shareAction:(UIButton *)sender {
}

//评论按钮
- (IBAction)commentAction:(UIButton *)sender {
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
