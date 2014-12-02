//
//  KSBackend.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "KSBackend.h"
#import <objc/runtime.h>
#import "KSSettings.h"
#import "NSDate+GMTString.h"

static void *fetchedResultsControllerKey;

@interface KSBackend()
@property (nonatomic, retain) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) KSSettings *settings;
@end


@implementation KSBackend

+ (instancetype)sharedController
{
    static KSBackend *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupSaveNotification];
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.fileManager  = [[NSFileManager alloc] init];
        self.settings     = [KSSettings sharedSettings];
        
        _internetReachability = [self internetReachability];
    }
    return self;
}

#pragma -mark- questionnaires
- (Reachability*)internetReachability{
    _internetReachability = [Reachability reachabilityForInternetConnection];
    return _internetReachability;
}

#pragma mark - core data stack
- (void)setupSaveNotification
{
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification object:nil queue:nil usingBlock:^(NSNotification* note) {
        NSManagedObjectContext *mainContext = self.mainManagedObjectContext;
        NSManagedObjectContext *notificationContext = note.object;
        if (mainContext.persistentStoreCoordinator == notificationContext.persistentStoreCoordinator && notificationContext != mainContext) {
            [mainContext performBlock:^() {
                [mainContext mergeChangesFromContextDidSaveNotification:note];
            }];
        }
    }];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.mainManagedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)mainManagedObjectContext
{
    if (_mainManagedObjectContext != nil) {
        return _mainManagedObjectContext;
    }
    _mainManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _mainManagedObjectContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    return _mainManagedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"StandardSliding" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StandardSliding.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstrun_done"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectContext*)newPrivateContext
{
    NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return context;
}

@end

