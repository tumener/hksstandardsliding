//
//  NSDate+GMTString.m
//  ExAssistant
//
//  Created by Ke Song on 11.02.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "NSDate+GMTString.h"

@implementation NSDate(GMTString)

-(NSString*)GMTString
{
    // create GMT date formatter same as from backend
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssz";
    // set time zone
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    // create the nsdate with using time formatter with GMT time zone
    return [dateFormatter stringFromDate:self];
}

-(NSInteger)dateFlagForUnitFlag:(NSInteger)unitFlag{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:self];
    switch (unitFlag) {
        case NSYearCalendarUnit:
            return [dateComponents year];
            break;
        case NSMonthCalendarUnit:
            return [dateComponents month];
            break;
        case NSDayCalendarUnit:
            return [dateComponents day];
            break;
        case NSWeekCalendarUnit:
            return [dateComponents week];
            break;
            
        case NSWeekdayCalendarUnit:
            return [dateComponents weekday];
            break;
            
        case NSHourCalendarUnit:
            return [dateComponents hour];
            break;
            
        case NSMinuteCalendarUnit:
            return [dateComponents minute];
            break;
            
        case NSSecondCalendarUnit:
            return [dateComponents second];
            break;
        default:
            break;
    }
    return 0;
}

-(NSString*)GMTYearString
{
    return [NSString stringWithFormat:@"%d", (int)[self dateFlagForUnitFlag:NSYearCalendarUnit]];
}

-(NSString*)GMTMonthString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"MMM"];
    return [dateFormatter stringFromDate:self];
}

-(NSString*)GMTDayString{
    return [NSString stringWithFormat:@"%d", (int)[self dateFlagForUnitFlag:NSDayCalendarUnit]];
}

-(NSString*)GMTWeekdayString{
    return nil;
}

-(NSString*)GMTDisplayString{
    // create GMT date formatter same as from backend
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    // set time zone
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:gmt];
    // create the nsdate with using time formatter with GMT time zone
    return [dateFormatter stringFromDate:self];
}

-(NSString*)GMTYearMonthDisplayString{
    // create GMT date formatter same as from backend
//    NSDate *regDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateFormat:@"MMMM yyyy"];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:self]];
    
    return [dateFormatter stringFromDate:self];
}

+ (NSDateFormatter*)standartDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd-HH.mm.ss"];
    return formatter;
}

+(NSDateFormatter*)localizedShortDateFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateStyle:NSDateFormatterShortStyle];
    [dateformatter setTimeStyle:NSDateFormatterShortStyle];
    return dateformatter;
}

+(NSDateFormatter*)localizedMediumDateFormatter
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateStyle:NSDateFormatterMediumStyle];
    [dateformatter setTimeStyle:NSDateFormatterShortStyle];
    return dateformatter;
}

@end
