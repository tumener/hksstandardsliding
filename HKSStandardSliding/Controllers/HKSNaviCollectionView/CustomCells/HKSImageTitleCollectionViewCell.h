//
//  HKSImageTitleCollectionViewCell.h
//  HKSStandardSliding
//
//  Created by Ke Song on 12.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSImageTitleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *theImageView;
@property (nonatomic, strong) IBOutlet UILabel *title;

- (void)cellConfigureWithSettings:(NSDictionary*)settings atIndexPath:(NSIndexPath*)indexPath;
@end
