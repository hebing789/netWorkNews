//
//  NetWorkTools.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "NetWorkTools.h"

@implementation NetWorkTools
+(instancetype)sharedTools{
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration* configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest=15;
        instance=[[self alloc]initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/"] sessionConfiguration:configuration];
    });
    return instance;
    
}
@end
