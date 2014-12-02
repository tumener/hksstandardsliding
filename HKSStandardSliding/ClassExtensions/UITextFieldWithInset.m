//
//  UITextFieldWithInset.m
//  ExAssistant
//
//  Created by Ke Song on 06.10.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "UITextFieldWithInset.h"

@implementation UITextFieldWithInset
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 20 , 10);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 20 , 10);
}

@end
