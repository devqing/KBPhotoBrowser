//
//  ViewController.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/4/26.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "ViewController.h"
#import "KBPhotoBrowser.h"

@interface ViewController () <UIScrollViewDelegate>

/**
 *  保存可见的视图
 */
@property (nonatomic, strong) NSMutableSet *visibleImageViews;

/**
 *  保存可重用的
 */
@property (nonatomic, strong) NSMutableSet *reusedImageViews;

/**
 *  滚动视图
 */
@property (nonatomic, weak) UIScrollView *scrollView;

/**
 *  所有的图片名
 */
@property (nonatomic, strong) NSArray *imageNames;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加UIScrollView
//    [self setupScrollView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = CGPointMake(100, 200);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonClick
{
    KBPhotoBrowser *photoBrowser = [[KBPhotoBrowser alloc] initWithImages:self.imageNames index:0];
    [photoBrowser show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}



#pragma mark Init Views

// 添加UIScrollView
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(self.imageNames.count * CGRectGetWidth(scrollView.frame), 0);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    [self showImageViewAtIndex:0];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self showImages];
    [self test];
}

- (void)test {
    NSMutableString *rs = [NSMutableString string];
    NSInteger count = [self.scrollView.subviews count];
    for (UIImageView *imageView in self.scrollView.subviews) {
        [rs appendFormat:@"%p - ", imageView];
    }
    [rs appendFormat:@"%ld", (long)count];
    NSLog(@"%@", rs);
}

#pragma mark - Private Method

- (void)showImages {
    
    // 获取当前处于显示范围内的图片的索引
    CGRect visibleBounds = self.scrollView.bounds;
    CGFloat minX = CGRectGetMinX(visibleBounds);
    CGFloat maxX = CGRectGetMaxX(visibleBounds);
    CGFloat width = CGRectGetWidth(visibleBounds);
    
    NSInteger firstIndex = (NSInteger)floorf(minX / width);
    NSInteger lastIndex  = (NSInteger)floorf(maxX / width);
    
    // 处理越界的情况
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    
    if (lastIndex >= [self.imageNames count]) {
        lastIndex = [self.imageNames count] - 1;
    }
    
    // 回收不再显示的ImageView
    NSInteger imageViewIndex = 0;
    for (UIImageView *imageView in self.visibleImageViews) {
        imageViewIndex = imageView.tag;
        // 不在显示范围内
        if (imageViewIndex < firstIndex || imageViewIndex > lastIndex) {
            [self.reusedImageViews addObject:imageView];
            [imageView removeFromSuperview];
        }
    }
    
    [self.visibleImageViews minusSet:self.reusedImageViews];
    
    // 是否需要显示新的视图
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        BOOL isShow = NO;
        
        for (UIImageView *imageView in self.visibleImageViews) {
            if (imageView.tag == index) {
                isShow = YES;
            }
        }
        
        if (!isShow) {
            [self showImageViewAtIndex:index];
        }
    }
}

// 显示一个图片view
- (void)showImageViewAtIndex:(NSInteger)index {
    
    UIImageView *imageView = [self.reusedImageViews anyObject];
    
    if (imageView) {
        [self.reusedImageViews removeObject:imageView];
    } else {
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    CGRect bounds = self.scrollView.bounds;
    CGRect imageViewFrame = bounds;
    imageViewFrame.origin.x = CGRectGetWidth(bounds) * index;
    imageView.tag = index;
    imageView.frame = imageViewFrame;
    imageView.image = [UIImage imageNamed:self.imageNames[index]];
    
    [self.visibleImageViews addObject:imageView];
    [self.scrollView addSubview:imageView];
}

#pragma mark - Getters and Setters

- (NSArray *)imageNames {
    if (_imageNames == nil) {
        _imageNames = @[@"http://ww4.sinaimg.cn/bmiddle/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                        @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                        @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    }
    return _imageNames;
}

- (NSMutableSet *)visibleImageViews {
    if (_visibleImageViews == nil) {
        _visibleImageViews = [[NSMutableSet alloc] init];
    }
    return _visibleImageViews;
}

- (NSMutableSet *)reusedImageViews {
    if (_reusedImageViews == nil) {
        _reusedImageViews = [[NSMutableSet alloc] init];
    }
    return _reusedImageViews;
}

@end