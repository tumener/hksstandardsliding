//
//  HKSNaviWebViewController.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "HKSNaviWebViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "HKSDefinitions.h"

@implementation HKSNaviWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s, viewsSettings:%@",__PRETTY_FUNCTION__, _viewSettings);
    self.title = self.viewSettings[@"title"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadWebviewDetails];
}

#pragma -mark- actions
- (IBAction)menuButtonClicked:(id)sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


#pragma -mark- all private functions
//*********************************************************************************************
//** loadWebviewDetails load document with internal link type in webView
//*********************************************************************************************
- (void)loadWebviewDetails
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_viewSettings[@"url"]]                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil){
             [_webView loadRequest:request];
         }
         else if (error != nil){
             NSLog(@"Error: %@", error);
         }
     }];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%s, with error:%@",__PRETTY_FUNCTION__ ,error);
}

@end
