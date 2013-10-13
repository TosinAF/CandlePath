//
//  CPRootViewController.m
//  Candle Path
//
//  Created by Tosin Afolabi on 12/10/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "CPRootViewController.h"
#import "CPRouteViewController.h"


@interface CPRootViewController ()

@property (nonatomic, strong) UITextField *destinationTextField;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation CPRootViewController


- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *appTitle = @"Candle Path";
    NSString *questionString = @"Where would you like to go?";
    UIColor *textColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    UIColor *highlightColor = [UIColor colorWithRed:0.898 green:0.859 blue:0.141 alpha:1];

    /* Background Image */

    UIImageView *backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImg.png"]];
    [backgroundImg setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

    /* Logo */

    UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 150)];
    [logo setText:@"\uE801"];
    [logo setFont:[UIFont fontWithName:@"candlepath" size:50]];
    [logo setTextAlignment:NSTextAlignmentCenter];
    [logo setTextColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:1]];

    /* Title Label */

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setText:appTitle];
    [titleLabel setTextColor:textColor];
    [titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:40]];

    CGSize titleLabelSize = [appTitle sizeWithAttributes:@{NSFontAttributeName:titleLabel.font}];
    [titleLabel setFrame:CGRectMake(50, 150, titleLabelSize.width, titleLabelSize.height)];

    /* Question Label */

    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [questionLabel setText:questionString];
    [questionLabel setTextColor:textColor];
    [questionLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:20]];

    CGSize questionLabelSize = [questionString sizeWithAttributes:@{NSFontAttributeName:questionLabel.font}];
    [questionLabel setFrame:CGRectMake(35, 250, questionLabelSize.width,questionLabelSize.height)];

    /* Get Destination Text Field */
    // TODO: Validation needs to be added to this textfield

    self.destinationTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 280, 240, 50)];
    [self.destinationTextField setDelegate:self];
    [self.destinationTextField setPlaceholder:@"Enter Postcode"];
    [self.destinationTextField setTextAlignment:NSTextAlignmentCenter];

    /* Submit Button */

    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setFrame:CGRectMake(85, 370, 150, 50)];
    [self.submitButton setTitle:@"Light the way!" forState:UIControlStateNormal];
    [self.submitButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.submitButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.submitButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.submitButton setTitleColor:highlightColor forState:UIControlStateHighlighted];

    [self.submitButton.layer setCornerRadius:4.0f];
    [self.submitButton.layer setBorderColor:textColor.CGColor];
    [self.submitButton.layer setBorderWidth:2.0f];

    [self.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    /* Adding Subviews */

    [self.view addSubview:backgroundImg];
    [self.view addSubview:logo];
    [self.view addSubview:titleLabel];
    [self.view addSubview:questionLabel];
    [self.view addSubview:self.destinationTextField];
    [self.view addSubview:self.submitButton];

    // Co-ordinates for Launch Image Positions
    //[logo setFrame:CGRectMake(0, 150, self.view.bounds.size.width, 150)];
    //[titleLabel setFrame:CGRectMake(50, 270, titleLabelSize.width, titleLabelSize.height)];

    [self.destinationTextField setText:@"NG8 1BB"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.destinationTextField resignFirstResponder];
    return YES;
}

- (void)submitButtonPressed:(id)sender
{
    NSString *destPostcode = self.destinationTextField.text;

    if ( [destPostcode length] >= 6 ) {

        [UIView beginAnimations:@"flipAnimation" context:nil];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
        [UIView setAnimationDuration:0.7];
        [UIView commitAnimations];

        CPRouteViewController *routeController = [[CPRouteViewController alloc] initWithdestinationPostcode:destPostcode];
        [self.navigationController pushViewController:routeController animated:NO];

    }
}




@end
