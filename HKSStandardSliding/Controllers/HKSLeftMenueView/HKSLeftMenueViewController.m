//
//  HKSLeftMenueViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSLeftMenueViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "UIColor+RGBString.h"
#import "HKSDefinitions.h"

//  viewControllers
#import "HKSNaviStartViewController.h"
#import "HKSNaviTableViewController.h"
#import "HKSNaviCollectionViewController.h"
#import "HKSNaviWebViewController.h"
#import "HKSNaviEmptyViewController.h"

@interface HKSLeftMenueViewController ()
@property (nonatomic, strong) NSDictionary *menueViewSettings;
@end

@implementation HKSLeftMenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(NSDictionary *view in g_dGeneralViewsSettings[@"views"]){
        if([view[@"type"]isEqualToString:HKSNaviLeftMenueView]){
            _menueViewSettings = [[NSDictionary alloc] initWithDictionary:view];
            break;
        }
    }
    
    NSString *bgImagePath = [kSettingsImagePath stringByAppendingPathComponent:_menueViewSettings[@"backgroundImage"]];
    NSLog(@"imagePath:%@", bgImagePath);
    self.imageView.image = [UIImage imageWithContentsOfFile:bgImagePath];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menueViewSettings[@"rows"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HKSBasicTableViewCell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorFromRGBString:_menueViewSettings[@"textColor"]];
    cell.textLabel.text = [_menueViewSettings[@"rows"] objectAtIndex:indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *viewsId = [_menueViewSettings[@"rows"] objectAtIndex:indexPath.row][@"viewsId"];
    NSDictionary *viewsSettings;
    for(NSDictionary *view in g_dGeneralViewsSettings[@"views"]){
        if([view[@"id"] isEqualToNumber:viewsId]){
            viewsSettings = [[NSDictionary alloc] initWithDictionary:view];
            break;
        }
    }
    NSString *viewsType = viewsSettings[@"type"];
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    if([viewsType isEqualToString:HKSNaviStartView])
    {
        UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:HKSNaviStartViewIdentifier];
        HKSNaviStartViewController *viewController = (HKSNaviStartViewController*)[navigationController.viewControllers objectAtIndex:0];
        viewController.viewSettings = [[NSDictionary alloc] initWithDictionary:viewsSettings];
        self.slidingViewController.topViewController = navigationController;
    }
    else if([viewsType isEqualToString:HKSNaviTableView])
    {
        UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:HKSNaviTableViewIdentifier];
        HKSNaviTableViewController *viewController = (HKSNaviTableViewController*)[navigationController.viewControllers objectAtIndex:0];
        self.slidingViewController.topViewController = navigationController;
        viewController.viewSettings = [[NSDictionary alloc] initWithDictionary:viewsSettings];
    }
    else if([viewsType isEqualToString:HKSNaviWebView])
    {
        UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:HKSNaviWebViewIdentifier];
        HKSNaviWebViewController *viewController = (HKSNaviWebViewController*)[navigationController.viewControllers objectAtIndex:0];
        self.slidingViewController.topViewController = navigationController;
        viewController.viewSettings = [[NSDictionary alloc] initWithDictionary:viewsSettings];
    }
    else if([viewsType isEqualToString:HKSNaviCollectionView])
    {
        UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:HKSNaviCollectionViewIdentifier];
        HKSNaviCollectionViewController *viewController = (HKSNaviCollectionViewController*)[navigationController.viewControllers objectAtIndex:0];
        self.slidingViewController.topViewController = navigationController;
        viewController.viewSettings = [[NSDictionary alloc] initWithDictionary:viewsSettings];
    }
    else if([viewsType isEqualToString:HKSNaviEmptyView])
    {
        UINavigationController *navigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:HKSNaviEmptyViewIdentifier];
        HKSNaviEmptyViewController *viewController = (HKSNaviEmptyViewController*)[navigationController.viewControllers objectAtIndex:0];
        self.slidingViewController.topViewController = navigationController;
        viewController.viewSettings = [[NSDictionary alloc] initWithDictionary:viewsSettings];
    }
    [self.slidingViewController resetTopViewAnimated:YES];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s, identifier:%@", __PRETTY_FUNCTION__, segue.identifier);
}


@end
