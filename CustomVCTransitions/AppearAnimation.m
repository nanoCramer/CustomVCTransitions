//
//  AppearAnimation.m
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/2.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import "AppearAnimation.h"

#define KImageTag       1001
#define KViewTag        1000
#define KImageH         150

@implementation AppearAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 2. Set init frame for toVC
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrame;
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    UIView *scaleView;
    UIView *logoView;
    for (UIView *view in fromVC.view.subviews) {
        if (view.tag == KViewTag) {
            scaleView = view;
        } else if (view.tag == KImageTag) {
            logoView = view;
        }
    }
    CGRect logoRect = logoView.frame;
    
    // 4. Do animate now
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        scaleView.transform = CGAffineTransformMakeScale(10, 10);
        logoView.frame = CGRectMake(logoRect.origin.x, KImageH, logoRect.size.width, logoRect.size.height);
    } completion:^(BOOL finished) {
        scaleView.transform = CGAffineTransformMakeScale(1, 1);
        toVC.view.alpha = 1;
        [transitionContext completeTransition:YES];
    }];
}
@end
