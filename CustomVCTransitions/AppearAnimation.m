//
//  AppearAnimation.m
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/2.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import "AppearAnimation.h"

#define KMainScaleViewTag   1000
#define KMainImageTag       1001
#define KChildImageTag      1002
#define KChildButtonTag     1003
#define KChildBGTag         1004
#define KMainDCViewTag      1005

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
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = finalFrame;
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    UIView *mainScaleView;
    UIView *mainLogoView;
    UIView *mainDCView;
    UIView *childLogoView;
    UIView *childButtonView;
    UIView *childBGView;
    for (UIView *view in fromVC.view.subviews) {
        if (view.tag == KMainScaleViewTag) {
            mainScaleView = view;
        } else if (view.tag == KMainImageTag) {
            mainLogoView = view;
        } else if (view.tag == KMainDCViewTag) {
            mainDCView = view;
        }
    }
    for (UIView *view in toVC.view.subviews) {
        if (view.tag == KChildImageTag) {
            childLogoView = view;
        } else if (view.tag == KChildButtonTag) {
            childButtonView = view;
        } else if (view.tag == KChildBGTag) {
            childBGView = view;
        }
    }
    
    CGRect fromLogoRect = mainLogoView.frame;
    CGRect toLogoRect = childLogoView.frame;
    
    CGRect toChildButtonRect = childButtonView.frame;
    CGRect fromChildButtonRect = CGRectMake(toChildButtonRect.origin.x, screenBounds.size.height, toChildButtonRect.size.width, toChildButtonRect.size.height);
    
    // 4. Do animate now
    mainLogoView.frame = fromLogoRect;
    childBGView.alpha = 0;
    childLogoView.alpha = 0;
    toVC.view.alpha = 0;
    mainDCView.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{
        mainScaleView.transform = CGAffineTransformMakeScale(10, 10);
        mainLogoView.frame = toLogoRect;
        mainDCView.alpha = 0;
        childBGView.alpha = 0;
        childLogoView.alpha = 0;
    } completion:^(BOOL finished) {
        mainScaleView.transform = CGAffineTransformMakeScale(1, 1);
        mainLogoView.frame = fromLogoRect;
        mainDCView.alpha = 1;
        childBGView.alpha = 1;
        childLogoView.alpha = 1;
        toVC.view.alpha = 1;
        
        [childButtonView setFrame:fromChildButtonRect];
        [UIView animateWithDuration:([self transitionDuration:transitionContext] - 0.5) animations:^{
            [childButtonView setFrame:toChildButtonRect];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}
@end
