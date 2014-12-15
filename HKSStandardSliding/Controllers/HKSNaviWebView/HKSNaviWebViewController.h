//
//  HKSNaviWebViewController.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSNaviWebViewController : UIViewController < UIWebViewDelegate >
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSDictionary *viewSettings;
@end
