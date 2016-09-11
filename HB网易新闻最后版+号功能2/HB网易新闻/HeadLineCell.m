//
//  HeadLineCell.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "HeadLineCell.h"
#import "UIImageView+WebCache.h"
#import "HeadLineModel.h"

@implementation HeadLineCell

-(void)setModel:(HeadLineModel *)model{
    _model=model;
    [self.iv_img sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    self.la_lable.text=model.title;
    self.pageControl.currentPage=self.tag;
    
    
}
@end
