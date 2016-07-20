//
//  KBPhotoBrowser.h
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KBPhotoBrowser : UIView

- (instancetype)initWithImages:(NSArray *)images index:(NSInteger)index;
- (void)show;

@end
