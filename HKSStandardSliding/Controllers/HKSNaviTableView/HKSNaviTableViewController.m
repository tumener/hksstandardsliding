//
//  HKSNaviTableViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSNaviTableViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "HKSDefinitions.h"
#import "HKSBasicTableViewCell.h"
#import "HKSImageLabelTableViewCell.h"
#import "HKSImageTitleLabelTableViewCell.h"

@interface HKSNaviTableViewController ()

@end

@implementation HKSNaviTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s, viewsSettings:%@",__PRETTY_FUNCTION__, _viewSettings);
    self.title = self.viewSettings[@"title"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma -mark- actions
- (IBAction)menuButtonClicked:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewSettings[@"cells"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellSettings = (NSDictionary*)[_viewSettings[@"cells"] objectAtIndex:indexPath.row];
    if([cellSettings[@"identifier"] isEqualToString:HKSBasicTableViewCellId]){
        return kBasicTableViewCellHeight;
    }
    else if ([cellSettings[@"identifier"] isEqualToString:HKSImageLabelTableViewCellId]){
        return kImageLabelTableViewCellHeight;
    }
    else if ([cellSettings[@"identifier"] isEqualToString:HKSImageTitleLabelTableViewCellId]){
        return kImageTitleLabelTableViewCellHeight;
    }
    return kDefaultTableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *cellSettings = (NSDictionary*)[_viewSettings[@"cells"] objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    NSString *title = cellSettings[@"title"];
    if([cellSettings[@"identifier"] isEqualToString:HKSBasicTableViewCellId]){
        HKSBasicTableViewCell *basicCell = [tableView dequeueReusableCellWithIdentifier:HKSBasicTableViewCellId forIndexPath:indexPath];
        basicCell.title.text = title;
        cell = basicCell;
    }
    else if ([cellSettings[@"identifier"] isEqualToString:HKSImageLabelTableViewCellId]){
        HKSImageLabelTableViewCell *imageLabelCell = [tableView dequeueReusableCellWithIdentifier:HKSImageLabelTableViewCellId forIndexPath:indexPath];
        if([cellSettings[@"imageUrl"] length]>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                imageLabelCell.theImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cellSettings[@"imageUrl"]]]];
            });
        }
        else{
            imageLabelCell.theImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kSettingsImagePath, cellSettings[@"imageName"]]];
        }
        imageLabelCell.title.text = title;
        cell = imageLabelCell;
    }
    else if ([cellSettings[@"identifier"] isEqualToString:HKSImageTitleLabelTableViewCellId]){
        HKSImageTitleLabelTableViewCell *imageTitleLabelCell = [tableView dequeueReusableCellWithIdentifier:HKSImageTitleLabelTableViewCellId forIndexPath:indexPath];
        imageTitleLabelCell.title.text = title;
        
        if([cellSettings[@"imageUrl"] length]>0){
            dispatch_async(dispatch_get_main_queue(), ^{
                imageTitleLabelCell.theImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cellSettings[@"imageUrl"]]]];
            });
        }
        else{
            imageTitleLabelCell.theImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kSettingsImagePath, cellSettings[@"imageName"]]];
        }
        imageTitleLabelCell.descriptions.text = cellSettings[@"description"];
        cell = imageTitleLabelCell;
    }
    return cell;
}

@end
