//
//  NSString+hex.h
//  HKSStandardSliding
//
//  Created by Ke Song on 04.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(hex)

+ (NSString *) stringFromHex:(NSString *)str;
+ (NSString *) stringToHex:(NSString *)str;

@end
