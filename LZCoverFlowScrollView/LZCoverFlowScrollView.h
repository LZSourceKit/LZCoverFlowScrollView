//
//  LZCoverFlowScrollView.h
//  LZCoverFlowScrollView
//
//  Created by Leon on 15/9/21.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)(NSInteger index);

@interface LZCoverFlowScrollView : UIScrollView

@property (nonatomic, strong) NSArray *imageAry;
@property (nonatomic) CGFloat topMargin;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat itemSpace;
@property (nonatomic) CGFloat changeRatio;
@property (nonatomic) NSInteger selectedIndex;
-(void)setCallBack:(CallBack) callBack;

@end
