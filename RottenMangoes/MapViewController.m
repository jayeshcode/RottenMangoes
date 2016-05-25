//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Jayesh Wadhwani on 2016-05-24.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import "MapViewController.h"
@import MapKit;


@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textview;


@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL shouldZoomToUserLocation;
@property (strong,nonatomic)CLGeocoder *geocoder;
@property(strong,nonatomic)CLPlacemark *placemark;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property(strong,atomic)NSString *postalcode;
@property(strong,atomic)NSMutableArray *locationarray;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.moviename = [[NSString alloc]init];
    _geocoder = [[CLGeocoder alloc] init];
    self.shouldZoomToUserLocation = YES;
    //self.mapview.delegate = self;
    
    
    
    
    
   
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 0;
       
        
        if ([CLLocationManager authorizationStatus] ==
            kCLAuthorizationStatusNotDetermined) {
            [self.locationManager requestWhenInUseAuthorization];
            
            
        }
    }

    

}

    - (void)addTheatre {
        
        
        NSString *endpoint =[NSString stringWithFormat:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=%@&movie=%@",self.postalcode,self.data.name];
        
        NSString *urlString = [endpoint stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
                NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *apiRequest = [NSURLRequest requestWithURL:url];
    
        //NSData *data = [NSData dataWithContentsOfURL:githubURL];
        
        
        NSURLSession *sharedSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *apiTask = [sharedSession dataTaskWithRequest:apiRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"completed response");
            
            if (!error) {
                NSError *jsonError;
                
                //NSData *someBadData = [@"asdfasdfasdfa,sdfasdf[]" dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (!jsonError) {
                    NSLog(@"%@", parsedData);
                    
                    NSMutableArray *theatreArray = [NSMutableArray array];
                     _locationarray = [NSMutableArray array];

                    
                  
                    theatreArray=parsedData[@"theatres"];
                    
                    NSLog(@"%lu",(unsigned long)[theatreArray count]);
                    
                    
                    
                    
                    
                    for (NSDictionary *repoDict in theatreArray) {
                        
                        Theatre *newtheatre = [[Theatre alloc] init];
                        newtheatre.lat = [repoDict[@"lat"] doubleValue];
                        newtheatre.lng = [repoDict[@"lng"] doubleValue];
                        newtheatre.coordinate = CLLocationCoordinate2DMake(newtheatre.lat, newtheatre.lng);
                        
                        [self.locationarray addObject:newtheatre];
                        

                        
                    }
                    
                   
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                                               
                        [self.mapview addAnnotations:self.locationarray];
                    
                    
                    });
                    
                    
                } else {
                    NSLog(@"Error parsing JSON: %@", [jsonError localizedDescription]);
                }
                
                
            } else {
                NSLog(@"%@", [error localizedDescription]);
            }
            
        }];
        
        NSLog(@"Before resume");
        [apiTask resume];
        NSLog(@"After resume");

    
    
    
    
    }




    - (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
        
        if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            [self.locationManager startUpdatingLocation];
            [_mapview setShowsUserLocation:YES];
            [_mapview  setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
            
        } else if (status == kCLAuthorizationStatusDenied) {
            NSLog(@"Y U NO LET ME USE LOCATION");
        }
    
    //    NSLog(@"%@",self.data.name);
  
    }
//
    
    // Do any additional setup after loading the view.
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
       

        
        NSLog(@"%@," ,  [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
         NSLog(@"%@," , [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
   
    NSLog(@"Resolving the Address");
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            
           self.placemark = [placemarks lastObject];
            _textview.text=  [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 _placemark.subThoroughfare, _placemark.thoroughfare,
                                 _placemark.postalCode, _placemark.locality,
                                 _placemark.administrativeArea,
                                 _placemark.country];
            
            _postalcode = [NSString stringWithFormat:@"%@",_placemark.postalCode];
        
            [self addTheatre];

            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];






}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
