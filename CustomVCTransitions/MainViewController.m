//
//  ViewController.m
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/1.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import "MainViewController.h"
#import "ChildViewController.h"
#import "AppearAnimation.h"
#import "DismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface MainViewController ()<ChildViewControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) AppearAnimation *presentAnimation;
@property (nonatomic, strong) DismissAnimation *dismissAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *transitionController;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation = [[AppearAnimation alloc] init];
        _dismissAnimation = [[DismissAnimation alloc] init];
        _transitionController = [[SwipeUpInteractiveTransition alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat width = screenBounds.size.width;
    CGFloat height = screenBounds.size.height;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake((width - 100)/2, (height - 100)/2 - 10, 100, 100);
    [button setTitle:@" " forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.aView = [[UIView alloc] init];
    [self.aView setFrame:CGRectMake((width - 100)/2, (height - 100)/2 - 10, 100, 100)];
    [self.aView.layer setCornerRadius:50];
    [self.aView setBackgroundColor:[UIColor greenColor]];
    
    [self.view setCenter:self.aView.center];
    
    [self.view addSubview:self.aView];
    [self.view addSubview:button];
}

-(void) buttonClicked:(id)sender
{
    ChildViewController *mvc =  [[ChildViewController alloc] init];
    mvc.transitioningDelegate = self;
    mvc.delegate = self;
    [self.transitionController wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
}

-(void)childViewControllerDidClickedDismissButton:(ChildViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
}

@end