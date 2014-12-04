//
//  HKSNaviWebViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSNaviWebViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "HKSDefinitions.h"

@implementation HKSNaviWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewsSettings:%@", _viewSettings);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma -mark- actions
- (IBAction)menuButtonClicked:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


@end
