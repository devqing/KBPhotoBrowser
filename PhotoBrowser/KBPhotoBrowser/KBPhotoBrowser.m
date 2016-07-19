//
//  KBPhotoBrowser.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "KBPhotoBrowser.h"
#import "KBPhotoView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface KBPhotoBrowser()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imagesUrl;
@property (nonatomic, strong) NSMutableSet *visibleImageViews;
@property (nonatomic, strong) NSMutableSet *reusedImageViews;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageNames;

@end

@implementation KBPhotoBrowser

#pragma mark --life cycle
- (instancetype)initWithImages:(NSArray *)images index:(NSInteger)index
{
    if (self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)]) {
        self.imageNames = images;
        [UIApplication sharedApplication].statusBarHidden = YES;
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)show
{
    self.alpha = 0;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self showImageViewAtIndex:0];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self showImages];
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
    for (KBPhotoView *photoView in self.visibleImageViews) {
        imageViewIndex = photoView.tag;
        // 不在显示范围内
        if (imageViewIndex < firstIndex || imageViewIndex > lastIndex) {
            [self.reusedImageViews addObject:photoView];
            [photoView removeFromSuperview];
        }
    }
    
    [self.visibleImageViews minusSet:self.reusedImageViews];
    
    // 是否需要显示新的视图
    for (NSInteger index = firstIndex; index <= lastIndex; index++) {
        BOOL isShow = NO;
        
        for (KBPhotoView *photoView in self.visibleImageViews) {
            if (photoView.tag == index) {
                isShow = YES;
            }
        }
        
        if (!isShow) {
            [self showImageViewAtIndex:index];
        }
    }
}

- (void)showImageViewAtIndex:(NSInteger)index {
    
    KBPhotoView *photoView = [self.reusedImageViews anyObject];
    
    if (photoView) {
        [self.reusedImageViews removeObject:photoView];
    } else {
        photoView = [[KBPhotoView alloc] init];
    }
    
    CGRect bounds = self.scrollView.bounds;
    CGRect imageViewFrame = bounds;
    imageViewFrame.origin.x = CGRectGetWidth(bounds) * index;
    photoView.tag = index;
    photoView.frame = imageViewFrame;
    [photoView showImage:self.imageNames[index]];
    
    [self.visibleImageViews addObject:photoView];
    [self.scrollView addSubview:photoView];
}

#pragma mark --getter&setter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize  = CGSizeMake(WIDTH * self.imageNames.count, 0);
    }
    return _scrollView;
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
