//
//  ChannelLable.m
//  HB网易新闻
//
//  Created by hebing on 16/9/6.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "ChannelLable.h"

@implementation ChannelLable

+(instancetype)lableWithName:(NSString*)name{
    
    ChannelLable* lable=[[ChannelLable alloc]init];
    [lable setText:name];
    lable.textColor=[UIColor blackColor];
    [lable setFont:[UIFont systemFontOfSize:15]];
    [lable setTextAlignment:NSTextAlignmentCenter];
    [lable sizeToFit];
    lable.userInteractionEnabled=YES;
    return lable;
    
}


-(void)setScale:(float)scale{
    
    _scale=scale;
    
    float max=0.2;
    
    [self setTextColor:[UIColor colorWithRed:scale green:0 blue:0 alpha:1]];
    
    self.transform=CGAffineTransformMakeScale(0.2*scale+1, 0.2*scale+1);
    
}

@end
