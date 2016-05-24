//
//  MyCollectionViewController.m
//  RottenMangoes
//
//  Created by Jayesh Wadhwani on 2016-05-23.
//  Copyright © 2016 Jayesh Wadhwani. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()
@property NSArray *objects;


@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"MyCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
 

    // Register cell classes
//   [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//
  
    ((UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout).sectionInset = UIEdgeInsetsMake(0, 0, 0, 5);
    
    
    NSURL *githubURL = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=55gey28y6ygcr8fjy4ty87ek&page_limit=50"];
    NSURLRequest *apiRequest = [NSURLRequest requestWithURL:githubURL];
    
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
                
                NSMutableArray *modalArray = [NSMutableArray array];
                NSDictionary *tempdict =[NSDictionary dictionary];
                
                NSMutableArray *moviesArray = [NSMutableArray array];
                moviesArray=parsedData[@"movies"];
                NSLog(@"%d",[moviesArray count]);
                NSLog(@"1st title %@",moviesArray[0][@"title"]);
                NSLog(@"1st link %@",moviesArray[0][@"posters"][@"thumbnail"]);
                
                tempdict = moviesArray[0][@"posters"];
                
                
                for (NSDictionary *repoDict in moviesArray) {
                    Modal *newModal = [[Modal alloc] init];
                    newModal.name = repoDict[@"title"];
                    
                    newModal.imagename=repoDict[@"posters"][@"thumbnail"];
                    
                    
                    
                    
                    [modalArray addObject:newModal];
                    
                }
                
                self.objects = modalArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"view"]) {
        
        NSArray *array = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = array[0];
        
        
        ViewController *controller = (ViewController *)[segue destinationViewController];
        controller.data= self.objects[indexPath.row];
        
        
    }
    
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [self.objects count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Modal *modal = self.objects[indexPath.row];
    
    
    NSURL *imageURL = [NSURL URLWithString:modal.imagename];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    // NSURLRequest *apiRequest = [NSURLRequest requestWithURL:imageURL];
    // NSURLSession *sharedSession = [NSURLSession sharedSession];
    cell.celllabel1.text = modal.name;
    
    cell.cellimage.image = [[UIImage alloc] initWithData:data];
    
    cell.celllabel1.numberOfLines=0;
    [cell.celllabel1 sizeToFit];
    // Configure the cell
    
    
    
    
    
    
    
    
    
   
    
//    NSURLSessionDataTask *apiTask = [sharedSession dataTaskWithRequest:apiRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSLog(@"completed response");
//        
//        if (!error) {
//            
//            
//                
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //cell.cellimage.image=apiRequest;
//                });
//                
//                
//            } }];
//    
//    NSLog(@"Before resume");
//    [apiTask resume];
//    NSLog(@"After resume");
//    

  



    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
     [self performSegueWithIdentifier:@"view" sender:indexPath];
    
    NSLog(@"%d",indexPath.row);




}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
