//
//  NewsCell.h
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_img;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_replyCount;

@property (weak, nonatomic) IBOutlet UILabel *lb_source;
@property(nonatomic,strong)NewsModel* model;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *iv_imgAry;
+(NSString*)identifierWithModel:(NewsModel*)model;
+(CGFloat)getHightWithModel:(NewsModel*)model;
@end
