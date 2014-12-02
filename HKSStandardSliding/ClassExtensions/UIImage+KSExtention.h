//
//  UIImage+KSExtention.h
//  ExAssistant
//
//  Created by Ke Song on 10.10.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(KSExtention)

+ (UIImage*) imageWithImage:(UIImage*)image resizeToSize:(CGSize)reSize;
+ (UIImage*) imageWithImage:(UIImage*)image scaledToSize:(CGSize)reSize;
+ (UIImage*) imageWithImage:(UIImage*)image rotatedByDegrees:(CGFloat)degrees;
+ (UIImage*) imageWithImage:(UIImage*)image scaleWithProportionallyToSize:(CGSize)targetSize;
+ (UIImage*) imageWithImage:(UIImage*)image clippingWithTargetFrame:(CGRect)targetFrame;
+ (UIImage*) imageWithImage:(UIImage*)image byCIFilterWithName:(NSString*)filterName;
+ (UIImage*) imageWithImage:(UIImage *)image CIFiltedWithName:(NSString *)filterName;
+ (UIImage*) imageConverteToGrayScale:(UIImage*)image;
+ (UIImage*) imageWithImage:(UIImage*)image grayImageWithType:(NSInteger)type;
+ (UIImage*) imageWithImage:(UIImage *)image byRotate:(UIImageOrientation)orient;
@end
