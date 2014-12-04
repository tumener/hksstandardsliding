//
//  HKSNaviStartViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSNaviStartViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "HKSDefinitions.h"
#import "MBProgressHUD.h"

@interface HKSNaviStartViewController ()
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation HKSNaviStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fileManager = [[NSFileManager alloc] init];
    NSLog(@"sliding animation number:%d",[g_dGeneralViewsSettings[@"slidingAnimation"] intValue]);
}


#pragma -mark- HUD
- (void)showProgressHudWithLabel:(NSString*)label{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.removeFromSuperViewOnHide = YES;
        hud.labelText = label;
        hud.mode = MBProgressHUDModeIndeterminate;
        [hud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressHudTapped:)]];
    }
    hud.labelText = label;
}
- (void)progressHudTapped:(UITapGestureRecognizer*)recognizer{
    [self dismissProgressHud];
}
- (void)dismissProgressHud {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
