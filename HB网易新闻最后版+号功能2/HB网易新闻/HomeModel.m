//
//  HomeModel.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(NSString*)urlString{
    //http://c.m.163.com/nc/article/list/T1348648517839/0-20.html
    return [NSString stringWithFormat:@"article/list/%@/0-20.html",self.tid];
    
}
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

+(NSMutableArray*)modelWithJSONName:(NSString*)name{
    
    NSString* path=[[NSBundle mainBundle]pathForResource:name ofType:nil];
    
    NSData* data=[NSData dataWithContentsOfFile:path];
    
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString* rootKey=dic.keyEnumerator.nextObject;
    
    NSArray* ary= dic[rootKey];
    NSMutableArray* mAry=[NSMutableArray new];
    [ary enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        HomeModel* model=[HomeModel modelWithDict:obj];
        [mAry addObject:model];
        
    }];
    
    

 NSArray* tem=[mAry sortedArrayUsingComparator:^NSComparisonResult(HomeModel*  _Nonnull obj1, HomeModel*  _Nonnull obj2) {
        
       return  [obj1.tid compare:obj2.tid];
        
    }];
    NSMutableArray* conclusionAry=[NSMutableArray new];
    [tem enumerateObjectsUsingBlock:^(HomeModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [conclusionAry addObject:obj];
        
    }];
    return conclusionAry;
//    return mAry.mutableCopy;

    
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@{tname = %@,tid =%@}",[super description],self.tname,self.tid];
}
-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}

#define Keyname @"name"
#define Keytid  @"tidkey"
#define Keyurlstring @"urlstring"

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_tname forKey:Keyname];
    
    [aCoder encodeObject:_tid forKey:Keytid];
    [aCoder encodeObject:_urlString forKey:Keyurlstring];
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        self.tname=[aDecoder decodeObjectForKey:Keyname];
        
        self.tid=[aDecoder decodeObjectForKey:Keytid];
        self.urlString=[aDecoder decodeObjectForKey:Keyurlstring];
    }
    
    return self;
}


@end
