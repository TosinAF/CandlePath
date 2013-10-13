//
//  CPRouteViewController.m
//  Candle Path
//
//  Created by Tosin Afolabi on 12/10/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import "CPRouteViewController.h"
#import "CPPaypalViewController.h"
#import "CPExtrasViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface CPRouteViewController ()
{
    CLLocation *currentLocation;
    GMSMapView *mapView;
}

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation CPRouteViewController

- (id)initWithdestinationPostcode:(NSString *)destPostcode
{
    self = [super init];

    if (self) {

        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }

    return self;
}

- (void)loadView
{
    // Set Default Location to London England
    CLLocationCoordinate2D defaultLocation = CLLocationCoordinate2DMake(51.5072, 0.1275);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:defaultLocation.latitude
                                                            longitude:defaultLocation.longitude
                                                                 zoom:15];

    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;

    for (UIView *object in mapView.subviews) {
        if([[[object class] description] isEqualToString:@"GMSUISettingsView"] )
        {
            for(UIView *view in object.subviews) {
                if([[[view class] description] isEqualToString:@"UIButton"] ) {
                    view.hidden = YES;
                }
            }

        }
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Route Plan"];

    // To Blank Back Button for Child View
    UIBarButtonItem *blankBackButton = [[UIBarButtonItem alloc] initWithTitle: @"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:blankBackButton];

    UIColor *textColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1];
    self.navigationController.navigationBar.tintColor = textColor;

    /* Navigation Bar */

    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:20.0f],
                                                            NSForegroundColorAttributeName:textColor}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:1]];

    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setFrame:CGRectMake(0, 0, 40, 40)];
    [homeButton setTitle:@"\u2302" forState:UIControlStateNormal];
    [homeButton.titleLabel setFont:[UIFont fontWithName:@"Entypo" size:30]];
    [homeButton setTitleColor:textColor forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];

    /* Options at the bottom of the Map View */

    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton setFrame:CGRectMake(15, 500, 140, 50)];
    [self.leftButton setTitle:@"Keep me safe!" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton setTitleColor:textColor forState:UIControlStateHighlighted];
    [self.leftButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.leftButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:14]];
    [self.leftButton setBackgroundColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:0.5]];


    [self.leftButton.layer setCornerRadius:7.0f];
    [self.leftButton.layer setBorderWidth:2.0f];
    [self.leftButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    [self.leftButton addTarget:self action:@selector(purchaseServiceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    /* Right Button */

    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton setFrame:CGRectMake(15 + 150, 500, 140, 50)];
    [self.rightButton setTitle:@"Extras!" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:textColor forState:UIControlStateHighlighted];
    [self.rightButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.rightButton.titleLabel setFont:[UIFont fontWithName:@"Avenir-Light" size:14]];
    [self.rightButton setBackgroundColor:[UIColor colorWithRed:0.933 green:0.659 blue:0.224 alpha:0.5]];

    [self.rightButton.layer setCornerRadius:7.0f];
    [self.rightButton.layer setBorderWidth:2.0f];
    [self.rightButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    [self.rightButton addTarget:self action:@selector(extrasButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations lastObject];

    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude zoom:15];

    GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setCamera:cameraPosition];

    [mapView animateWithCameraUpdate:cameraUpdate];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Could not find location: %@", error);
}

- (void)homeButtonPressed:(id)sender
{
    [UIView beginAnimations:@"flipAnimation" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView setAnimationDuration:0.7];
    [UIView commitAnimations];

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)purchaseServiceButtonPressed:(id)sender
{
    [UIView beginAnimations:@"curlAnimation" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView setAnimationDuration:0.9];
    [UIView commitAnimations];

    CPPaypalViewController *paypalViewController = [[CPPaypalViewController alloc] init];
    [self.navigationController pushViewController:paypalViewController animated:YES];
}

- (void)extrasButtonPressed:(id)sender
{
    CPExtrasViewController *extrasViewController = [[CPExtrasViewController alloc] init];
    [self.navigationController pushViewController:extrasViewController animated:YES];
}


@end
