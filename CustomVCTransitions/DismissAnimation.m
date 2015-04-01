//
//  DismissAnimation.m
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/2.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import "DismissAnimation.h"

#define KImageTag       1001
#define KViewTag        1000

@implementation DismissAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    UIView *scaleView;
    UIView *logoView;
    for (UIView *view in toVC.view.subviews) {
        if (view.tag == KViewTag) {
            scaleView = view;
        } else if (view.tag == KImageTag) {
            logoView = view;
        }
    }
    CGRect logoRect = logoView.frame;
    
    // 4. Do animate now
    fromVC.view.alpha = 0;
    scaleView.transform = CGAffineTransformMakeScale(10, 10);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        scaleView.transform = CGAffineTransformMakeScale(1, 1);
        fromVC.view.frame = finalFrame;
        logoView.frame = CGRectMake(0, 0, logoRect.size.width, logoRect.size.height);
        logoView.center = scaleView.center;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
