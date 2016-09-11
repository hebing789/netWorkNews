//
//  ViewController.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

/*
 1.3组section
 2.初始位置是中间section第一个item
 3.滚动结束之后,调回到中间section对应的item位置
 */

#import "HeadLineCollectionControl.h"
#import "HeadLineModel.h"
#import "HeadLineCell.h"

@interface HeadLineCollectionControl ()
@property(nonatomic,strong)NSArray* headLineAry;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayOut;

@property(nonatomic,strong)NSTimer* timer;

@end

@implementation HeadLineCollectionControl

-(void)setHeadLineAry:(NSArray *)headLineAry{
    
    _headLineAry=headLineAry;
    [self.collectionView reloadData];
    
    [self addTimer];//要数据获取成功后调用,不能在viewDIdload中调用
    NSIndexPath* indexpath=[NSIndexPath indexPathForRow:0 inSection:1];
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  [HeadLineModel modelWithSucess:^(NSArray *ary) {
      self.headLineAry=ary;
//      NSLog(@"%@",ary);
  } andError:^{
      NSLog(@"数据获取失败");
      
  }];
    
//    NSIndexPath* indexpath=[NSIndexPath indexPathForRow:0 inSection:1];
//    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];//刚开始还没有数据
//     [self setLayOut];
  
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setLayOut];
}

-(void)setLayOut{
    self.flowLayOut.itemSize=self.collectionView.frame.size;
    self.flowLayOut.minimumLineSpacing=0;
    self.flowLayOut.minimumInteritemSpacing=0;
    
    self.flowLayOut.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces=NO;
    self.collectionView.showsHorizontalScrollIndicator=YES;
    self.collectionView.pagingEnabled=YES;
//    self.flowLayOut setScrollDirection:<#(UICollectionViewScrollDirection)#>
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.headLineAry.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HeadLineCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"headline" forIndexPath:indexPath];
    
    HeadLineModel* model=self.headLineAry[indexPath.item];
    cell.tag=indexPath.item;
    cell.model=model;
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
     int page=(int)scrollView.contentOffset.x/self.collectionView.frame.size.width;
        int item=page%self.headLineAry.count;
    NSIndexPath* indexpath=[NSIndexPath indexPathForRow:item inSection:1];
//    if(item==0){
//        NSIndexPath* indexpathTem=[NSIndexPath indexPathForRow:self.headLineAry.count-1 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexpathTem atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//
//    }

    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];//检验还是you bug
//        [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
 
}

-(void)addTimer{
    self.timer=[NSTimer timerWithTimeInterval:1.5 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes ];
    
}

-(void)removeTimer{
    
    [self.timer invalidate];
    self.timer=nil;
}

-(void)changePage{
    
    NSIndexPath* currentIndex=[self.collectionView indexPathsForVisibleItems].lastObject;
    
    //    NSIndexPath* nextIndex=[NSIndexPath indexPathForRow:currentIndex.item inSection:sectionCount/2];
    
    //获取下一个的位置
    int index = (int)currentIndex.item+1;
    int item=index%self.headLineAry.count;
    NSIndexPath* indexpath=[NSIndexPath indexPathForRow:item inSection:1];
        if(item==0){
            NSIndexPath* indexpathTem=[NSIndexPath indexPathForRow:self.headLineAry.count-1 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexpathTem atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
        }
    
     [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    //手拖动时,销毁定时器
    [self removeTimer];
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //手拖动结束时,加定时器
    [self addTimer];
}


@end
