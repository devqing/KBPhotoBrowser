//
//  KBBarView.h
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBBarView : UIView

- (instancetype)initWithTotalPage:(NSInteger)totalPage currentPage:(NSInteger)currentPage;

- (void)showCurrentPageIndex:(NSInteger)index;

@end
