//
//  AppDelegate.m
//  Weather Sample
//
//  Created by Thomas Leblond on 12/06/13.
//  Copyright (c) 2013 Thomas LEBLOND. All rights reserved.
//

#import "AppDelegate.h"

@interface NSManagedObjectContext ()
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Weather.sqlite"];
    
    [managedObjectStore addSQLitePersistentStoreAtPath:path
                                fromSeedDatabaseAtPath:nil
                                     withConfiguration:nil
                                               options:nil
                                                 error:nil];
    
    [managedObjectStore createManagedObjectContexts];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/"]];
    manager.managedObjectStore = managedObjectStore;
    [manager setRequestSerializationMIMEType:@"application/json"];
    [manager setAcceptHeaderWithMIMEType:@"application/json"];
    [manager setHTTPClient:[[AFHTTPClient alloc]initWithBaseURL:manager.baseURL]];
    
    [RKObjectMapping addDefaultDateFormatterForString:@"yyyy-MM-ddTHH:mm:ss"
                                           inTimeZone:[NSTimeZone localTimeZone]];
    
    // Network
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Log all HTTP traffic with request and response bodies
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    // Log debugging info about Core Data
    //ReFontRKLogConfigureByName("RestKit/CoreData", RKLogLevelDebug);
    
    // Raise logging for a block
    //RKLogWithLevelWhileExecutingBlock(RKLogLevelTrace, ^{
    // Do something that generates logs
    //});
    
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"application/json"];
    
    // MagicalRecord
    // Configure MagicalRecord to use RestKit's Core Data stack
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_setRootSavingContext:managedObjectStore.persistentStoreManagedObjectContext];
    [NSManagedObjectContext MR_setDefaultContext:managedObjectStore.mainQueueManagedObjectContext];
    
    // RKEntityMapping
    RKEntityMapping *wind_mapping = [RKEntityMapping mappingForEntityForName:@"Wind" inManagedObjectStore:managedObjectStore];
    RKEntityMapping *sys_mapping = [RKEntityMapping mappingForEntityForName:@"Sys" inManagedObjectStore:managedObjectStore];
    RKEntityMapping *weather_mapping = [RKEntityMapping mappingForEntityForName:@"Weather" inManagedObjectStore:managedObjectStore];
    RKEntityMapping *coord_mapping = [RKEntityMapping mappingForEntityForName:@"Coord" inManagedObjectStore:managedObjectStore];
    RKEntityMapping *mainn_mapping = [RKEntityMapping mappingForEntityForName:@"Mainn" inManagedObjectStore:managedObjectStore];
    RKEntityMapping *result_mapping = [RKEntityMapping mappingForEntityForName:@"Result" inManagedObjectStore:managedObjectStore];
    
    [wind_mapping addAttributeMappingsFromDictionary:@{
     @"deg": @"wi_deg",
     @"speed": @"wi_speed"}];
    
    sys_mapping.identificationAttributes = @[@"s_country"];
    [sys_mapping addAttributeMappingsFromDictionary:@{
     @"country": @"s_country",
     @"sunrise": @"s_sunrise",
     @"sunset": @"s_sunset"}];
    
    
    weather_mapping.identificationAttributes = @[@"w_id"];
    [weather_mapping addAttributeMappingsFromDictionary:@{
     @"id": @"w_id",
     @"icon": @"w_icon",
     @"description": @"W_description",
     @"main": @"w_main"}];
    
    
    [coord_mapping addAttributeMappingsFromDictionary:@{
     @"lat": @"c_lat",
     @"long": @"c_long"}];
    
    [mainn_mapping addAttributeMappingsFromDictionary:@{
     @"humidity": @"m_humidity",
     @"pressure": @"m_pressure",
     @"temp": @"m_temp",
     @"temp_min": @"m_temp_min",
     @"temp_max": @"m_temp_max"}];
    
    result_mapping.identificationAttributes = @[@"r_id"];
    [result_mapping addAttributeMappingsFromDictionary:@{
     @"id": @"r_id",
     @"cod": @"r_cod",
     @"dt": @"r_dt",
     @"name": @"r_name",
     @"base": @"r_base"}];
    
    [result_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wind"
                                                                                   toKeyPath:@"r_wind"
                                                                                 withMapping:wind_mapping]];
    
    [result_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"sys" toKeyPath:@"r_sys" withMapping:sys_mapping]];
    
    [result_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather" toKeyPath:@"r_weather" withMapping:weather_mapping]];
    
    [result_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"coord" toKeyPath:@"r_coord" withMapping:coord_mapping]];
    
    [result_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"main" toKeyPath:@"r_main" withMapping:mainn_mapping]];

    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:result_mapping
                                                                           pathPattern:@"weather"
                                                                               keyPath:@""
                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)]];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
