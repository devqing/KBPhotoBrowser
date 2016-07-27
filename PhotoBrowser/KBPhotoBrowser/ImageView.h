//
//  ImageView.h
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/25.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageView;

@protocol ImageViewDelegate <NSObject>

- (void)imageView:(ImageView *)image didClickButton:(UIButton *)button atIndex:(NSInteger)index;

@end

@interface ImageView : UIView

@property (nonatomic, weak) id<ImageViewDelegate> delegate;

@end
