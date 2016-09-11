//
//  AddcollectionViewControler.h
//  HB网易新闻
//
//  Created by hebing on 16/9/7.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddcollectionViewControler : UICollectionViewController
//@property(nonatomic,strong)NSMutableArray* dataAry;//总数据

@property(nonatomic,strong)NSMutableArray* showData;//页面显示的数据
@property(nonatomic,strong)NSMutableArray* hideData;//剩余数据

@property(nonatomic,copy) void(^dataBlock)(NSMutableArray* showData,NSMutableArray* hideData);
@end
