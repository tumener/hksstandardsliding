//
//  KSSettings.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "KSSettings.h"

@interface KSSettings()
@property (nonatomic, strong) NSUserDefaults *defaults;
@end

@implementation KSSettings
@synthesize lastUpdateDate = _lastUpdateDate;

+ (instancetype) sharedSettings{
    static KSSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
        _lastUpdateDate = [_defaults objectForKey:HKSLastUpdateDateKey]?[_defaults objectForKey:HKSLastUpdateDateKey]:HKSReferenceDate;
    }
    return self;
}

- (NSDictionary *)currentSettings {
    return nil;
}

#pragma mark - Getters/Setters
- (void)setLastUpdateDate:(NSDate *)lastUpdateDate{
    _lastUpdateDate = lastUpdateDate;
    [_defaults setObject:lastUpdateDate forKey:HKSLastUpdateDateKey];
    [_defaults synchronize];
}
- (NSDate*)lastUpdateDate{
    return _lastUpdateDate;
}

- (NSDate*)lastModifiedForDocument:(NSString*)document{
    if(![_defaults objectForKey:[document stringByAppendingString:HKSLastModifieldPadding]]){
        [_defaults setObject:HKSReferenceDate forKey:[document stringByAppendingString:HKSLastModifieldPadding]];
        [_defaults synchronize];
    }
    return [_defaults objectForKey:[document stringByAppendingString:HKSLastModifieldPadding]];
}
- (void)setLastModifiedDate:(NSDate*)date forDocument:(NSString*)fileName{
    [_defaults setObject:date forKey:[fileName stringByAppendingString:HKSLastModifieldPadding]];
    [_defaults synchronize];
}

@end
