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

#define KImageLength        72
#define KMainImageTag       1001

#define KViewLength         100
#define KMainScaleViewTag   1000

@interface MainViewController ()<ChildViewControllerDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) AppearAnimation *presentAnimation;
@property (nonatomic, strong) DismissAnimation *dismissAnimation;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation = [[AppearAnimation alloc] init];
        _dismissAnimation = [[DismissAnimation alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenBounds.size.width;
    CGFloat screenHeight = screenBounds.size.height;
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KImageLength, KImageLength)];
    [logoImageView setImage:[UIImage imageNamed:@"lls.png"]];
    [logoImageView setTag:KMainImageTag];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, KViewLength, KViewLength);
    [button setTitle:@" " forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *scaleview = [[UIView alloc] init];
    [scaleview setTag:KMainScaleViewTag];
    [scaleview setFrame:CGRectMake((screenWidth - KViewLength)/2, (screenHeight - KViewLength)/2, KViewLength, KViewLength)];
    [scaleview.layer setCornerRadius:KViewLength/2];
    [scaleview setBackgroundColor:[UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1]];
    
    logoImageView.center = scaleview.center;
    button.center = scaleview.center;
    
    [self.view addSubview:scaleview];
    [self.view addSubview:button];
    [self.view addSubview:logoImageView];
}

- (void)buttonClicked:(id)sender
{
    ChildViewController *mvc =  [[ChildViewController alloc] init];
    mvc.transitioningDelegate = self;
    mvc.delegate = self;
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)childViewControllerDidClickedDismissButton:(ChildViewController *)viewController
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

@end