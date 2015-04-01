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

#define KImageLength    72
#define KImageH         150
#define KImageTag       1001

@interface ChildViewController () {
    UIButton *button;
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
    self.view.backgroundColor = [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat width = screenBounds.size.width;
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake((screenBounds.size.width - KButtonW)/2, screenBounds.size.height, KButtonW, KButtonH);
    [button setTitle:@"Dismiss me" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - KImageLength)/2, KImageH, KImageLength, KImageLength)];
    [imageView setImage:[UIImage imageNamed:@"lls.png"]];
    [imageView setTag:KImageTag];
    [self.view addSubview:imageView];
}

- (void)viewDidAppear:(BOOL)animated {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:KAnimateDuration animations:^{
        button.frame = CGRectMake((screenBounds.size.width - KButtonW)/2, KButtonY, KButtonW, KButtonH);
    } completion:^(BOOL finished) {
    }];
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