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
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@end

@implementation HKSNaviStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fileManager = [[NSFileManager alloc] init];
    NSLog(@"sliding animation number:%d",[g_dGeneralViewsSettings[@"slidingAnimation"] intValue]);
}

- (void)viewWillAppear:(BOOL)animated{
    [self initSlidingAnimation];
}

#pragma -mark- actions
- (IBAction)menuButtonClicked:(id)sender
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

#pragma -mark- private functions
- (void)initSlidingAnimation
{
    [self transitions].dynamicTransition.slidingViewController = self.slidingViewController;
    NSDictionary *transitionData = self.transitions.all[[g_dGeneralViewsSettings[@"slidingAnimation"] intValue]];
    id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
    if (transition == (id)[NSNull null]) {
        self.slidingViewController.delegate = nil;
    } else {
        self.slidingViewController.delegate = transition;
    }
    NSString *transitionName = transitionData[@"name"];
    if ([transitionName isEqualToString:METransitionNameDynamic]) {
        self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGestureCustom;
        self.slidingViewController.customAnchoredGestures = @[self.dynamicTransitionPanGesture];
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
        [self.navigationController.view addGestureRecognizer:self.dynamicTransitionPanGesture];
    } else {
        self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
        self.slidingViewController.customAnchoredGestures = @[];
        [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }
}

#pragma -mark- GestureRecognizer
- (UIPanGestureRecognizer *)dynamicTransitionPanGesture
{
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
    return _dynamicTransitionPanGesture;
}

#pragma -mark- transitions extensions
- (METransitions *)transitions
{
    if (_transitions){
        return _transitions;
    }
    _transitions = [[METransitions alloc] init];
    return _transitions;
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





@end
