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

#define kDefaultsQuestaionLaguageKey                @"UserdefaultsKey_QuestionLanguage__string"
#define kDefaultsQuestionRunningKey                 @"UserdefaultsKey_QuestionIsRunning__string"
#define kDefaultsToolLaguageKey                     @"UserdefaultsKey_ToolLanguage__string"
#define kDefaultsNameOfHostKey                      @"UserdefautlsKey_NameOfHost__string"
#define kDefaultsExhibitionDateKey                  @"UserdefaultsKey_ExhibitionDate__date"
#define kDefaultsExhibitionNameKey                  @"UserdefaultsKey_ExhibitionName__string"
#define kDefaultsExhibitionPlaceKey                 @"UserdefaultsKey_ExhibitionPlace__string"
#define kDefaultsExhibitionDaterangeKey             @"UserdefaultsKey_ExhibitionDateRange__string"
#define kDefaultsEmailSenderKey                     @"UserdefaultsKey_EmailSender__string"
#define kDefaultsEmailSubjectKey                    @"UserdefaultsKey_EmailSubject__string"
#define kDefaultsEmailContentDEKey                  @"UserdefaultsKey_EmailContentDE__string"
#define kDefaultsEmailContentENKey                  @"UserdefaultsKey_EmailContentEN__string"
#define kDefaultsOcrNeeded                          @"UserdefautlsKey_Needed_Repeat_Ocr_Processing__string"
#define kDefaultsIdForVendor                        @"UserdefaultsKey_IdentifierForVendor__string"
#define kDefaultsDeleteAfterExport                  @"UserdefaultsKey_DeleteAfterExportQuestionnaires__string"

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

@property   (nonatomic, copy)   NSString    *questionLanguage;
@property   (nonatomic, copy)   NSString    *questionIsRunning;
@property   (nonatomic, copy)   NSString    *toolLanguage;
@property   (nonatomic, copy)   NSString    *nameOfHost;
@property   (nonatomic, copy)   NSString    *exhibitionName;
@property   (nonatomic, copy)   NSString    *exhibitionPlace;
@property   (nonatomic, copy)   NSString    *exhibitionDaterange;
@property   (nonatomic, strong) NSDate      *exhibitionDate;
@property   (nonatomic, copy)   NSString    *emailSender;
@property   (nonatomic, copy)   NSString    *emailSubject;
@property   (nonatomic, copy)   NSString    *emailContentDE;
@property   (nonatomic, copy)   NSString    *emailContentEN;
@property   (nonatomic, copy)   NSString    *reOcrNeeded;
@property   (nonatomic, copy)   NSString    *idForVendor;
@property   (nonatomic, copy)   NSString    *deleteAfterExport;

@property   (nonatomic, copy)   NSString    *documentsFtpRootUrl;
@property   (nonatomic, copy)   NSString    *documentsFtpSyncId;
@property   (nonatomic, copy)   NSString    *documentsFtpServer;
@property   (nonatomic, copy)   NSString    *documentsFtpUName;
@property   (nonatomic, copy)   NSString    *documentsFtpPassword;

@property   (nonatomic, copy)   NSString    *userFtpUName;
@property   (nonatomic, copy)   NSString    *userFtpServer;
@property   (nonatomic, copy)   NSString    *userFtpPassword;
@property   (nonatomic, copy)   NSString    *selectedPdfUrl;



- (NSString*)localizedStringForCurrentQuestionLanguage:(NSString*)key;

@end
