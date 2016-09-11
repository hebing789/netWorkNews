//
//  HomeViewController.m
//  HB网易新闻
//
//  Created by hebing on 16/9/5.
//  Copyright © 2016年 hebing. All rights reserved.
//

/*
 bug:测试会发送邮件告诉你软件的问题,重现bug的步骤很明确的告诉你.
 重现步骤:
 
 (1)点击间隔的新闻分类,有的新闻分类都变红变大
 (2)滑动的很快也会出现上述问题
 
 
 解决思路1(不完美)
 代码滚动停止,label状态重置,再次滚动的中间过程还是会有一点点的UI问题,变大,变红
 解决2:
 滚动过程中,只要不是相邻的label,不让label白拿变红
 记录下一次点击的index,判断label是否相邻
 */

#import "HomeViewController.h"
#import "HomeModel.h"
#import "ChannelLable.h"
#import "HomeCell.h"
#import "AddcollectionViewControler.h"
#define screemW    [UIScreen mainScreen].bounds.size.width
#define screemH    [UIScreen mainScreen].bounds.size.height
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scorView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayOut;

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,assign)NSInteger nextIndex;
@property (weak, nonatomic) IBOutlet UIButton *modefyLable;
@property(nonatomic,strong)NSMutableArray* dataAry;//总数据

@property(nonatomic,strong)NSMutableArray* showData;//页面显示的数据
@property(nonatomic,strong)NSMutableArray* hideData;//剩余数据
@end

@implementation HomeViewController
#define showDataKey @"showData"
#define hideDataKey @"hideData"
#define pathShow ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"showdata.data"])

#define pathHide ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"hidedata.data"])
- (IBAction)modifyLable:(id)sender {
	//由于要求有点击事件可以增加减少,移动,button比较好写,
	//要求有2个数据记录,一个记录当前页面上有的lable的tag,因为cell依靠tag值改变而改变,所以减少lable的tag值,重新布局lable,cell依然按照lable的tag值增加就可以,但是滚动下面的时候是个问题,cell的页面会和lable不匹配,,因此必须从源头数据modle数组里面修改,遍历model增加button;
		
	AddcollectionViewControler* addcontroller=[[AddcollectionViewControler alloc]init];
	
	addcontroller.showData=self.showData;
	addcontroller.hideData=self.hideData;
	
	
	
	[addcontroller setDataBlock:^(NSMutableArray *showdata, NSMutableArray *hideData) {
		
		//由于重新显示到界面上,建议重新给self.showData,排序
		NSArray* tem=[showdata sortedArrayUsingComparator:^NSComparisonResult(HomeModel*  _Nonnull obj1, HomeModel*  _Nonnull obj2) {
			
			return  [obj1.tid compare:obj2.tid];
			
		}];
		self.showData=[NSMutableArray new];
		for (HomeModel* modle in tem) {
			
			[self.showData addObject:modle];
		}

		
		self.hideData=hideData;
//		//Attempt to set a non-property-list object,本地用户偏好存数组不行,
//		//存入数据
//		[[NSUserDefaults standardUserDefaults]setObject:self.showData forKey:showDataKey];
//		[[NSUserDefaults standardUserDefaults]setObject:self.hideData forKey:hideDataKey];
//		[[NSUserDefaults standardUserDefaults]synchronize];
		
////		//存到document
//		[self.showData writeToFile:pathShow atomically:YES];
//		
//		[self.hideData writeToFile:pathHide atomically:YES];
//		NSLog(@"%@",pathHide);
		//数组里面存的模型,必须用归档解档
//		
		[NSKeyedArchiver archiveRootObject:self.showData toFile: pathShow];
		[NSKeyedArchiver archiveRootObject:self.hideData toFile:pathHide];
		
		//解决重影问题
		for (UIView* view in self.scorView.subviews) {
		
			[view removeFromSuperview];
		}
		
		[self displayChannel];
		//解决+号更改数据后,页面不符合问题,重新刷新数据
		[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
		self.scorView.contentOffset=CGPointMake(0, 0);
		[self.collectionView reloadData];
		

	}];
	
//	[self presentViewController:addcontroller animated:YES completion:nil];
	[self.navigationController pushViewController:addcontroller animated:YES];

	
	
	
	
}

-(NSMutableArray*)dataAry{
    if (_dataAry==nil) {
		
		
        _dataAry=[HomeModel modelWithJSONName:@"topic_news.json"];
        
    }
    return _dataAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
////本地化数据
//	self.showData=[[NSUserDefaults standardUserDefaults] objectForKey:showDataKey];
//	self.hideData=[[NSUserDefaults standardUserDefaults] objectForKey:hideDataKey];
	
//	self.showData=[NSMutableArray arrayWithContentsOfFile:pathShow];
//	self.hideData=[NSMutableArray arrayWithContentsOfFile:pathHide];

	self.showData=[NSKeyedUnarchiver unarchiveObjectWithFile:pathShow];
		self.hideData=[NSKeyedUnarchiver unarchiveObjectWithFile:pathHide];
	NSLog(@"%@",self.showData);
		//初始化页面,只显示一半数据
	if (self.showData.count==0||self.hideData.count==0) {
		self.showData=[NSMutableArray new];
		self.hideData=[NSMutableArray new];//放在循环外面
		for(int i=0;i<self.dataAry.count;i++){
			if ((i<self.dataAry.count/3)) {
				
				[self.showData addObject:self.dataAry[i]];
				
			}else{
				
				
				[self.hideData addObject:self.dataAry[i]];
			}
			
			
		}
	}
	
//	NSLog(@"%@   ,,,%@,,,%@",self.dataAry,self.showData,self.hideData);

//    NSLog(@"%@",self.dataAry);
    [self displayChannel];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //不能在viewdidLoad里面写
    [self setFlowLayOut];
    
}

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.dataAry.count;
////}

//数据源里面也要改dataary
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%zd",self.dataAry.count);//有数据,加载不出来
     return self.showData.count;
    
}
//这个方法有执行,协议代理没问题
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homecell" forIndexPath:indexPath];
   HomeModel* model= self.showData[indexPath.item];
