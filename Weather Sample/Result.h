//
//  Result.h
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Coord, Mainn, Sys, Weather, Wind;

@interface Result : NSManagedObject

@property (nonatomic, retain) NSString * r_base;
@property (nonatomic, retain) NSNumber * r_dt;
@property (nonatomic, retain) NSNumber * r_id;
@property (nonatomic, retain) NSString * r_name;
@property (nonatomic, retain) NSNumber * r_cod;
@property (nonatomic, retain) Coord *r_coord;
@property (nonatomic, retain) Mainn *r_main;
@property (nonatomic, retain) Sys *r_sys;
@property (nonatomic, retain) Weather *r_weather;
@property (nonatomic, retain) Wind *r_wind;

@end
