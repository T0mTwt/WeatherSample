//
//  Wind.h
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Result;

@interface Wind : NSManagedObject

@property (nonatomic, retain) NSNumber * wi_deg;
@property (nonatomic, retain) NSNumber * wi_gust;
@property (nonatomic, retain) NSNumber * wi_speed;
@property (nonatomic, retain) Result *wi_result;

@end
