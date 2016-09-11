//
//  HeadLineCell.h
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadLineModel;
@interface HeadLineCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_img;

@property (weak, nonatomic) IBOutlet UILabel *la_lable;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic,strong)HeadLineModel* model;
@end
