//
//  ImageView.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/25.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "ImageView.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

@interface ImageView()

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation ImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configView];
    }
    return self;
}

- (void)configView
{
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        //让图片不变形，以适应按钮宽高，按钮中图片部分内容可能看不到
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.clipsToBounds = YES;
        [btn sd_setImageWithURL:[NSURL URLWithString:self.imageArray[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"whiteplaceholder"]];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)buttonClick:(UIButton *)button
{
    [self.delegate imageView:self didClickButton:button atIndex:button.tag];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    long imageCount = self.imageArray.count;
    int perRowImageCount = 3;
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    CGFloat w = 80;
    CGFloat h = 80;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        long rowIndex = idx / perRowImageCount;
        int columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + 15);
        CGFloat y = rowIndex * (h + 15);
        btn.frame = CGRectMake(x, y, w, h);
    }];
}


- (NSArray *)imageArray
{
    return @[
             @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
             @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
             @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
             @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
             @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
             @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
             @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
             @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
             @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
             ];

}


@end
