//
//  UIActionSheet+Blocks.m
//  ExAssistant
//
//  Created by Ke Song on 14.10.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <objc/runtime.h>
#import "UIActionSheet+Blocks.h"

static char AssociatedObjectKeyOriginalDelegate;
static char AssociatedObjectKeyWillDismissBlock;
static char AssociatedObjectKeyDidDismissBlock;

@implementation UIActionSheet(Blocks)
- (void)resetOriginalDelegate {
    if (self.delegate == self) return;
    objc_setAssociatedObject(self, &AssociatedObjectKeyOriginalDelegate, self.delegate, OBJC_ASSOCIATION_ASSIGN);
    self.delegate = self;
}

- (id)originalDelegate {
    return objc_getAssociatedObject(self, &AssociatedObjectKeyOriginalDelegate);
}

- (void)setOnDidDismiss:(void (^)(NSInteger buttonIndex))block {
    [self resetOriginalDelegate];
    objc_setAssociatedObject(self, &AssociatedObjectKeyDidDismissBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setOnWillDismiss:(void (^)(NSInteger buttonIndex))block {
    [self resetOriginalDelegate];
    objc_setAssociatedObject(self, &AssociatedObjectKeyWillDismissBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    void (^block)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &AssociatedObjectKeyWillDismissBlock);
    
    if (block != nil) {
        block(buttonIndex);
        objc_setAssociatedObject(self, &AssociatedObjectKeyWillDismissBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    } else {
        id delegate = [self originalDelegate];
        if ([delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
            [delegate actionSheet:self willDismissWithButtonIndex:buttonIndex];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    void (^block)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &AssociatedObjectKeyDidDismissBlock);
    
    if (block != nil) {
        block(buttonIndex);
        objc_setAssociatedObject(self, &AssociatedObjectKeyDidDismissBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    } else {
        id delegate = [self originalDelegate];
        if ([delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
            [delegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
        }
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    id delegate = [self originalDelegate];
    if ([delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [delegate willPresentActionSheet:actionSheet];
    }
}

@end
