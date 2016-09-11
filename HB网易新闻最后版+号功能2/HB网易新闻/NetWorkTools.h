//
//  NetWorkTools.h
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetWorkTools : AFHTTPSessionManager

+(instancetype)sharedTools;
@end
