//
//  KBPhotoView.h
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBPhotoView;

@protocol KBPhotoViewDelegate <NSObject>

- (void)dismiss;

@end

@interface KBPhotoView : UIView

- (void)showImage:(NSString *)url;
@property (nonatomic, weak) id<KBPhotoViewDelegate> delegate;

@end
