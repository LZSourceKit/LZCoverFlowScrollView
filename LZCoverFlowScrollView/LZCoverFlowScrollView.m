//
//  LZCoverFlowScrollView.m
//  LZCoverFlowScrollView
//
//  Created by Leon on 15/9/21.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import "LZCoverFlowScrollView.h"

@interface LZCoverFlowScrollView()<UIScrollViewDelegate>
{
    CallBack pCallBack;
}
@property(nonatomic) BOOL isAnimation;
@property(nonatomic,strong) NSMutableArray * imageViewStoer;
@end

@implementation LZCoverFlowScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _topMargin = 0.0;
        _itemSize = CGSizeMake(frame.size.width, frame.size.height);
        _selectedIndex = 0;
        _itemSpace = 0;
        _changeRatio =0;
        _imageAry = [[NSMutableArray alloc] init];
        _imageViewStoer = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)initInfiniteScrollView
{
    NSAssert(!(_itemSize.width == 0 || _itemSize.height == 0), @"some param must be set");
    
    self.pagingEnabled = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.delegate = self;
    self.decelerationRate = 0;
    self.contentInset = UIEdgeInsetsMake(0, self.frame.size.width/2-_itemSize.width/2-_itemSpace, 0, self.frame.size.width/2-_itemSize.width/2-_itemSpace);
    
    for (int i = 0; i < _imageAry.count; i++)
    {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake([self getOrininX:i], self.topMargin, _itemSize.width, _itemSize.height)];
        temp.backgroundColor = self.imageAry[i];
        temp.userInteractionEnabled = YES;
        temp.tag = i;
        [self.imageViewStoer addObject:temp];
        [self addSubview:temp];
        
        UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [temp addGestureRecognizer:tgr];
    }
    
    self.contentSize = CGSizeMake(_imageAry.count * _itemSize.width+(_imageAry.count+1)*self.itemSpace, self.frame.size.height);
    [self setContentOffset:CGPointMake([self getContentOffsetX:self.selectedIndex], 0)];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        [self reloadView];
        dispatch_async(dispatch_get_main_queue(), ^ {
            
        });
    });
    
}

- (void)reloadView
{
    CGFloat offsetX = self.contentOffset.x;
    for (int i = 0; i < _imageViewStoer.count; i++) {
        
        UIImageView *view = [_imageViewStoer objectAtIndex:i];
        CGFloat distanceMiddle = self.frame.size.width/2 + offsetX-view.center.x;
        CGFloat changeSpaceX = fabs(distanceMiddle)>_itemSize.width ? 0 : (_itemSize.width*(_changeRatio-1))*(1-(fabs(distanceMiddle)/_itemSize.width));
        CGFloat changeSpaceY = fabs(distanceMiddle)>_itemSize.width ? 0 : (_itemSize.height*(_changeRatio-1))*(1-(fabs(distanceMiddle)/_itemSize.width));
        view.frame = CGRectMake([self getOrininX:i]-changeSpaceX/2,_topMargin-changeSpaceY/2,_itemSize.width+changeSpaceX,_itemSize.height+changeSpaceY);
    }
}

-(void)tapView:(UITapGestureRecognizer *) sender
{
    self.selectedIndex = sender.view.tag;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self reloadView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        self.selectedIndex = [self getScrollItemIndex:scrollView.contentOffset.x];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.selectedIndex = [self getScrollItemIndex:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isAnimation = NO;
    self.userInteractionEnabled = YES;
}
-(void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    [self initInfiniteScrollView];
}

-(void)setImageAry:(NSArray *)imageAry
{
    _imageAry = imageAry;
    [self initInfiniteScrollView];
}
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    if(!_isAnimation)
    {
        _selectedIndex = selectedIndex;
        if(self.contentOffset.x != [self getContentOffsetX:selectedIndex])
            self.userInteractionEnabled = NO;
        [self setContentOffset:CGPointMake([self getContentOffsetX:self.selectedIndex], 0) animated:YES];
        if(pCallBack)
            pCallBack(self.selectedIndex);
    }
}
-(void)setCallBack:(CallBack)callBack
{
    pCallBack = callBack;
}

-(CGFloat)getOrininX:(NSInteger) index
{
    return index * _itemSize.width+(index+1)*self.itemSpace;
}
-(CGFloat)getContentOffsetX:(NSInteger) index
{
    return index *_itemSize.width+(index+1)*self.itemSpace-(self.frame.size.width/2-self.itemSize.width/2);
}
-(NSInteger)getScrollItemIndex:(CGFloat) offset
{
    return (offset+self.frame.size.width/2-_itemSpace/2)/(_itemSize.width+_itemSpace);
}
@end
