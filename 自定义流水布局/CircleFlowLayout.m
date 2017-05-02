//
//  CircleFlowLayout.m
//  自定义流水布局
//
//  Created by changcai on 17/5/2.
//  Copyright © 2017年 changcai. All rights reserved.
//

#import "CircleFlowLayout.h"

@interface CircleFlowLayout()

/** 总的cell数量 */
@property (nonatomic, assign) NSUInteger totalNum;
/*  所有的cell的布局 */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArray;
/** 圆心 */
@property (nonatomic, assign) CGPoint center;
/** 半径 */
@property (nonatomic, assign) CGFloat radius;


- (CGFloat)columnCount;     ///< 列数
- (CGFloat)columnMargin;    ///< 列边距
- (CGFloat)rowMargin;       ///< 行边距
- (UIEdgeInsets)edgeInsets; ///< collectionView边距


@end

#pragma mark - 默认参数
static const CGFloat DefaultColumnCount = 3;                           ///< 默认列数
static const CGFloat DefaultColumnMargin = 10;                         ///< 默认列边距
static const CGFloat DefaultRowMargin = 10;                            ///< 默认行边距
static const UIEdgeInsets DefaultUIEdgeInsets = {10, 10, 10, 10};      ///< 默认collectionView边距


@implementation CircleFlowLayout


- (void)prepareLayout
{
    [super prepareLayout];
    self.totalNum = [self.collectionView numberOfItemsInSection:0];
    self.center = CGPointMake(self.collectionView.bounds.size.width*0.5, self.collectionView.bounds.size.height*0.5);
    self.radius = MIN(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height) / 3.0;
    for (int index = 0; index < self.totalNum; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        // 计算布局属性并将结果添加到布局属性数组中
        [self.attrsArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return  YES;
}

//重写方法设置每个cell的布局
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(60.0,60.0);
    CGFloat angle = (CGFloat)2 * M_PI * indexPath.row /_totalNum;
    // 一点点数学转换
    attrs.center = CGPointMake(_center.x + _radius*cos(angle), _center.y + _radius*sin(angle));
    return attrs;

}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
      return self.attrsArray;
}

- (CGSize) collectionViewContentSize
{
    return self.collectionView.bounds.size;
}


#pragma mark - 懒加载
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInFallsLayout:)]) {
        return [self.delegate rowMarginInFallsLayout:self];
    } else {
        return DefaultRowMargin;
    }
}

- (CGFloat)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInFallsLayout:)]) {
        return [self.delegate columnCountInFallsLayout:self];
    } else {
        return DefaultColumnCount;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInFallsLayout:)]) {
        return [self.delegate columnMarginInFallsLayout:self];
    } else {
        return DefaultColumnMargin;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInFallsLayout:)]) {
        return [self.delegate edgeInsetsInFallsLayout:self];
    } else {
        return DefaultUIEdgeInsets;
    }
}

@end
