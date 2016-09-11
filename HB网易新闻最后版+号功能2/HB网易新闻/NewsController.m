//
//  NewsController.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "NewsController.h"
#import "NewsModel.h"
#import "NewsCell.h"

@interface NewsController ()
@property(nonatomic,strong)NSArray* newsAry;

@end

@implementation NewsController

-(void)setNewsAry:(NSArray *)newsAry{
    _newsAry=newsAry;
    [self.tableView reloadData];
}

-(void)setUrlString:(NSString *)urlString{
    
    _urlString=urlString;
//     NSLog(@"newsControl  %@",urlString);
    //为了赋值就调用,转移到这来,不在viewdidLoad里面调用
    [NewsModel modelWithUrlString: urlString andWithSucess:^(NSArray *ary) {
        self.newsAry=ary;
        
        
    } andError:^{
        NSLog(@"news数据加载错误");
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsAry.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NewsModel* model=self.newsAry[indexPath.row];
    NewsCell* cell=[tableView dequeueReusableCellWithIdentifier:[NewsCell identifierWithModel:model] forIndexPath:indexPath];
   
    cell.model=model;
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel* model=self.newsAry[indexPath.row];
    return [NewsCell getHightWithModel:model];
}



@end
