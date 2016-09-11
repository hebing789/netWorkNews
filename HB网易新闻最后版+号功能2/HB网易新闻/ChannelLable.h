//
//  ChannelLable.h
//  HB网易新闻
//
//  Created by hebing on 16/9/6.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelLable : UILabel

+(instancetype)lableWithName:(NSString*)name;
@property(nonatomic,assign)float scale;

@end
