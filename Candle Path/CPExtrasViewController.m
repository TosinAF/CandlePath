//
//  CPExtrasViewController.m
//  Candle Path
//
//  Created by Tosin Afolabi on 13/10/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "CPExtrasViewController.h"

@interface CPExtrasViewController ()

@property (nonatomic, strong) UIButton *taxiButton;
@property (nonatomic, strong) UIButton *atmButton;
@property (nonatomic, strong) UIButton *takeawayButton;
@property (nonatomic, strong) UIButton *policeButton;
@property (nonatomic, strong) UIButton *shelterButton;

@end

@implementation CPExtrasViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Extras"];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:1]];

    UIColor *textColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];

    // This is horrendous code but i've been awake for more than 24 hours

    /* Taxi Button */

    self.taxiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.taxiButton setFrame:CGRectMake(20, 90, self.view.bounds.size.width - 40, 50)];
    [self.taxiButton setTitle:@"Hire a cab" forState:UIControlStateNormal];
    [self.taxiButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.taxiButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.taxiButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.taxiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [self.taxiButton.layer setCornerRadius:4.0f];
    [self.taxiButton.layer setBorderColor:textColor.CGColor];
    [self.taxiButton.layer setBorderWidth:2.0f];

    /* ATM Button */

    self.atmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.atmButton setFrame:CGRectMake(20, 160, self.view.bounds.size.width - 40, 50)];
    [self.atmButton setTitle:@"Find an ATM" forState:UIControlStateNormal];
    [self.atmButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.atmButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.atmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.atmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [self.atmButton.layer setCornerRadius:4.0f];
    [self.atmButton.layer setBorderColor:textColor.CGColor];
    [self.atmButton.layer setBorderWidth:2.0f];


    /* Takeaway Button */

    self.takeawayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.takeawayButton setFrame:CGRectMake(20, 230, self.view.bounds.size.width - 40, 50)];
    [self.takeawayButton setTitle:@"Find a Takeaway" forState:UIControlStateNormal];
    [self.takeawayButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.takeawayButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.takeawayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.takeawayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [self.takeawayButton.layer setCornerRadius:4.0f];
    [self.takeawayButton.layer setBorderColor:textColor.CGColor];
    [self.takeawayButton.layer setBorderWidth:2.0f];

    /* Police Station Button */

    self.policeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.policeButton setFrame:CGRectMake(20, 300, self.view.bounds.size.width - 40, 50)];
    [self.policeButton setTitle:@"Find a Police Station" forState:UIControlStateNormal];
    [self.policeButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.policeButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.policeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.policeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [self.policeButton.layer setCornerRadius:4.0f];
    [self.policeButton.layer setBorderColor:textColor.CGColor];
    [self.policeButton.layer setBorderWidth:2.0f];


    /* Shelter Button */

    self.shelterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shelterButton setFrame:CGRectMake(20, 370, self.view.bounds.size.width - 40, 50)];
    [self.shelterButton setTitle:@"Hire a cab" forState:UIControlStateNormal];
    [self.shelterButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.shelterButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.shelterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.shelterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [self.shelterButton.layer setCornerRadius:4.0f];
    [self.shelterButton.layer setBorderColor:textColor.CGColor];
    [self.shelterButton.layer setBorderWidth:2.0f];

    [self.view addSubview:self.taxiButton];
    [self.view addSubview:self.atmButton];
    [self.view addSubview:self.takeawayButton];
    [self.view addSubview:self.policeButton];
    [self.view addSubview:self.shelterButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}


@end
