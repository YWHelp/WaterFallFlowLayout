//
//  CircleFlowLayout.h
//  自定义流水布局
//
//  Created by changcai on 17/5/2.
//  Copyright © 2017年 changcai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleFlowLayout;

@protocol CircleFlowLayoutDelegate <NSObject>

@optional
/// 列数
- (CGFloat)columnCountInFallsLayout:(CircleFlowLayout *)fallsLayout;
/// 列间距
- (CGFloat)columnMarginInFallsLayout:(CircleFlowLayout *)fallsLayout;
/// 行间距
- (CGFloat)rowMarginInFallsLayout:(CircleFlowLayout *)fallsLayout;
/// collectionView边距
- (UIEdgeInsets)edgeInsetsInFallsLayout:(CircleFlowLayout *)fallsLayout;

@end

@interface CircleFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<CircleFlowLayoutDelegate> delegate;

@end
