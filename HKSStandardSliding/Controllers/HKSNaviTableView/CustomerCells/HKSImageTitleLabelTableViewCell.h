//
//  HKSImageTitleLabelTableViewCell.h
//  HKSStandardSliding
//
//  Created by Ke Song on 06.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSImageTitleLabelTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *theImageView;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *descriptions;
@end
