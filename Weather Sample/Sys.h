//
//  Sys.h
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Result;

@interface Sys : NSManagedObject

@property (nonatomic, retain) NSString * s_country;
@property (nonatomic, retain) NSNumber * s_sunrise;
@property (nonatomic, retain) NSNumber * s_sunset;
@property (nonatomic, retain) Result *s_result;

@end
