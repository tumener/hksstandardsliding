//
//  HKSLeftMenueViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSLeftMenueViewController.h"
#import "HKSDefinitions.h"

@interface HKSLeftMenueViewController ()
@property (nonatomic, strong) NSDictionary *menueViewSettings;
@end

@implementation HKSLeftMenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(NSDictionary *view in g_dGeneralViewsSettings[@"views"]){
        if([view[@"type"]isEqualToString:HKSNaviLeftMenueView]){
            _menueViewSettings = [[NSDictionary alloc] initWithDictionary:view];
            break;
        }
    }
    
    NSString *bgImagePath = [kSettingsImagePath stringByAppendingPathComponent:_menueViewSettings[@"backgroundImage"]];
    NSLog(@"imagePath:%@", bgImagePath);
    self.imageView.image = [UIImage imageWithContentsOfFile:bgImagePath];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menueViewSettings[@"rows"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HKSBasicTableViewCell" forIndexPath:indexPath];
    NSMutableString *tempHex=[[NSMutableString alloc] initWithString:@"0x"];
    [tempHex appendString:_menueViewSettings[@"textColor"]];
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:tempHex] scanHexInt:&colorInt];
    cell.textLabel.textColor = UIColorFromRGB(colorInt);
    cell.textLabel.text = [_menueViewSettings[@"rows"] objectAtIndex:indexPath.row][@"title"];
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
