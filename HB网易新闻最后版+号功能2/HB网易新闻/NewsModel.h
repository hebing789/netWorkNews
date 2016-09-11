//
//  NewsModel.h
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

//回复
@property(nonatomic,copy) NSNumber *replyCount;
//主标题
@property(nonatomic,copy) NSString *title;
//副标题
@property(nonatomic,copy) NSString *digest;
//图片
@property(nonatomic,copy) NSString *imgsrc;
//时间
@property(nonatomic,copy) NSString *ptime;
//新闻来源
@property(nonatomic,copy) NSString *source;

//大图的标示
@property(nonatomic,assign) BOOL imgType;

//3张图的标示
@property(nonatomic,copy) NSArray *imgextra;

//法2
//@property(nonatomic,copy) NSString*urlString;
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


- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
//由于定的是对象方法,访问不了属性,所以在这里面增肌urlstring,再访问属性没用,只能改方法,在方法里增加参数
+(void)modelWithUrlString:(NSString*)urlString andWithSucess:(void(^)(NSArray* ary))sucessBlock andError:(void(^)())errorBlock;

@end
