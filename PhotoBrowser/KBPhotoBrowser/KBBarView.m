//
//  KBBarView.m
//  PhotoBrowser
//
//  Created by liuweiqing on 16/7/19.
//  Copyright © 2016年 RT. All rights reserved.
//

#import "KBBarView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface KBBarView()

@property (nonatomic, strong) UILabel *numberIndexLabel;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation KBBarView
{
    NSInteger _totalPage;
    NSInteger _currentPageIndex;
}

#pragma mark --life cycle

- (instancetype)initWithTotalPage:(NSInteger)totalPage currentPage:(NSInteger)currentPage
{
    if (self = [super init]) {
        _totalPage = totalPage;
        _currentPageIndex = currentPage;
        [self addSubview:self.numberIndexLabel];
//        [self addSubview:self.saveButton];
    }
    return self;
}

- (void)showCurrentPageIndex:(NSInteger)index
{
    
    self.numberIndexLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,_totalPage];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.numberIndexLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
}

#pragma mark --getter&setter
- (UILabel *)numberIndexLabel
{
    if (_numberIndexLabel == nil) {
        _numberIndexLabel = [[UILabel alloc] init];
        _numberIndexLabel.textAlignment = NSTextAlignmentCenter;
        _numberIndexLabel.textColor = [UIColor whiteColor];
        _numberIndexLabel.font = [UIFont systemFontOfSize:13];
        _numberIndexLabel.text = [NSString stringWithFormat:@"%ld/%ld",_currentPageIndex,_totalPage];

    }
    return _numberIndexLabel;
}

- (UIButton *)saveButton
{
    if (_saveButton == nil) {
        _saveButton = [[UIButton alloc] init];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        _saveButton.titleLabel.textColor = [UIColor whiteColor];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _saveButton;
}


@end
