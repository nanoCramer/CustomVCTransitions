//
//  ChildViewController.h
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/2.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChildViewController;
@protocol ChildViewControllerDelegate <NSObject>

-(void) childViewControllerDidClickedDismissButton:(ChildViewController *)viewController;

@end

@interface ChildViewController : UIViewController
@property (nonatomic, weak) id<ChildViewControllerDelegate> delegate;

@end
