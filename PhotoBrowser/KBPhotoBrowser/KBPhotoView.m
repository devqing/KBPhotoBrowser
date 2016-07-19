//
//  KBPhotoView.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "KBPhotoView.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import "KBLoadingView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface KBPhotoView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation KBPhotoView

#pragma mark --life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)]) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
}

- (void)showImage:(NSString *)url
{
    self.imageView.frame = CGRectZero;
    KBLoadingView *loadingView = [self viewWithTag:1000];
    [loadingView removeFromSuperview];
    [self downloadImageWithUrl:url];
}

- (void)resizeImageView:(UIImage *)image
{
    CGSize imageSize = image.size;
    CGFloat imageViewHeight = WIDTH/(imageSize.width/imageSize.height);
    self.imageView.frame = CGRectMake(0, (HEIGHT-imageViewHeight)/2, WIDTH,imageViewHeight);
    self.imageView.image = image;
}

- (void)downloadImageWithUrl:(NSString *)url
{
    KBLoadingView *loadingView = [[KBLoadingView alloc] initWithFrame:CGRectMake((WIDTH-60)/2, (HEIGHT-60)/2, 60, 60)];
    loadingView.backgroundColor = [UIColor clearColor];
    loadingView.tag = 1000;
    [self addSubview:loadingView];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [loadingView removeFromSuperview];
        [self resizeImageView:image];
    }];
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
