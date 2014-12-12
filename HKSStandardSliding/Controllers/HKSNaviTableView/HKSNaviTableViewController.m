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
        HKSImageTitleLabelTableViewCell *imageLabelCell = [tableView dequeueReusableCellWithIdentifier:HKSImageLabelTableViewCellId forIndexPath:indexPath];
        imageLabelCell.imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kSettingsImagePath, cellSettings[@"imageName"]]];
        imageLabelCell.title.text = title;
        cell = imageLabelCell;
    }
    else if ([cellSettings[@"identifier"] isEqualToString:HKSImageTitleLabelTableViewCellId]){
        HKSImageTitleLabelTableViewCell *imageTitleLabelCell = [tableView dequeueReusableCellWithIdentifier:HKSImageTitleLabelTableViewCellId forIndexPath:indexPath];
        imageTitleLabelCell.title.text = title;
        imageTitleLabelCell.imageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kSettingsImagePath, cellSettings[@"imageName"]]];
        imageTitleLabelCell.detailTextLabel.text = cellSettings[@"description"];
        cell = imageTitleLabelCell;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
