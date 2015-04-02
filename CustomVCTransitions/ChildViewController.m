//
//  ChildViewController.m
//  CustomVCTransitions
//
//  Created by 施杰 on 15/4/2.
//  Copyright (c) 2015年 施杰. All rights reserved.
//

#import "ChildViewController.h"

#define KButtonW            160.0
#define KButtonH            40.0
#define KButtonY            400.0
#define KAnimateDuration    0.5

#define KImageLength        72
#define KImageH             150

#define KChildImageTag      1002
#define KChildButtonTag     1003
#define KChildBGTag         1004

@interface ChildViewController () {
    //    UIButton *button;
}

@end

@implementation ChildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat width = screenBounds.size.width;
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    [bgView setBackgroundColor:[UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1]];
    bgView.tag = KChildButtonTag;
    [self.view addSubview:bgView];
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismissButton.frame = CGRectMake((screenBounds.size.width - KButtonW)/2, KButtonY, KButtonW, KButtonH);
    [dismissButton setTag:KChildButtonTag];
    [dismissButton setTitle:@"Dismiss me" forState:UIControlStateNormal];
    [dismissButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - KImageLength)/2, KImageH, KImageLength, KImageLength)];
    [imageView setImage:[UIImage imageNamed:@"lls.png"]];
    [imageView setTag:KChildImageTag];
    [self.view addSubview:imageView];
}

-(void) buttonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(childViewControllerDidClickedDismissButton:)]) {
        [self.delegate childViewControllerDidClickedDismissButton:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end