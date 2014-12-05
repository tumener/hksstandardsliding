//
//  HKSNaviEmptyViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 03.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSNaviEmptyViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "HKSDefinitions.h"

@interface HKSNaviEmptyViewController ()

@end

@implementation HKSNaviEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s, viewsSettings:%@",__PRETTY_FUNCTION__, _viewSettings);
    self.title = self.viewSettings[@"title"];
}

#pragma -mark- actions
- (IBAction)menuButtonClicked:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
