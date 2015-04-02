//
//  DismissAnimation.m
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/2.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import "DismissAnimation.h"

#define KMainScaleViewTag   1000
#define KMainImageTag       1001
#define KChildImageTag      1002
#define KChildButtonTag     1003
#define KChildBGTag         1004

@implementation DismissAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    UIView *mainScaleView;
    UIView *mainLogoView;
    UIView *childLogoView;
    UIView *childButtonView;
    UIView *childBGView;
    for (UIView *view in toVC.view.subviews) {
        if (view.tag == KMainScaleViewTag) {
            mainScaleView = view;
        } else if (view.tag == KMainImageTag) {
            mainLogoView = view;
        }
    }
    for (UIView *view in fromVC.view.subviews) {
        if (view.tag == KChildImageTag) {
            childLogoView = view;
        } else if (view.tag == KChildButtonTag) {
            childButtonView = view;
        } else if (view.tag == KChildBGTag) {
            childBGView = view;
        }
    }
    
    CGRect fromChildButtonRect = childButtonView.frame;
    CGRect toChildButtonRect = CGRectMake(fromChildButtonRect.origin.x, screenBounds.size.height, fromChildButtonRect.size.width, fromChildButtonRect.size.height);
    
    CGRect fromLogoRect = childLogoView.frame;
    CGRect toLogoRect = mainLogoView.frame;
    
    // 4. Do animate now
    [childButtonView setFrame:fromChildButtonRect];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:0.2 animations:^{
        [childButtonView setFrame:toChildButtonRect];
    } completion:^(BOOL finished) {
        fromVC.view.alpha = 0;
        mainScaleView.transform = CGAffineTransformMakeScale(10, 10);
        mainLogoView.frame = fromLogoRect;
        [UIView animateWithDuration:(duration - 0.2) animations:^{
            mainScaleView.transform = CGAffineTransformMakeScale(1, 1);
            mainLogoView.frame = toLogoRect;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}

@end
