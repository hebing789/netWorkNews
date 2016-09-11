//
//  NewsCell.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(NewsModel *)model{
    _model=model;
    
    [self.iv_img sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.lb_title.text=model.title;
    self.lb_source.text=model.source;
    
    self.lb_replyCount.text=[NSString stringWithFormat:@"%@跟帖",model.replyCount];
    
    if (model.imgextra) {
        [model.imgextra enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *imgSrc = obj[@"imgsrc"];
            [self.iv_imgAry[idx] sd_setImageWithURL:[NSURL URLWithString:imgSrc]];
            
        }];
        
    }
    
    

}
+(NSString*)identifierWithModel:(NewsModel*)model{
    
    NSString* identifer=@"newscell";
    if (model.imgType) {
        identifer=@"newscell2";
    }
    if (model.imgextra) {
        identifer=@"newscell3";
    }
    return identifer;
    
}
+(CGFloat)getHightWithModel:(NewsModel*)model{
    CGFloat hight=100;
    if (model.imgType) {
        hight=200;
        return hight;
    }

if (model.imgextra) {
    hight=150;
    return hight;
    
}
    return hight;
    
}


@end
