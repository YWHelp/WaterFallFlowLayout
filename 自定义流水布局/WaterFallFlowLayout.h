//
//  FlowLayout.h
//  自定义流水布局
//
//  Created by changcai on 17/5/2.
//  Copyright © 2017年 changcai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallFlowLayout;

@protocol WaterFallFlowLayoutDelegate <NSObject>

@optional
/// 列数
- (CGFloat)columnCountInFallsLayout:(WaterFallFlowLayout *)fallsLayout;
/// 列间距
- (CGFloat)columnMarginInFallsLayout:(WaterFallFlowLayout *)fallsLayout;
/// 行间距
- (CGFloat)rowMarginInFallsLayout:(WaterFallFlowLayout *)fallsLayout;
/// collectionView边距
- (UIEdgeInsets)edgeInsetsInFallsLayout:(WaterFallFlowLayout *)fallsLayout;

@end

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<WaterFallFlowLayoutDelegate> delegate;

@end
