//
//  KSBackend.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

#define kFtpDocumentsPath                    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent: @"ExDocuments/"]

@interface KSBackend : NSObject

+ (instancetype)sharedController;

@property (nonatomic,strong,readwrite) NSManagedObjectContext* mainManagedObjectContext;
@property (nonatomic,strong) NSManagedObjectModel* managedObjectModel;
@property (nonatomic,strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@property (nonatomic, strong) Reachability *internetReachability;


- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end
