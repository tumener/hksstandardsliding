//
//  HKSLeftMenueViewController.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSDictionary *g_dGeneralViewsSettings;

@interface HKSLeftMenueViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end
