//
//  NewsModel.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "NewsModel.h"
#import "NetWorkTools.h"

@implementation NewsModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    //完成初始化
    self = [super init];
    
    //判断对象是否存在
    if (self) {
        
        //使用KVC的方式设置数据
        [self setValuesForKeysWithDictionary:dict];
    }
    
    //返回当前对象
    return self;
    
}

/**
 *  对象初始化方法,类方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类的对象
 */
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    
    //调用上方的方法完成初始化
    return [[self alloc]initWithDict:dict];
}

/**
 *  根据plist文件返回一个模型数组
 *
 *  @param fileName 传入plist文件的名字
 *
 *  @return 模型数组
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@{replyCount = %d,title = %@,digest = %@,imgsrc = %@,ptime = %@,source = %@}",[super description],self.replyCount.intValue,self.title,self.digest,self.imgsrc,self.ptime,self.source];
}
+(void)modelWithUrlString:(NSString*)urlString andWithSucess:(void (^)(NSArray *))sucessBlock andError:(void (^)())errorBlock{
    
//      NSLog(@"newmodel  %@",urlString);
    [[NetWorkTools sharedTools] GET:urlString  parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nonnull responseObject) {
        
      
        NSMutableArray* mArry=[NSMutableArray new];
        NSString* rootKey=responseObject.keyEnumerator.nextObject;
        NSArray* arry=responseObject[rootKey];
        
        [arry enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NewsModel* model=[NewsModel modelWithDict:obj];
            [mArry addObject:model];
        }];
        if(sucessBlock) {
            sucessBlock(mArry.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (errorBlock) {
            errorBlock();
        }
    }];
    
}

@end
