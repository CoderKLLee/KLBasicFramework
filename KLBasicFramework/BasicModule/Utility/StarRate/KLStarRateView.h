//
/*******************************************************************************
        Copyright © 2018年 CoderKLLee. All rights reserved.
 
        File name:     KLStarRateView.h
        Author:        Ferryman (李凯隆)
        Blog  :        https://coderkllee.github.io
        E-mail:        coderkllee@163.com
 
        Description:
 
        History:
                2018/6/29: File created.
 
 ********************************************************************************/
#import <UIKit/UIKit.h>

@class KLStarRateView;
@protocol KLStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(KLStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface KLStarRateView : UIView

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<KLStarRateViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
@end
