//
//  KBLoadingView.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "KBLoadingView.h"

#define SDProgressViewItemMargin 10

@implementation KBLoadingView
{
    CGFloat _angleInterval;
    NSTimer *_timer;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(changeAngle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)changeAngle
{
    _angleInterval += M_PI / 25;
    if (_angleInterval >= M_PI * 2) _angleInterval = 0;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    
    [[UIColor grayColor] set];
    CGContextSetLineWidth(ctx, 3);
    CGContextAddArc(ctx, xCenter, yCenter, 10, 0, M_PI*2, 0);
    CGContextStrokePath(ctx);

    [[UIColor whiteColor] set];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 3);
    CGFloat to = M_PI / 2 + _angleInterval; // 初始值0.05
    CGFloat radius = 10;
    CGContextAddArc(ctx, xCenter, yCenter, radius, _angleInterval, to, 0);
    CGContextStrokePath(ctx);
}



@end
