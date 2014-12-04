//
//  UIColor+RGBString.m
//  HKSStandardSliding
//
//  Created by Ke Song on 04.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "UIColor+RGBString.h"
#import "HKSDefinitions.h"

@implementation UIColor(RGBString)

+ (UIColor*)colorFromRGBString:(NSString*)RGBString{
    NSMutableString *tempHex=[[NSMutableString alloc] init];
    if([RGBString rangeOfString:@"0x"].location == NSNotFound){
        tempHex = [[NSMutableString alloc] initWithString:@"0x"];
    }
    [tempHex appendString:RGBString];
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:tempHex] scanHexInt:&colorInt];
    return UIColorFromRGB(colorInt);
}

@end
