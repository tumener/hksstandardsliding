//
//  NSString+GMTDate.m
//  ExAssistant
//
//  Created by Ke Song on 11.02.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "NSString+GMTDate.h"

@implementation NSString(GMTDate)

- (NSDate*)GMTDate {
    // create GMT date formatter same as from backend
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssz";
    // set time zone
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    // create the nsdate with using time formatter with GMT time zone
    return [dateFormatter dateFromString:self];
}

@end
