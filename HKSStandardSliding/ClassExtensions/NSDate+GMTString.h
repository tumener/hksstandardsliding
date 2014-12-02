//
//  NSDate+GMTString.h
//  ExAssistant
//
//  Created by Ke Song on 11.02.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(GMTString)

+(NSDateFormatter*)standartDateFormatter;
+(NSDateFormatter*)localizedShortDateFormatter;
+(NSDateFormatter*)localizedMediumDateFormatter;
-(NSString*)GMTString;
-(NSString*)GMTYearString;
-(NSString*)GMTMonthString;
-(NSString*)GMTDayString;
-(NSString*)GMTWeekdayString;
-(NSString*)GMTDisplayString;
-(NSString*)GMTYearMonthDisplayString;
-(NSInteger)dateFlagForUnitFlag:(NSInteger)unitFlag;

@end
