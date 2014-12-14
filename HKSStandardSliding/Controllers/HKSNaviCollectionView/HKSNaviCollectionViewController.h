//
//  HKSNaviCollectionViewController.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSDictionary *g_dGeneralViewsSettings;
@interface HKSNaviCollectionViewController : UICollectionViewController
< UICollectionViewDataSource, UICollectionViewDelegate >

@property (nonatomic, strong) NSDictionary *viewSettings;

@end
