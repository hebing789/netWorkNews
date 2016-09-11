//
//  HomeCell.m
//  HB网易新闻
//
//  Created by hebing on 16/9/6.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "HomeCell.h"
//#import "HeadLineCollectionControl.h"
#import "NewsController.h"
@interface HomeCell()

//注意这个的类型要是
//@property(nonatomic,strong) HeadLineCollectionControl* cv;
@property(nonatomic,strong)NewsController*cv;
@end
@implementation HomeCell

-(void)awakeFromNib{
    
    //注意掉用父类方法
    [super awakeFromNib];
    
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   self.cv =[sb instantiateInitialViewController];
    
//    =cv;
    self.cv.view.frame=self.contentView.frame;//这也可以
    
//    NSLog(@"homecell  %@",self.urlString);

//    self.cv.urlString=self.urlString;//写在这里不行,
    
    [self.contentView addSubview:self.cv.view];
//    [self addSubview:self.cv.view];//这个位置也不报错,建议用上面的写法
    
    
}

-(void)setUrlString:(NSString *)urlString{
    _urlString=urlString;
    self.cv.urlString=self.urlString;

}
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.cv.view.frame=self.contentView.frame;
}

@end
