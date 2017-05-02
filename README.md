# WaterFallFlowLayout
自定义流水布局
下面是自定义UICollectionViewLayout时比较常用到的一些方法

1.collectionView每次需要重新布局(初始, layout 被设置为invalidated …)的时候会首先调用这个方法prepareLayout()

所以Apple建议我们可以重写这个方法来为自定义布局做一些准备的操作,
在cell比较少的情况下, 我们一般都可以在这个方法里面计算好所有的cell布局
并且缓存下来, 在需要的时候直接取相应的值即可, 以提高效率


2.然后会调用- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect方法获取到rect范围内的cell的所有布局, 这个rect大家可以打印出来看下, 和collectionView的bounds不一样, size可能比collectionView大一些, 这样设计也许是为了缓冲

Apple要求这个方法必须重写, 并且提供相应rect范围内的cell的所有布局的
UICollectionViewLayoutAttributes, 如果之前我们已经计算好了,
就可以直接返回就可以了, 当然你可以比如只返回rect范围内的cell的布局,
而不是所有的cell的布局, 不过这样的话你需要设置下一个方法


3.当collectionView的bounds变化的时候会调用
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds这个方法

如果我们的布局是会时刻变化的, 需要在滚动的过程中重新布局 , 那么我们需要
设置这个方法的返回值为Yes, 默认为No
* 当返回值为Yes的时候会将collectionView的layout设置为invalidated,
将会使collectionView重新调用上面的prepareLayout()...方法重新获得布局
* 同时, 当屏幕旋转的时候collectionView的bounds也会调用这个方法
如果设置为Yes, 那么将不会达到屏幕适配的效果,
* 需要注意的是, 当collectionView执行一些操作(delete insert reload)等的时候,
不会调用这个方法, 会直接重新调用上面的prepareLayout()...方法重新获得布局



4.需要设置collectionView 的滚动范围 - (CGSize) collectionViewContentSize

自定义的时候, 必须重写这个方法, 并且返回正确的滚动范围, collectionView才能正常的滚动


5.以下方法, Apple建议我们也重写, 返回正确的自定义对象的布局
因为有时候当collectionView执行一些操作(delete insert reload)等系统会调用这些方法获取布局, 如果没有重写, 可能发生意想不到的效果

自定义cell布局的时候重写
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;

自定义SupplementaryView的时候重写
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;

自定义DecorationView的时候重写
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath;


6.这个方法是当collectionView将停止滚动的时候调用, 我们可以重写它来实现, collectionView停在指定的位置(比如照片浏览的时候, 你可以通过这个实现居中显示照片…)
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity;

… 同时里面还有很多的方法我们可以重写来实现更多的效果, 但是这里, 就先介绍这么多的方法来实现自定义collectionView的布局

参考文章：http://www.jianshu.com/p/5e8af46283c4
