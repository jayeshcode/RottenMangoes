//
//  ViewController.h
//  RottenMangoes
//
//  Created by Jayesh Wadhwani on 2016-05-23.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Modal.h"

@interface ViewController : UIViewController
@property (nonatomic,strong)Modal *data;

@property (weak, nonatomic) IBOutlet UILabel *labelview;
@end

