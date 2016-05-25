//
//  ViewController.m
//  RottenMangoes
//
//  Created by Jayesh Wadhwani on 2016-05-23.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

   self.labelview.text=self.data.name;
//    NSLog(@"%@",self.data.name);


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionbutton:(id)sender {


    [self performSegueWithIdentifier:@"map" sender:self];


}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"map"]) {
        
        
               
      MapViewController *controler = (MapViewController *)[segue destinationViewController];
        
        controler.data = self.data;
        
        
        
        
    }
    
    
    
}


@end