//    NSLog(@"newsControl  %@",model.urlString);

    cell.urlString=model.urlString;
    
    return cell;
}

-(void)setFlowLayOut{
    
    self.flowLayOut.itemSize=self.collectionView.frame.size;
    self.flowLayOut.minimumLineSpacing=0;
    self.flowLayOut.minimumInteritemSpacing=0;
    self.flowLayOut.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces=NO;
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsHorizontalScrollIndicator=YES;
    
    
    
    
    
}

-(void)displayChannel{
     //UIScrollView在导航条下面的时候,自动的添加上导航条的高度
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //循环读取数据,把每个新闻的分类信息,用label添加到channelScro
    
    //label的位置计算
    float margin=10;
    __block float x=margin;
   
    
    float hight=self.scorView.frame.size.height;
    
    [self.showData enumerateObjectsUsingBlock:^(HomeModel* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UILabel* lable=[UILabel new];
//        
//        [lable setText:obj.tname];
//        lable.textColor=[UIColor blackColor];
//        [lable setFont:[UIFont systemFontOfSize:15]];
//        [lable setTextAlignment:NSTextAlignmentCenter];
//        [lable sizeToFit];
        
        ChannelLable* lable=[ChannelLable lableWithName:obj.tname];
               float width=lable.frame.size.width;
        
        lable.frame=CGRectMake(x, 0, width, hight);
        x+=lable.frame.size.width+margin;
        
        if (idx==0) {
            lable.scale=1;
			//解决+号更改数据后,页面不符合问题,重新刷新数据
//			[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];//写这个位置不行,原因,跟网页加载数据有关,刚开始下面的item还没有数据
			
        }
        //给label添加点击的手势
        lable.tag=idx;//可以在手势的时候取出lable(tap.view)确定滚动到对应的item;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableTap:)];
        //点击无反应,开启其用户交互
        [lable addGestureRecognizer:tap];
        
//        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lableTap:)];
//        [lable addGestureRecognizer:tap];
//
        [self.scorView addSubview:lable];
        
        
    }];

    [self.scorView setContentSize:CGSizeMake(x, 0)];
    
    
    
    
}

