//
//  HKSImageTitleCollectionViewCell.m
//  HKSStandardSliding
//
//  Created by Ke Song on 12.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSImageTitleCollectionViewCell.h"
#import "HKSDefinitions.h"

@implementation HKSImageTitleCollectionViewCell

- (void)cellConfigureWithSettings:(NSDictionary*)settings atIndexPath:(NSIndexPath*)indexPath{
    if([settings[@"imageUrl"] length]>0){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.theImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:settings[@"imageUrl"]]]];
        });
    }
    else if([settings[@"imageName"] length]>0){
        NSFileManager *filemanager = [[NSFileManager alloc] init];
        NSString *fileName = [NSString stringWithFormat:@"%@/%@",kSettingsImagePath, settings[@"imageName"]];
        if([filemanager fileExistsAtPath:fileName]){
            self.theImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kSettingsImagePath, settings[@"imageName"]]];
        }else{
            self.theImageView.image = [UIImage imageNamed:@"startimage"];
        }
    }
    else{
        self.theImageView.image = [UIImage imageNamed:@"startimage"];
    }
    self.title.text = settings[@"title"];
}

@end
