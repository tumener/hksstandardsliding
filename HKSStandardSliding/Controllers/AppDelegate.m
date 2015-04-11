//
//  AppDelegate.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+RGBString.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self checkoutSettingsAndImages];
    
    return YES;
}

- (void)checkoutSettingsAndImages{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
//    dispatch_async(dispatch_get_main_queue(),^{
//        
//    });
    
//    });
    
    KSDownloader *downloader = [KSDownloader newDownLoader];
    [downloader updateFileNamesAndSize];
    [downloader checkAndStartDownLoader];
    _fileManager = [[NSFileManager alloc] init];
    if([_fileManager fileExistsAtPath:kSettingsLocalFilePath]){
        g_dGeneralViewsSettings = [[NSDictionary alloc] initWithContentsOfFile:kSettingsLocalFilePath];
    }else{
        g_dGeneralViewsSettings = [[NSDictionary alloc] initWithContentsOfFile:kDefaultSettingsFilePath];
    }
    
//    dispatch_async(dispatch_get_main_queue(),^{
    if([g_dGeneralViewsSettings[@"naviBarBackground"] length]>0){
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromRGBString:g_dGeneralViewsSettings[@"naviBarBackground"]]];
    }
    if([g_dGeneralViewsSettings[@"naviBarTint"] length]>0){
        [[UIBarButtonItem appearance] setTintColor:[UIColor colorFromRGBString:g_dGeneralViewsSettings[@"naviBarTint"]]];
    }
    if([g_dGeneralViewsSettings[@"naviTitleColor"] length]>0){
        NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   [UIColor colorFromRGBString:g_dGeneralViewsSettings[@"naviTitleColor"]],
                                                   NSForegroundColorAttributeName,
                                                   [UIFont systemFontOfSize:22],
                                                   NSFontAttributeName,
                                                   nil];
        [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    }
//    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma -mark- KSDownloaderDelegate
- (void)KSDownloader:(KSDownloader*)downloader progressDidChange:(NSDictionary *)processInfo
{
    double progress = [processInfo[@"progress"] doubleValue];
    int progress100 = 100*progress;
    if(progress<1.0 && progress100%20==1){
        NSLog(@"%s info:%@, %@", __PRETTY_FUNCTION__, processInfo.allKeys, processInfo.allValues);
    }
    if(progress==1.0){
        NSLog(@"did finisch with downloading");
    }
}


@end
