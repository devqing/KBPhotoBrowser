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
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return self;
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(dismiss)]) {
        [self.delegate dismiss];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
}

- (void)showImage:(NSString *)url
{
    self.imageView.frame = CGRectZero;
    self.scrollView.contentSize = CGSizeMake(0, 0);
    KBLoadingView *loadingView = [self viewWithTag:1000];
    [loadingView removeFromSuperview];
    [self downloadImageWithUrl:url];
}

- (void)saveImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
    } else {

    }
}

- (void)resizeImageView:(UIImage *)image
{
    CGSize imageSize = image.size;
    CGFloat imageViewHeight = WIDTH/(imageSize.width/imageSize.height);
    CGFloat imageViewY = HEIGHT-imageViewHeight>=0?(HEIGHT-imageViewHeight)/2:0;
    self.imageView.frame = CGRectMake(0, imageViewY, WIDTH,imageViewHeight);
    self.imageView.image = image;
    CGFloat offsety = imageViewHeight-HEIGHT>=0?(imageViewHeight):0;
    self.scrollView.contentSize = CGSizeMake(0, offsety);
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
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        [_imageView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImage)]];
    }
    return _imageView;
}

@end
