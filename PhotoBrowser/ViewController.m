//
//  ViewController.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/4/26.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "ViewController.h"
#import "KBPhotoBrowser.h"
#import "ImageView.h"

@interface ViewController () <UIScrollViewDelegate,ImageViewDelegate>

@property (nonatomic, strong) NSArray *imageNames;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ImageView *view = [[ImageView alloc] initWithFrame:CGRectMake(20, 100, 280, 300)];
    view.delegate = self;
    [self.view addSubview:view];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)]];
}

- (void)test
{
    NSLog(@"1111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"2222");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"3333");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"4444");
}

- (void)imageView:(ImageView *)image didClickButton:(UIButton *)button atIndex:(NSInteger)index
{
    KBPhotoBrowser *photoBrowser = [[KBPhotoBrowser alloc] initWithImages:self.imageNames index:index];
    [photoBrowser show];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
}


#pragma mark - Getters and Setters

- (NSArray *)imageNames {
    if (_imageNames == nil) {
        _imageNames = @[
                        @"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/677febf5gw1erma104rhyj20k03dz16y.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
                        ];
    }
    return _imageNames;
}


@end