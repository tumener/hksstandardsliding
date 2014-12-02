//
//  UIAlertView+Blocks.m
//
//  Created by Sylvain Guillope on 12-06-04.
//  Copyright (c) 2012 Sylvain Guillope. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>


// Keys for the associated objects used by the category
static char AssociatedObjectKeyOriginalDelegate;
static char AssociatedObjectKeyDidSelectButtonBlock;
static char AssociatedObjectKeyWillDismissBlock;
static char AssociatedObjectKeyDidDismissBlock;


@implementation UIAlertView (Blocks)


///--------------------------------------------------
/// Private Methods (Delegate)
///--------------------------------------------------
#pragma mark - Private Methods (Delegate)

- (void)_switchDelegate
{
  if (self == self.delegate)
  {
    return;
  }
  
  // We save a reference to the original delegate and set ourself as the
  // delegate to receive the delegate callbacks
  objc_setAssociatedObject(self, &AssociatedObjectKeyOriginalDelegate, self.delegate, OBJC_ASSOCIATION_ASSIGN);
  [self setDelegate:self];
}

- (id)_originalDelegate
{
  return objc_getAssociatedObject(self, &AssociatedObjectKeyOriginalDelegate);
}

- (void)_setBlock:(id)block withAssociatedObjectKey:(char *)key
{
  [self _switchDelegate];
  objc_setAssociatedObject(self, key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



///--------------------------------------------------
/// Blocks Management
///--------------------------------------------------
#pragma mark - Blocks Management

- (void)setOnDidSelectButton:(void (^)(NSUInteger buttonIndex))block
{
  [self _setBlock:block withAssociatedObjectKey:&AssociatedObjectKeyDidSelectButtonBlock];
}

- (void)setOnWillDismiss:(void (^)(NSUInteger buttonIndex))block
{
  [self _setBlock:block withAssociatedObjectKey:&AssociatedObjectKeyWillDismissBlock];
}

- (void)setOnDidDismiss:(void (^)(NSUInteger buttonIndex))block
{
  [self _setBlock:block withAssociatedObjectKey:&AssociatedObjectKeyDidDismissBlock];
}



///--------------------------------------------------
/// Alert View Delegate
///--------------------------------------------------
#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, &AssociatedObjectKeyDidSelectButtonBlock);
  
  if (nil != block)
  {
    block(buttonIndex);
    objc_setAssociatedObject(self, &AssociatedObjectKeyDidSelectButtonBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
  }
  
  // Let's forward the call to the original delegate if it was set
  id delegate = [self _originalDelegate];
  if (YES == [delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
  {
    [delegate alertView:alertView clickedButtonAtIndex:buttonIndex];
  }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, &AssociatedObjectKeyWillDismissBlock);
  
  if (nil != block)
  {
    block(buttonIndex);
    objc_setAssociatedObject(self, &AssociatedObjectKeyWillDismissBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
  }
  
  // Let's forward the call to the original delegate if it was set
  id delegate = [self _originalDelegate];
  if (YES == [delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
  {
    [delegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
  }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  void (^block)(NSUInteger buttonIndex) = objc_getAssociatedObject(self, &AssociatedObjectKeyDidDismissBlock);
  
  if (nil != block)
  {
    block(buttonIndex);
    objc_setAssociatedObject(self, &AssociatedObjectKeyDidDismissBlock, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
  }
  
  // Let's forward the call to the original delegate if it was set
  id delegate = [self _originalDelegate];
  if (YES == [delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
  {
    [delegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
  }
}

@end
