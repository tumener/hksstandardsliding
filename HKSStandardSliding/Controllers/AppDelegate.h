//
//  AppDelegate.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDownloader.h"
#import "HKSDefinitions.h"

NSDictionary *g_dGeneralViewsSettings;

@interface AppDelegate : UIResponder <UIApplicationDelegate, KSDownloaderDelegate>
@property (strong, nonatomic) UIWindow *window;

@end

