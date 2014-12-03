//
//  KSSettings.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "KSSettings.h"



@implementation KSSettings




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
        //GUI auf User-Einstellung setzen, wenn keine User-Einstellung vorhanden, Gerätesprache verwenden
        NSString *shortLanguageCode = [[NSLocale preferredLanguages] objectAtIndex:0];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults stringForKey:kDefaultsToolLaguageKey]){
            _toolLanguage = [defaults stringForKey:kDefaultsToolLaguageKey];
        }
        else{
            [self setToolLanguage:shortLanguageCode];
        }
        
        //read rest of settings or set default if nothing was saved
            return self;
}

- (NSDictionary *)currentSettings {
}

#pragma mark - Localization
- (NSString*)localizedStringForCurrentQuestionLanguage:(NSString*)key {
    NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:[KSSettings sharedSettings].questionLanguage withExtension:@"lproj"];
    if (bundleUrl == nil) {
        return NSLocalizedString(key, nil);
    } else {
        NSBundle* languageBundle = [NSBundle bundleWithURL:bundleUrl];
        NSString *string = [languageBundle localizedStringForKey:key value:key table:nil];
        return string;
    }
}

#pragma mark - Getters/Setters


@end
