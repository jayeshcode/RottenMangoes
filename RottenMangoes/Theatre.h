//
//  Theatre.h
//  RottenMangoes
//
//  Created by Jayesh Wadhwani on 2016-05-24.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;


@interface Theatre : NSObject <MKAnnotation>
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
//@property (strong,atomic)NSString *lat;
//@property(strong,atomic)NSString *lng;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;

@end
