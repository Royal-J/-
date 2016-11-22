//
//  EssenceVideoCell.m
//  baisibudejie
//
//  Created by HJY on 2016/11/22.
//  Copyright © 2016年 HJY. All rights reserved.
//

#import "EssenceVideoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BDJEssenceModel.h"

@interface EssenceVideoCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;

@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

//视频图片的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHCons;

//评论视图的高度和top的偏移量
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCons;

@end


@implementation EssenceVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (EssenceVideoCell *)videoCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath withModel:(BDJEssenceDetail *)detailModel {
    static NSString *cellId = @"videoCellId";
    EssenceVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EssenceVideoCell" owner:nil options:nil] lastObject];
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
    
    //视频简介
    self.descLabel.text = detailModel.text;
    
    //播放图片
    NSString *videoString = [detailModel.video.thumbnail_small firstObject];
    NSURL *videoUrl = [NSURL URLWithString:videoString];
    [self.videoImageView sd_setImageWithURL:videoUrl placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    //修改高度
    //图片的宽度/图片的高度 == width/height
    CGFloat imageH = (kscreenWidth-20)*detailModel.video.height.floatValue/detailModel.video.width.floatValue;
    
    self.imageHCons.constant = imageH;
    
    //播放次数
    self.playNumLabel.text = [detailModel.video.playcount stringValue];
    
    //视频时间
    NSInteger min = 0;
    NSInteger sec = [detailModel.video.duration integerValue];
    if (sec >= 60) {
        min = sec / 60;
        sec = sec % 60;
    }
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    
    //评论文字
    if (detailModel.top_comments.count > 0) {
        BDJEssenceComment *comment = [detailModel.top_comments firstObject];
        self.commentLabel.text = comment.content;
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
