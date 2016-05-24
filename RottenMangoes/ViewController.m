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

@end
