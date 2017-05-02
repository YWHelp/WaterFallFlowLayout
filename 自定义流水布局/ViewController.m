//
//  ViewController.m
//  自定义流水布局
//
//  Created by changcai on 17/5/2.
//  Copyright © 2017年 changcai. All rights reserved.
//

#import "ViewController.h"
//#import "WaterFallFlowLayout.h"
#import "CircleFlowLayout.h"
#import "YWCell.h"
static NSString *const cellIdentifier = @"cellIdentifier";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CircleFlowLayoutDelegate>
/**   */
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self constructUI];
}

-(void)constructUI
{
    // 创建流水布局
    // 默认滚动方向,垂直
    CircleFlowLayout *layout = ({
        CircleFlowLayout *layout = [[CircleFlowLayout alloc] init];
        // 设置尺寸
        //layout.itemSize = CGSizeMake(100, 100);
        //估算的尺寸(一般不需要设置)
        //layout.estimatedItemSize = CGSizeMake(100, 100);
        //头部的参考尺寸(就是尺寸)
        //layout.headerReferenceSize = CGSizeMake(100, 100);
        //尾部的参考尺寸
        //layout.footerReferenceSize = CGSizeMake(100, 100);
        
        //设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
        //layout.sectionFootersPinToVisibleBounds = YES;
        //layout.sectionHeadersPinToVisibleBounds = YES;
        // 设置水平滚动方向
        //水平滚动
        //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //竖直滚动
        //layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 设置额外滚动区域
        //layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        // 设置cell间距
        //设置水平间距, 注意点:系统可能会跳转(计算不准确)
        //layout.minimumInteritemSpacing = 5;
        //设置垂直间距
        //layout.minimumLineSpacing = 5;
        layout;
        
    });
    layout.delegate = self;
    // 创建UICollectionView
    // UICollectionView默认的颜色就是黑色,所以建议设置背景颜色
    UICollectionView *collectionView = ({
        //创建UICollectionView对象, 将layout添加到collectionViewLayout:里面
        UICollectionView *collectionView =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //设置UICollectionView的尺寸
        collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        //设置背景颜色
        collectionView.backgroundColor = [UIColor greenColor];
        //设置中心点
        collectionView.center = self.view.center;
        // 设置数据源,展示数据
        collectionView.dataSource = self;
        //设置代理,监听
        collectionView.delegate = self;
        // 注册cell
        [collectionView registerClass:[YWCell class] forCellWithReuseIdentifier:cellIdentifier];
        /* 设置UICollectionView的属性 */
        //设置滚动条
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        //设置是否需要弹簧效果
        collectionView.bounces = NO;
        collectionView;
    });
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
}

// 告诉系统一共多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.从缓存池中取
    YWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    // 2.使用
    cell.backgroundColor = (indexPath.item % 2)?[UIColor redColor]:[UIColor blueColor];
    // 3.返回
    return cell;
}

#pragma mark -UICollectionViewDelegate
//UICollectionView被选中的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd",indexPath.item);
}

// 返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/*
- (CGFloat)columnMarginInFallsLayout:(CircleFlowLayout *)fallsLayout
{
    return 5;
}

- (CGFloat)rowMarginInFallsLayout:(CircleFlowLayout *)fallsLayout
{
    return 5;
}

- (CGFloat)columnCountInFallsLayout:(CircleFlowLayout *)fallsLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInFallsLayout:(CircleFlowLayout *)fallsLayout
{
    return UIEdgeInsetsMake(20, 10, 20, 10);
}
*/

@end
