//
//  KSSettings.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// settings userdefaults keys

#define HKSReferenceDate                    [NSDate dateWithTimeIntervalSinceReferenceDate:0.0]
#define HKSLastUpdateDateKey                @"UserdefaultsKeyLastUpdatedAt__date"
#define HKSLastModifieldPadding             @"_LastModifiedAt__date"

@interface KSSettings : NSObject

@property (nonatomic, copy) NSDate *lastUpdateDate;

+ (instancetype) sharedSettings;
- (NSDictionary *)currentSettings;
- (NSDate*)lastModifiedForDocument:(NSString*)document;
- (void)setLastModifiedDate:(NSDate*)date forDocument:(NSString*)fileName;


@end
