//
//  CPPaypalViewController.m
//  Candle Path
//
//  Created by Tosin Afolabi on 13/10/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#define PAYPAL_CLIENT_ID @"AfjumxB8wqwysrZfzlpZpAelWBOBVYpoUauDeUix0u3VgCC3w7dM0wc2IyiL"
#define PAYPAL_RECEIVER_EMAIL @"tosman9000@yahoo.com"

#import "CPPaypalViewController.h"

@interface CPPaypalViewController ()

@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UILabel *successSmiley;
@property (nonatomic, strong) UILabel *textLine;
@property (nonatomic, strong) UILabel *textLine2;
@property (nonatomic, strong) UILabel *detailText;
@end

@implementation CPPaypalViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Keep Me Safe"];

    UIColor *textColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];

    /* Navigation Bar */

    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:20.0f],
                                                            NSForegroundColorAttributeName:textColor}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:1]];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:0.5]];

    self.successSmiley = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height / 2 - 50)];
    [self.successSmiley setText:@"\uE806"];
    [self.successSmiley setTextColor:textColor];
    [self.successSmiley setTextAlignment:NSTextAlignmentCenter];
    [self.successSmiley setFont:[UIFont fontWithName:@"candlepath" size:100]];

    self.textLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, self.view.bounds.size.width, 40)];
    [self.textLine setText:@"You have successfully purchased"];
    [self.textLine setTextColor:[UIColor blackColor]];
    [self.textLine setTextAlignment:NSTextAlignmentCenter];
    [self.textLine setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    self.textLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, self.view.bounds.size.width, 40)];
    [self.textLine2 setText:@"Emergency Monitoring"];
    [self.textLine2 setTextColor:[UIColor blackColor]];
    [self.textLine2 setTextAlignment:NSTextAlignmentCenter];
    [self.textLine2 setFont:[UIFont fontWithName:@"Avenir-Light" size:28]];

    self.detailText = [[UILabel alloc] initWithFrame:CGRectMake(20, 330, self.view.bounds.size.width - 40, 120)];
    [self.detailText setText:@"An Emergency Contact will be alerted if there is a prolonged connection loss or any devation from the set route & you do not type in your secret passcode."];
    [self.detailText setTextColor:[UIColor blackColor]];
    [self.detailText setTextAlignment:NSTextAlignmentCenter];
    [self.detailText setNumberOfLines:5];
    [self.detailText setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    /* Done Button */

    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.doneButton setFrame:CGRectMake(20, 500, self.view.bounds.size.width - 40, 50)];
    [self.doneButton setTitle:@"Return to route!" forState:UIControlStateNormal];
    [self.doneButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:16]];

    [self.doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    [self.doneButton.layer setCornerRadius:4.0f];
    [self.doneButton.layer setBorderColor:textColor.CGColor];
    [self.doneButton.layer setBorderWidth:2.0f];

    [self.doneButton addTarget:self action:@selector(returnToRouteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    // Create a PayPalPayment

    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"4.99"];
    payment.currencyCode = @"GBP";
    payment.shortDescription = @"Emergency Monitoring";

    // Check whether payment is processable.
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
    }

    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    NSString *aPayerId = @"someuser@somedomain.com";

    PayPalPaymentViewController *paymentViewController;

    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:PAYPAL_CLIENT_ID
                                                                    receiverEmail:PAYPAL_RECEIVER_EMAIL
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                         delegate:self];

    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationItem setHidesBackButton:NO animated:NO];
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    //[self verifyCompletedPayment:completedPayment];

    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.view addSubview:self.successSmiley];
    [self.view addSubview:self.textLine];
    [self.view addSubview:self.textLine2];
    [self.view addSubview:self.detailText];
    [self.view addSubview:self.doneButton];
}

- (void)payPalPaymentDidCancel {

    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view addSubview:self.doneButton];

}

- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    //NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation options:0 error:nil];

    // Send confirmation to your server; your server should verify the proof of payment
    // and give the user their goods or services. If the server is not reachable, save
    // the confirmation and try again later.
}

- (void)returnToRouteButtonPressed:(id)sender
{
    [UIView beginAnimations:@"curlAnimation" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
    [UIView setAnimationDuration:0.9];
    [UIView commitAnimations];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
