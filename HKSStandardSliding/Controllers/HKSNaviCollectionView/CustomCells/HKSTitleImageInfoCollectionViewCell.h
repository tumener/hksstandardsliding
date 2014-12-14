//
//  HKSTitleImageInfoCollectionViewCell.h
//  HKSStandardSliding
//
//  Created by Ke Song on 12.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSTitleImageInfoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *theImageView;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *theInfos;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *titleHeight;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *infosHeight;

- (void)cellConfigureWithSettings:(NSDictionary*)settings atIndexPath:(NSIndexPath*)indexPath;

@end
