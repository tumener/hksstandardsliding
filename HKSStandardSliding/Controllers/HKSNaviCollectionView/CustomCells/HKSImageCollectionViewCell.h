//
//  HKSImageCollectionViewCell.h
//  HKSStandardSliding
//
//  Created by Ke Song on 12.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *theImageView;
- (void)cellConfigureWithSettings:(NSDictionary*)settings atIndexPath:(NSIndexPath*)indexPath;
@end
