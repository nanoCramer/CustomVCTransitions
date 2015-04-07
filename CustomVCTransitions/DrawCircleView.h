//
//  DrawCircleView.h
//  DrawCircle
//
//  Created by jshi.cramer on 15/3/26.
//  Copyright (c) 2015年 iWind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawCircleView : UIView

- (void)setLineWidth:(NSInteger)lineWidth lineColor:(UIColor *)lineColor startValue:(CGFloat)startValue endValue:(CGFloat)endValue duration:(CGFloat)duration;

@end
