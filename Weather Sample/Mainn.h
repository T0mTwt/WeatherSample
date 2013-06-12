//
//  Mainn.h
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Result;

@interface Mainn : NSManagedObject

@property (nonatomic, retain) NSNumber * m_humidity;
@property (nonatomic, retain) NSNumber * m_pressure;
@property (nonatomic, retain) NSNumber * m_temp;
@property (nonatomic, retain) NSNumber * m_temp_max;
@property (nonatomic, retain) NSNumber * m_temp_min;
@property (nonatomic, retain) Result *m_result;

@end
