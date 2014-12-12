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
#import "UIColor+RGBString.h"

@interface HKSNaviStartViewController ()
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@end

@implementation HKSNaviStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fileManager = [[NSFileManager alloc] init];
    [self initSlidingAnimation];
    self.title = self.viewSettings[@"title"];
    NSString *startImagePath = [kSettingsImagePath stringByAppendingPathComponent:_viewSettings[@"imageName"]];
    NSLog(@"imagePath:%@", startImagePath);
    self.startImage.image = [UIImage imageWithContentsOfFile:startImagePath];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.descriptionLabel.text = _viewSettings[@"description"];
    CGSize theSize = [self descriptionHeighWithText:_viewSettings[@"description"]];
    self.descriptionHeight.constant = theSize.height+60;
//    self.descriptionWidth.constant = theSize.width;
    CGSize imgViewSize = self.startImage.frame.size;
    CGSize imageSize = self.startImage.image.size;
    
    NSLog(@"viewSize:%@ imageSize:%@", NSStringFromCGSize(imgViewSize), NSStringFromCGSize(imageSize));
    float targetHeight = imageSize.height/imageSize.width*imgViewSize.height;
    if((imgViewSize.height/imgViewSize.width)>(imageSize.height/imageSize.width)){
        self.imageHeight.constant = targetHeight;
    }
    NSLog(@"startImageSize:%@ targetHeight:%.1f", NSStringFromCGRect(self.startImage.frame), targetHeight);
    
    [self.descriptionLabel setCenter:CGPointMake(_startImage.center.x, _descriptionLabel.center.y)];
    
}

- (NSDictionary*)viewSettings{
    if(!_viewSettings){
        for(NSDictionary *view in g_dGeneralViewsSettings[@"views"]){
            if([view[@"type"] isEqualToString:HKSNaviStartView]){
                _viewSettings = [[NSDictionary alloc] initWithDictionary:view];
                break;
            }
        }
    }
    return _viewSettings;
}

#pragma -mark- private functions
- (CGSize)descriptionHeighWithText:(NSString*)text
{
    CGFloat viewWidth = self.startImage.frame.size.width;
    CGRect theFrame = [text boundingRectWithSize:CGSizeMake(viewWidth, 480)
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{ NSFontAttributeName:_descriptionLabel.font }context:nil];
    return theFrame.size;
    
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
    } else if(![transitionName isEqualToString:METransitionNameZoom]) {
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
