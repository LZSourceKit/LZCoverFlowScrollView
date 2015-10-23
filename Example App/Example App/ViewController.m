//
//  ViewController.m
//  Example App
//
//  Created by Leon on 10/21/15.
//  Copyright © 2015 Leon. All rights reserved.
//

#import "ViewController.h"
#import "LZCoverFlowScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
}
-(void)createView
{
    LZCoverFlowScrollView * cover = [[LZCoverFlowScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 140)];
    cover.backgroundColor = [UIColor blackColor];
    cover.topMargin = 20;
    cover.itemSize = CGSizeMake(80, 100);
    cover.itemSpace = 20;
    cover.selectedIndex = 0;
    cover.changeRatio = 1.2f;
    cover.imageAry = @[[UIColor orangeColor],[UIColor yellowColor],[UIColor blueColor],[UIColor purpleColor],[UIColor grayColor],[UIColor greenColor],[UIColor cyanColor],[UIColor magentaColor]];
    [cover setCallBack:^(NSInteger index) {
        NSLog(@"%ld",index);
    }];
    [self.view addSubview:cover];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