-(void)lableTap:(UITapGestureRecognizer*)tap{
    NSLog(@"begin");
    ChannelLable* label=(ChannelLable* )tap.view;
    
    NSIndexPath* indexpath=[NSIndexPath indexPathForRow:label.tag inSection:0];
    
//    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
	
	   [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
	//如果关闭动画不会调用后面的scrollViewDidEndDecelerating方法,scorowllview不能滚动,手动调用很多bug
//	[self scrollViewDidScroll:self.scorView];
//	[self scrollViewDidEndDecelerating:self.scorView];
//	[self scrollViewDidEndDecelerating:self.scorView];
	
	
	
    
}




//手滚动,代码滚动都调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	self.currentIndex= scrollView.contentOffset.x/self.collectionView.frame.size.width;
//判断点击的新闻分类是否相邻currentIndex,一直在更新,但是nextindex只在手拖动借宿后更新(老师的思路),因此在此拦截,我的思路,currentIndex和nextindex都一直更新,一直让其处于改变状态,不要最后一次结算scale,m每一栋换一个lable就改变其scale,不要累加
//	if(abs(self.currentIndex-self.nextIndex)>1){
//		return;//这样拦截了,变红了不能边黑,不行,一定要做借宿之后更新颜色大小
//	}
	NSLog(@"%zd   %zd",self.currentIndex,self.nextIndex);//在结束那一瞬间,2个是相等的
    //由于currentLable不会跟着一起改变,因此要定义属性
    ChannelLable* currentlable=self.scorView.subviews[self.currentIndex];
 __block   ChannelLable* nextLable;
    //获取当前界面上显示的lable
    
//    NSIndexPath* curentIndexpath=[self.collectionView indexPathsForVisibleItems].lastObject;
//    //这样写不行
//     if (curentIndexpath.item!=self.currentIndex) {
//    
//    
//        nextLable=self.scorView.subviews[curentIndexpath.item];
//    
//    }
    
    //当前界面上正在显示的indexpath的集合,在界面上显示的indexPath都有
    NSArray* curentIndexpathAry=[self.collectionView indexPathsForVisibleItems];
    
    //这样写不行
    [curentIndexpathAry enumerateObjectsUsingBlock:^(NSIndexPath*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //因为这个indexpath是collectionView的,所以不用判断类型,滚动过程中有多个indexpath
//        if ([self.scorView.subviews[obj.item] isKindOfClass:[ChannelLable class]]) {
            if (obj.item!=self.currentIndex) {
                
                
                nextLable=self.scorView.subviews[obj.item];
                
            }

//        }
        
    }];
    
    
    //计算scale,0-1
    
//    CGFloat nextScale=self.scorView.contentOffset.x/self.collectionView.frame.size.width;
    
    //lable没变化,应该跟着scroview变化而变化
//    CGFloat nextScale= ABS(nextLable.frame.origin.x-currentlable.frame.origin.x)/nextLable.frame.size.width;
    //控制scale0-1, 思路,用滑动offset-当前的数量*collctionView的宽带/collctionView的宽带
//    NSInteger nextScaleIndex=(NSInteger)scrollView.contentOffset.x/self.collectionView.frame.size.width;
//    CGFloat nextScale=ABS(scrollView.contentOffset.x-self.currentIndex*self.collectionView.frame.size.width)/self.collectionView.frame.size.width;
//    NSLog(@"%f   ,%f,,,%f",nextScale,self.collectionView.frame.size.width,scrollView.contentOffset.x);
    
    //用滚动结束的一个整数减去快滚动借宿的属性计数的值可以得到scale;ZHU
    CGFloat nextScale=ABS(scrollView.contentOffset.x/self.collectionView.frame.size.width-self.currentIndex);
    
//    NSLog(@"%f   ",nextScale);
    CGFloat currentScale=1-nextScale;
    
    
    nextLable.scale=nextScale;
    currentlable.scale=currentScale;

  
//    [self scrollViewDidEndDecelerating:scrollView];//这个位置不行,都不变红了,手滑动的bug没有了,但是这个点击的时候没有颜色变化,而且缩小很多
}


//代码的滚动停止//保证代码结束滚动的状态
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
	[self scrollViewDidEndDecelerating:scrollView];
}

//快滚动结束的时候更换//点击的时候默认匀速,不调用这个方法//所以这个currentindex没有及时更换//为了让current及时更换.可以在didscorow中调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //这个获取的是当前停止显示的的lab的下标
    self.currentIndex=scrollView.contentOffset.x/self.collectionView.frame.size.width;
    //停止后的lable
    ChannelLable * curenLable=self.scorView.subviews[self.currentIndex];
	
	self.nextIndex=self.currentIndex;
	  //解决bug1; 滚动结束的时候,让所有的label状态更新//保证结束后的状态
	for (UIView* view in self.scorView.subviews ) {
		if ([view isKindOfClass:[ChannelLable class]]) {
			
			ChannelLable* lable= (ChannelLable*)view;
			if (lable.tag==self.currentIndex) {
				lable.scale=1;
			}else{
				lable.scale=0;
			}
			
			
		}
	}
    
    //计算lable应该滚动的偏差
    CGFloat offset=curenLable.center.x-(self.collectionView.frame.size.width-self.modefyLable.frame.size.width)*0.5;
    CGFloat max=self.scorView.contentSize.width-self.collectionView.frame.size.width+self.modefyLable.frame.size.width;
    if (offset<0) {
        offset=0;
    }
    if (offset>max) {
        offset=max;
    }
	//当用户选择的喜好太少时,滚到最左边
	if (self.scorView.contentSize.width<self.collectionView.frame.size.width-self.modefyLable.frame.size.width) {
		offset=0;
	}
    
    self.scorView.contentOffset=CGPointMake(offset, 0);
    
    
}

@end
