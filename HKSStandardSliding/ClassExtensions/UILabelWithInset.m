//
//  UILabelWithInset.m
//  ExAssistant
//
//  Created by Ke Song on 15.11.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "UILabelWithInset.h"

@implementation UILabelWithInset

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 20 , 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
