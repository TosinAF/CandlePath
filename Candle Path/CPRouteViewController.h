//
//  CPRouteViewController.h
//  Candle Path
//
//  Created by Tosin Afolabi on 12/10/2013.
//  Copyright (c) 2013 Tosin Afolabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CPRouteViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

- (id)initWithdestinationPostcode:(NSString *)destPostcode;

@end
