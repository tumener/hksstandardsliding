//
//  AppDelegate.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[KSDownloader newDownLoader] checkAndStartDownLoader];
    _fileManager = [[NSFileManager alloc] init];
    if([_fileManager fileExistsAtPath:kSettingsLocalFilePath]){
        g_dGeneralViewsSettings = [[NSDictionary alloc] initWithContentsOfFile:kSettingsLocalFilePath];
    }else{
        g_dGeneralViewsSettings = [[NSDictionary alloc] initWithContentsOfFile:kDefaultSettingsFilePath];
    }
    return YES;
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
