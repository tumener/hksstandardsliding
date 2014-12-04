//
//  AppDelegate.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "AppDelegate.h"
#import "KSDownloader.h"

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

//#pragma -mark- HUD
//- (void)showProgressHudWithLabel:(NSString*)label{
//    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
//    if (!hud) {
//        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeAnnularDeterminate;
//        hud.removeFromSuperViewOnHide = YES;
//        hud.labelText = label;
//        hud.mode = MBProgressHUDModeIndeterminate;
//        [hud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressHudTapped:)]];
//    }
//    hud.labelText = label;
//}
//- (void)progressHudTapped:(UITapGestureRecognizer*)recognizer{
//    [self dismissProgressHud];
//}
//- (void)dismissProgressHud {
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//}


@end
