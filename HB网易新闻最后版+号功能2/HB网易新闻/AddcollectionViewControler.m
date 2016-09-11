//
//  AddcollectionViewControler.m
//  HB网易新闻
//
//  Created by hebing on 16/9/7.
//  Copyright © 2016年 hebing. All rights reserved.
//

#import "AddcollectionViewControler.h"
#import "ChannelLable.h"
#import "HomeModel.h"
#import "SectionHeadCollectionView.h"
#define screemW    [UIScreen mainScreen].bounds.size.width
#define screemH    [UIScreen mainScreen].bounds.size.height

@interface AddcollectionViewControler ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation AddcollectionViewControler

static NSString *  reuseIdentifier = @"Cell";
static NSString *  headReuseIdentifier = @"head";
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.collectionView registerClass:[SectionHeadCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseIdentifier];
    
    UINib* nib=[UINib nibWithNibName:@"SectionHeadCollectionView" bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headReuseIdentifier];
    
//    self.view.backgroundColor=[UIColor whiteColor];
    
    //这个颜色一定要设置才能显示出collocionView内容
//    self.navigationItem.leftBarButtonItem.title=@"返回";//无效
    UIBarButtonItem* left=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem=left;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    [self setFlowLayOut];
 
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[UICollectionReusableView class] forCellWithReuseIdentifier:@"head"];

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    if (_dataBlock) {
        _dataBlock(self.showData,self.hideData);
    }
    
    
}

-(void)setFlowLayOut{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, screemW, 60)];
    
    UILabel* lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screemW-60, 60)];
    
    lable.font=[UIFont systemFontOfSize:30];
    
    lable.text=@"请选择个人偏好";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor purpleColor];
    view.backgroundColor=[UIColor lightGrayColor];
    
    UIButton* cancle=[[UIButton alloc]initWithFrame:CGRectMake(screemW-60, 0, 60, 60)];
    
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancle];

    [view addSubview:lable];
    self.view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:view];
    CGFloat collectHight=view.frame.size.height;
    self.collectionView.frame= CGRectMake(0, collectHight, screemW , screemH-collectHight ) ;
    UICollectionViewFlowLayout* flowLayOut=(UICollectionViewFlowLayout*)self.collectionViewLayout;
    flowLayOut.itemSize=CGSizeMake(screemW/4-10, 20);
    flowLayOut.minimumLineSpacing=10;
    flowLayOut.minimumInteritemSpacing=10;
    flowLayOut.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
}
-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(instancetype)init{
    UICollectionViewFlowLayout* flowLayOut=[[UICollectionViewFlowLayout alloc]init];
    //设置写在里面外面都可以
//    flowLayOut.itemSize=CGSizeMake(screemW/4-10, 20);
//    flowLayOut.minimumLineSpacing=10;
//    flowLayOut.minimumInteritemSpacing=10;
//    flowLayOut.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    return [super initWithCollectionViewLayout:flowLayOut];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section==0) {
        return self.showData.count;
        
    }else{
        return self.hideData.count;
    }

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        
        //解决重用重影问题
        
        if (cell.contentView.subviews) {
            for (UIView*view in  cell.contentView.subviews) {
                [view removeFromSuperview];
            }
           
        }
        HomeModel* model=self.showData[indexPath.item];
        
        ChannelLable* lable=[ChannelLable lableWithName:model.tname];
        lable.bounds=CGRectMake(0, 0, cell.contentView.frame.size.width
                                , cell.contentView.frame.size.height);
        
        [cell.contentView addSubview:lable];

    }
    if (indexPath.section==1) {
        
        //解决重影问题
        
        if (cell.contentView.subviews) {
            for (UIView*view in  cell.contentView.subviews) {
                [view removeFromSuperview];
            }
            
        }
        HomeModel* model=self.hideData[indexPath.item];
        
        ChannelLable* lable=[ChannelLable lableWithName:model.tname];
        lable.bounds=CGRectMake(0, 0, cell.contentView.frame.size.width
                                , cell.contentView.frame.size.height);

        
        [cell.contentView addSubview:lable];

        
    }
   
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        HomeModel* changemodel=self.showData[indexPath.item];
        [self.showData removeObject:changemodel];
         [self.hideData addObject:changemodel];
//        NSLog(@"%@   ,,,,%@",self.showData,self.hideData);
        [self.collectionView reloadData];
        
       
    }
    
    if (indexPath.section==1) {
        HomeModel* changemodel=self.hideData[indexPath.item];
        [self.hideData removeObject:changemodel];
        [self.showData addObject:changemodel];
        [self.collectionView reloadData];
//                NSLog(@"%@   ,,,,%@",self.showData,self.hideData);


        
    }
    
    
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    UICollectionReusableView *reusableview = nil ;
//    
//    if (kind == UICollectionElementKindSectionHeader ){
//        
//        UICollectionReusableView* view= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"head" forIndexPath:indexPath];
//        
//        ChannelLable* lable=[ChannelLable lableWithName:@"本地频道"];
//        
////        
////            lable.font=[UIFont systemFontOfSize:15];
////            if (indexPath.section==0) {
////                lable.text=@"本地频道";
////            }else{
////        
////                lable.text=@"推荐频道";
////            }
////        
////        
////            [lable sizeToFit];
//            lable.frame=CGRectMake(0, 0, lable.frame.size.width, lable.frame.size.height);
//        [view addSubview:lable];
//        reusableview=view;
//
//        
//    }
//    
// 
//    
//    return reusableview;
//}

//没调用
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil ;
    
    if (kind == UICollectionElementKindSectionHeader ){
        SectionHeadCollectionView* headView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        if (indexPath.section==0) {
            headView.title=@"本地频道";
        }else{
            headView.title=@"推荐频道";

        }
        
        reusableview=headView;
        
    }
    
    
    
    return reusableview;
}



//通过一个方法,返回头和尾
/**
 *  返回头尾的方法
 *
 *  @param collectionView 界面显示的控件
 *  @param kind           UICollectionViewFlowLayout中进行查找
 UICollectionElementKindSectionHeader
 UICollectionElementKindSectionFooter
 *  @param indexPath      索引
 *
 *  @return UICollectionReusableView 就是返回的头尾对象
 */
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    //1. 定义标识
//    NSString *reuseId = [kind isEqualToString:UICollectionElementKindSectionHeader] ? headReuseIdentifier:@"footer";
//    
//    
//    
//    SectionHeadCollectionView *reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseId forIndexPath:indexPath];
//    
//    
//    [reuseView setIndexPath:indexPath withKind:kind];
//    
//    
//    
//    return reuseView;
//    
//    
//}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {screemW, 50};
        return size;
    }
    else
    {
        CGSize size = {screemW, 50};
        return size;
    }
}


@end
