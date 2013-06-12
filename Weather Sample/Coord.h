//
//  Coord.h
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Result;

@interface Coord : NSManagedObject

@property (nonatomic, retain) NSNumber * c_lat;
@property (nonatomic, retain) NSNumber * c_long;
@property (nonatomic, retain) Result *c_result;

@end
