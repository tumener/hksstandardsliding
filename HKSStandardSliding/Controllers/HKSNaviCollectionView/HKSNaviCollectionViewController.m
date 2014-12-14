//
//  HKSNaviCollectionViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSNaviCollectionViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "HKSDefinitions.h"
#import "HKSImageCollectionViewCell.h"
#import "HKSImageTitleCollectionViewCell.h"
#import "HKSTitleImageInfoCollectionViewCell.h"

@interface HKSNaviCollectionViewController ()
@end

@implementation HKSNaviCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s, viewsSettings:%@",__PRETTY_FUNCTION__, _viewSettings);
    self.title = self.viewSettings[@"title"];
//    [self.collectionView registerClass:[HKSImageCollectionViewCell class] forCellWithReuseIdentifier:HKSImageCollectionViewCellId];
//    [self.collectionView registerClass:[HKSImageTitleCollectionViewCell class] forCellWithReuseIdentifier:HKSImageTitleCollectionCellId];
//    [self.collectionView registerClass:[HKSTitleImageInfoCollectionViewCell class] forCellWithReuseIdentifier:HKSTitleImageInfoCollectionCellId];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self.collectionView reloadData];
}

#pragma -mark- actions
- (IBAction)menuButtonClicked:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

#pragma -mark- private functions

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;//[_viewSettings[@"cells"] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_viewSettings[@"cells"] count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellSettings = (NSDictionary*)[_viewSettings[@"cells"] objectAtIndex:indexPath.row];
    float width = 300.0;
    float height = 300.0;
    if([cellSettings[@"identifier"] isEqualToString:HKSImageTitleCollectionCellId]){
        
    }else if([cellSettings[@"identifier"] isEqualToString:HKSTitleImageInfoCollectionCellId]){
        height = 420.0;
    }
    
//    height += [cellSettings[@"title"] length]>0?40:0;
//    height += [cellSettings[@"description"] length]>0?80:0;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellSettings = (NSDictionary*)[_viewSettings[@"cells"] objectAtIndex:indexPath.row];
    NSString *cellIdentifier = cellSettings[@"identifier"];
    
    UICollectionViewCell *cell;
    NSLog(@"identifier:%@", cellIdentifier);
    
    if([cellIdentifier isEqualToString:HKSImageCollectionViewCellId]){
        HKSImageCollectionViewCell *theCell = (HKSImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSImageCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        cell = theCell;
        /*
        HKSImageTitleCollectionViewCell *theCell = (HKSImageTitleCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSImageTitleCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        theCell.backgroundColor = [UIColor clearColor];
        cell = theCell;
        
        HKSTitleImageInfoCollectionViewCell *theCell = (HKSTitleImageInfoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSTitleImageInfoCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        cell = theCell;
        */
    }else if([cellIdentifier isEqualToString:HKSImageTitleCollectionCellId]){
        /*
        HKSImageCollectionViewCell *theCell = (HKSImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSImageCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        theCell.backgroundColor = [UIColor clearColor];
        cell = theCell;
        */
        HKSImageTitleCollectionViewCell *theCell = (HKSImageTitleCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSImageTitleCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        cell = theCell;
        /*
        HKSTitleImageInfoCollectionViewCell *theCell = (HKSTitleImageInfoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSTitleImageInfoCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        cell = theCell;
        */
    }else if([cellIdentifier isEqualToString:HKSTitleImageInfoCollectionCellId]){
        /*
        HKSImageCollectionViewCell *theCell = (HKSImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSImageCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        theCell.backgroundColor = [UIColor clearColor];
        cell = theCell;
        
        HKSImageTitleCollectionViewCell *theCell = (HKSImageTitleCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSImageTitleCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        theCell.backgroundColor = [UIColor clearColor];
        cell = theCell;
        */
        HKSTitleImageInfoCollectionViewCell *theCell = (HKSTitleImageInfoCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"HKSTitleImageInfoCollectionViewCell" forIndexPath:indexPath];
        [theCell cellConfigureWithSettings:cellSettings atIndexPath:indexPath];
        cell = theCell;
    }

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
