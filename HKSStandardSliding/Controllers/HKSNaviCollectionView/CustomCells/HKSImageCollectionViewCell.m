//
//  HKSImageCollectionViewCell.m
//  HKSStandardSliding
//
//  Created by Ke Song on 12.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSImageCollectionViewCell.h"
#import "HKSDefinitions.h"

@implementation HKSImageCollectionViewCell

- (void)cellConfigureWithSettings:(NSDictionary*)settings atIndexPath:(NSIndexPath*)indexPath{
    if([settings[@"imageUrl"] length]>0){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.theImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:settings[@"imageUrl"]]]];
        });
    }
    else{
        self.theImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kSettingsImagePath, settings[@"imageName"]]];
    }
}
@end
