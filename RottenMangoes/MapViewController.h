//
//  MapViewController.h
//  RottenMangoes
//
//  Created by Jayesh Wadhwani on 2016-05-24.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Modal.h"
#import "Theatre.h"


@interface MapViewController : UIViewController<CLLocationManagerDelegate>
@property(nonatomic,strong) Modal *data;

- (void)addTheatre;


@end
