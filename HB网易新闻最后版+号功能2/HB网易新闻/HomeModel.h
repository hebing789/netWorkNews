//
//  HomeModel.h
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject<NSCoding>

@property(nonatomic,copy) NSString* tname;
@property(nonatomic,copy) NSString *tid;

@property(nonatomic,copy) NSString*urlString;


/**
 *  对象初始化方法,对象方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类的对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  对象初始化方法,类方法
 *
 *  @param dict 传入字典数据
 *
 *  @return 返回当前类
 */
+(instancetype) modelWithDict:(NSDictionary *)dict;

+(NSMutableArray*)modelWithJSONName:(NSString*)name;

-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key;
@end
