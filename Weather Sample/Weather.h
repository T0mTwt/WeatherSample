//
//  Weather.h
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Result;

@interface Weather : NSManagedObject

@property (nonatomic, retain) NSString * w_description;
@property (nonatomic, retain) NSString * w_icon;
@property (nonatomic, retain) NSNumber * w_id;
@property (nonatomic, retain) NSString * w_main;
@property (nonatomic, retain) Result *w_result;

@end
