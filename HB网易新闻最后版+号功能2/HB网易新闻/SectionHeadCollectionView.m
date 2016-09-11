//
//  SectionHeadCollectionView.m
//  HB网易新闻
//
//  Created by hebing on 16/9/7.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "SectionHeadCollectionView.h"
#define screemW    [UIScreen mainScreen].bounds.size.width
#define screemH    [UIScreen mainScreen].bounds.size.height
@implementation SectionHeadCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTitle:(NSString *)title{
    _title=title;
    self.lalbe.text=title;

}
//- (void)setIndexPath:(NSIndexPath *)indexPath withKind:(NSString *)kind{
//    
//    
//    
//    
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        
//        self.lalbe.text = [NSString stringWithFormat:@"头View的索引 %ld组 %ld item",indexPath.section,indexPath.item];
//    }
//}



@end
