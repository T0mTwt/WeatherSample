//
//  ViewController.m
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Lyon",@"q",nil];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"weather" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load complete: Table should refresh...");
        
        //[[NSManagedObjectContext MR_defaultContext]saveToPersistentStore:nil];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Hit error: %@", [error localizedDescription]);
        
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
