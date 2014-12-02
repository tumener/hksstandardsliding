//
//  UIActionSheet+Blocks.h
//  ExAssistant
//
//  Created by Ke Song on 14.10.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet(Blocks) <UIActionSheetDelegate>

- (void)setOnWillDismiss:(void (^)(NSInteger buttonIndex))block;
- (void)setOnDidDismiss:(void (^)(NSInteger buttonIndex))block;

@end
