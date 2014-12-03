//
//  KSSettings.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KSSettings : NSObject

#define kDefaultsUserFtpServerKey                   @"UserdefaultsKey_UserFtpUrl__string"
#define kDefaultsUserFtpUNameKey                    @"UserdefaultsKey_UserFtpUserName__string"
#define kDefaultsUserFtpPswdKey                     @"UserdefaultsKey_UserFtpPassword__string"

#define kDefaultsDocumentsFtpSyncIdKey              @"UserdefaultsKey_Documents_Ftp_Syncrosination_Id__string"
#define kDefaultsDocumentsFtpRootUrlKey             @"UserdefaultsKey_Documents_Ftp_Rooturl__string"
#define kDefaultsDocumentsFtpServerKey              @"UserdefaultsKey_Documents_Server_FTP_Url__string"
#define kDefaultsDocumentsFtpUNameKey               @"UserdefaultsKey_Documents_FTP_UserName__string"
#define kDefaultsDocumentsFtpPasswordKey            @"UserdefaultsKey_FTP_Documents_PassWord__string"
#define kDefaultsCurrentFtpPreviewUrl               @"UserdefaultsKey_CurrentSelectedPdfPath__string"

+ (instancetype) sharedSettings;
- (NSDictionary *)currentSettings;




@end
