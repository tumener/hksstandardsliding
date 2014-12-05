//
//  HKSNaviStartViewController.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

extern NSDictionary *g_dGeneralViewsSettings;

@interface HKSNaviStartViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIImageView *startImage;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *descriptionHeight;
@property (nonatomic, strong) NSDictionary *viewSettings;
@end
