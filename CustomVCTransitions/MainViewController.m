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

#define KImageLength    72
#define KImageTag       1001

#define KViewLength     100
#define KViewTag        1000

@interface MainViewController ()<ChildViewControllerDelegate,UIViewControllerTransitioningDelegate>
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KImageLength, KImageLength)];
    [imageView setImage:[UIImage imageNamed:@"lls.png"]];
    [imageView setTag:KImageTag];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, KViewLength, KViewLength);
    [button setTitle:@" " forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *scaleview = [[UIView alloc] init];
    [scaleview setTag:KViewTag];
    [scaleview setFrame:CGRectMake((width - KViewLength)/2, (height - KViewLength)/2, KViewLength, KViewLength)];
    [scaleview.layer setCornerRadius:KViewLength/2];
    [scaleview setBackgroundColor:[UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1]];
    
    imageView.center = scaleview.center;
    button.center = scaleview.center;
    
    [self.view addSubview:scaleview];
    [self.view addSubview:button];
    [self.view addSubview:imageView];
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