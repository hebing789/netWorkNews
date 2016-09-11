//
//  SectionHeadCollectionView.h
//  HB网易新闻
//
//  Created by hebing on 16/9/7.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeadCollectionView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *lalbe;

@property(nonatomic,copy) NSString*title;
//- (void)setIndexPath:(NSIndexPath *)indexPath withKind:(NSString *)kind;
@end
