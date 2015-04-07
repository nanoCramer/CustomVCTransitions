//
//  DrawCircleView.m
//  DrawCircle
//
//  Created by jshi.cramer on 15/3/26.
//  Copyright (c) 2015年 iWind. All rights reserved.
//

#import "DrawCircleView.h"

#define KDefaultLineWidth   3
#define KDefaultLineColor   [UIColor whiteColor]
#define KDefaultStartValue  0
#define KDefaultEndValue    1
#define KDefaultDuration    1

@implementation DrawCircleView
{
    NSInteger _lineWidth;
    UIColor *_lineColor;
    CGFloat _startValue;
    CGFloat _endValue;
    CGFloat _duration;
    CGRect _circleRect;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 设置默认值
        _lineWidth = KDefaultLineWidth;
        _lineColor = KDefaultLineColor;
        _startValue = KDefaultStartValue;
        _endValue = KDefaultEndValue;
        _duration = KDefaultDuration;
        
        CGFloat minLenght = MIN(self.frame.size.width, self.frame.size.height);
        _circleRect = CGRectMake(0, 0, minLenght, minLenght);
    }
    return self;
}

- (void)setLineWidth:(NSInteger)lineWidth lineColor:(UIColor *)lineColor startValue:(CGFloat)startValue endValue:(CGFloat)endValue duration:(CGFloat)duration {
    if (lineWidth >= _circleRect.size.width/2) {
        _lineWidth = _circleRect.size.width/2;
    } else {
        _lineWidth = lineWidth;
    }
    
    _lineColor = lineColor;
    
    if ((startValue < KDefaultStartValue) || (endValue > KDefaultEndValue) || (startValue > endValue)) {
        _startValue = KDefaultStartValue;
        _endValue = KDefaultEndValue;
    } else {
        _startValue = startValue;
        _endValue = endValue;
    }
    
    if (duration <= 0) {
        _duration = KDefaultDuration;
    }
    
    [self initCircleUIOfView];
}

- (void)initCircleUIOfView {
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat startAngle = (_startValue - 0.25)*2*M_PI;
    CGFloat endAngle = (_endValue - 0.25)*2*M_PI;

    [path addArcWithCenter:CGPointMake(_circleRect.size.width/2,_circleRect.size.height/2) radius:(_circleRect.size.width - _lineWidth)/2 startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = _lineColor.CGColor;
    shapeLayer.lineWidth = _lineWidth;
    shapeLayer.frame = _circleRect;
    [self.layer addSublayer:shapeLayer];
    [self drawLineAnimation:shapeLayer];
}

- (void)drawLineAnimation:(CALayer*)layer {
    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration = _duration;
    bas.delegate = self;
    bas.fromValue = [NSNumber numberWithFloat:0];
    bas.toValue = [NSNumber numberWithFloat:1];
    [layer addAnimation:bas forKey:@"key"];
}

@end
