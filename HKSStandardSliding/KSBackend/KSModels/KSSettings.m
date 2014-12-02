//
//  KSSettings.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "KSSettings.h"

#define kDocumentsFtpServer     @"ftp://server2.cvbnm.de/"
#define kDocumentsFtpUName      @"kesong"
#define kDocumentsFtpPswd       @"hakes0ng"
#define kDocumentsFtpSyncId     @"ksexdocuments"
#define kDocumentsFtpRootUrl    [NSString stringWithFormat:@"%@tmp/%@",kDocumentsFtpServer ,kDocumentsFtpSyncId]

#define kDefaultUserFtpServer   @"ftp://server2.cvbnm.de/"
#define kDefaultUserFtpUName    @"kesong"
#define kDefaultUserFtpPswd     @"hakes0ng"
#define kDefaultIdVendor        [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define kDefaultPdfUrl          [[[NSBundle mainBundle] URLForResource:@"input_pdf.pdf" withExtension:nil] absoluteString]

@implementation KSSettings

@synthesize questionLanguage        = _questionLanguage;
@synthesize questionIsRunning       = _questionIsRunning;
@synthesize toolLanguage            = _toolLanguage;
@synthesize nameOfHost              = _nameOfHost;
@synthesize exhibitionName          = _exhibitionName;
@synthesize exhibitionPlace         = _exhibitionPlace;
@synthesize exhibitionDaterange     = _exhibitionDaterange;
@synthesize exhibitionDate          = _exhibitionDate;
@synthesize emailSender             = _emailSender;
@synthesize emailSubject            = _emailSubject;
@synthesize emailContentDE          = _emailContent_DE;
@synthesize emailContentEN          = _emailContent_EN;
@synthesize reOcrNeeded             = _reOcrNeeded;
@synthesize idForVendor             = _idForVendor;
@synthesize deleteAfterExport       = _deleteAfterExport;

@synthesize documentsFtpServer      = _documentsFtpServer;
@synthesize documentsFtpRootUrl     = _documentsFtpRootUrl;
@synthesize documentsFtpSyncId      = _documentsFtpSyncId;
@synthesize documentsFtpUName       = _documentsFtpUName;
@synthesize documentsFtpPassword    = _documentsFtpPassword;

@synthesize userFtpServer           = _userFtpServer;
@synthesize userFtpUName            = _userFtpUName;
@synthesize userFtpPassword         = _userFtpPassword;
@synthesize selectedPdfUrl          = _selectedPdfUrl;



+ (instancetype) sharedSettings{
    static KSSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //GUI auf User-Einstellung setzen, wenn keine User-Einstellung vorhanden, Gerätesprache verwenden
        NSString *shortLanguageCode = [[NSLocale preferredLanguages] objectAtIndex:0];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults stringForKey:kDefaultsToolLaguageKey]){
            _toolLanguage = [defaults stringForKey:kDefaultsToolLaguageKey];
        }
        else{
            [self setToolLanguage:shortLanguageCode];
        }
        
        //read rest of settings or set default if nothing was saved
        _questionLanguage = [defaults stringForKey:kDefaultsQuestaionLaguageKey]?[defaults stringForKey:kDefaultsQuestaionLaguageKey]:_toolLanguage;
        _questionIsRunning =[defaults stringForKey:kDefaultsQuestionRunningKey]?[defaults stringForKey:kDefaultsQuestionRunningKey]:@"NO";
        _nameOfHost       = [defaults stringForKey:kDefaultsNameOfHostKey]?[defaults stringForKey:kDefaultsNameOfHostKey]:@"";
        _exhibitionDate   = [defaults objectForKey:kDefaultsExhibitionDateKey]?[defaults objectForKey:kDefaultsExhibitionDateKey]:[NSDate date];
        _exhibitionName   = [defaults stringForKey:kDefaultsExhibitionNameKey]?[defaults stringForKey:kDefaultsExhibitionNameKey]:nil;
        _exhibitionPlace  = [defaults stringForKey:kDefaultsExhibitionPlaceKey]?[defaults stringForKey:kDefaultsExhibitionPlaceKey]:nil;
        _exhibitionDaterange   = [defaults stringForKey:kDefaultsExhibitionDaterangeKey]?[defaults stringForKey:kDefaultsExhibitionDaterangeKey]:nil;
        _emailSender      = [defaults stringForKey:kDefaultsEmailSenderKey]?[defaults stringForKey:kDefaultsEmailSenderKey]:nil;
        _emailSubject     = [defaults stringForKey:kDefaultsEmailSubjectKey]?[defaults stringForKey:kDefaultsEmailSubjectKey]:nil;
        _reOcrNeeded      = [defaults stringForKey:kDefaultsOcrNeeded]?[defaults stringForKey:kDefaultsOcrNeeded]:@"YES";
        _deleteAfterExport= [defaults stringForKey:kDefaultsDeleteAfterExport]?[defaults stringForKey:kDefaultsDeleteAfterExport]:@"NO";
        _idForVendor      = [defaults stringForKey:kDefaultsIdForVendor]?[defaults stringForKey:kDefaultsIdForVendor]:kDefaultsIdForVendor;
        
        //  settings for download and upload ftp
        _documentsFtpServer = [defaults stringForKey:kDefaultsDocumentsFtpServerKey]?[defaults stringForKey:kDefaultsDocumentsFtpServerKey]:kDocumentsFtpServer;
        _documentsFtpRootUrl = [defaults stringForKey:kDefaultsDocumentsFtpRootUrlKey]?[defaults stringForKey:kDefaultsDocumentsFtpRootUrlKey]:kDocumentsFtpRootUrl;
        _documentsFtpSyncId =   [defaults stringForKey:kDefaultsDocumentsFtpSyncIdKey]?[defaults stringForKey:kDefaultsDocumentsFtpSyncIdKey]:kDocumentsFtpSyncId;
        _documentsFtpUName  =   [defaults stringForKey:kDefaultsDocumentsFtpUNameKey]?[defaults stringForKey:kDefaultsDocumentsFtpUNameKey]:kDocumentsFtpUName;
        _documentsFtpPassword   = [defaults stringForKey:kDefaultsDocumentsFtpPasswordKey]?[defaults stringForKey:kDefaultsDocumentsFtpPasswordKey]:kDocumentsFtpPswd;
        
        _userFtpServer           = [defaults stringForKey:kDefaultsUserFtpServerKey]?[defaults stringForKey:kDefaultsUserFtpServerKey]:kDefaultUserFtpServer;
        _userFtpUName          = [defaults stringForKey:kDefaultsUserFtpUNameKey]?[defaults stringForKey:kDefaultsUserFtpUNameKey]:kDefaultUserFtpUName;
        _userFtpPassword      = [defaults stringForKey:kDefaultsUserFtpPswdKey]?[defaults stringForKey:kDefaultsUserFtpPswdKey]:kDefaultUserFtpPswd;
        _selectedPdfUrl     = [defaults stringForKey:kDefaultsCurrentFtpPreviewUrl]?[defaults stringForKey:kDefaultsCurrentFtpPreviewUrl]:kDefaultPdfUrl;
        
        _emailContent_DE  = [defaults stringForKey:kDefaultsEmailContentDEKey]?[defaults stringForKey:kDefaultsEmailContentDEKey]:@"Sehr geehrte xxxx/Sehr geehrter xxxx,\n\nvielen Dank für Ihr Interesse an unserem Unternehmen. Hiermit schicke ich Ihnen die gewünschten Unterlagen zu.\nBei weiteren Fragen können Sie mich unter folgender E-Mail erreichen: xxxx@Mustermann.com\n\nMit freundlichen Grüßen\n\n";
        _emailContent_EN  = [defaults stringForKey:kDefaultsEmailContentENKey]?[defaults stringForKey:kDefaultsEmailContentENKey]:@"Dear Sir/Dear Madam,\n\nthank you for your interest in our company. Please find attached the documents as requested.\n\nIf you have any further questions, do not hesitate to contact me: xxxxx@wagner.de\n\nBest regards,\n\\n";
        
    }
    return self;
}

- (NSDictionary *)currentSettings {
    
    NSDictionary *settings = @{kDefaultsQuestaionLaguageKey:self.questionLanguage,
                               kDefaultsQuestionRunningKey:self.questionIsRunning,
                               kDefaultsToolLaguageKey:self.toolLanguage,
                               kDefaultsNameOfHostKey:self.nameOfHost,
                               kDefaultsExhibitionDateKey:self.exhibitionDate,
                               kDefaultsExhibitionNameKey:self.exhibitionName,
                               kDefaultsExhibitionPlaceKey:self.exhibitionPlace,
                               kDefaultsExhibitionDaterangeKey:self.exhibitionDaterange,
                               kDefaultsEmailSenderKey:self.emailSender,
                               kDefaultsEmailSubjectKey:self.emailSubject,
                               kDefaultsEmailContentDEKey:self.emailContentDE,
                               kDefaultsEmailContentENKey:self.emailContentEN,
                               kDefaultsOcrNeeded:self.newOcrNeeded,
                               kDefaultsIdForVendor:self.idForVendor,
                               kDefaultsDeleteAfterExport:self.deleteAfterExport,
                               kDefaultsDocumentsFtpRootUrlKey:self.documentsFtpRootUrl,
                               kDefaultsDocumentsFtpServerKey:self.documentsFtpServer,
                               kDefaultsDocumentsFtpSyncIdKey:self.documentsFtpSyncId,
                               kDefaultsDocumentsFtpUNameKey:self.documentsFtpUName,
                               kDefaultsDocumentsFtpPasswordKey:self.documentsFtpPassword,
                               kDefaultsUserFtpServerKey:self.userFtpServer,
                               kDefaultsUserFtpUNameKey:self.userFtpUName,
                               kDefaultUserFtpPswd:self.userFtpPassword,
                               kDefaultsCurrentFtpPreviewUrl:self.selectedPdfUrl
                               };
    return settings;
}

#pragma mark - Localization
- (NSString*)localizedStringForCurrentQuestionLanguage:(NSString*)key {
    NSURL *bundleUrl = [[NSBundle mainBundle] URLForResource:[KSSettings sharedSettings].questionLanguage withExtension:@"lproj"];
    if (bundleUrl == nil) {
        return NSLocalizedString(key, nil);
    } else {
        NSBundle* languageBundle = [NSBundle bundleWithURL:bundleUrl];
        NSString *string = [languageBundle localizedStringForKey:key value:key table:nil];
        return string;
    }
}

#pragma mark - Getters/Setters

-(void)setQuestionLanguage:(NSString *)questionLanguage{
    _questionLanguage = questionLanguage;
    [[NSUserDefaults standardUserDefaults] setObject:questionLanguage forKey:kDefaultsQuestaionLaguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)questionLanguage {
    return _questionLanguage;
}

-(void)setQuestionIsRunning:(NSString *)questionIsRunning
{
    _questionIsRunning = questionIsRunning;
    [[NSUserDefaults standardUserDefaults] setObject:questionIsRunning forKey:kDefaultsQuestionRunningKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString*)questionIsRunning{
    return _questionIsRunning;
}

-(void)setToolLanguage:(NSString *)toolLanguage{
    _toolLanguage = toolLanguage;
    NSLog(@"setToolLanguage %@", toolLanguage);
    
    [self setQuestionLanguage:toolLanguage]; // also change the question default language!
    
    [[NSUserDefaults standardUserDefaults] setObject:toolLanguage forKey:kDefaultsToolLaguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)toolLanguage {
    return _toolLanguage;
}

-(void)setNameOfHost:(NSString *)nameOfHost{
    _nameOfHost = nameOfHost;
    [[NSUserDefaults standardUserDefaults] setObject:nameOfHost forKey:kDefaultsNameOfHostKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)nameOfHost {
    return _nameOfHost;
}

-(void)setExhibitionName:(NSString *)exhibitionName{
    _exhibitionName = exhibitionName;
    [[NSUserDefaults standardUserDefaults] setObject:exhibitionName forKey:kDefaultsExhibitionNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)exhibitionName {
    return _exhibitionName;
}

-(void)setExhibitionPlace:(NSString *)exhibitionPlace{
    _exhibitionPlace = exhibitionPlace;
    [[NSUserDefaults standardUserDefaults] setObject:exhibitionPlace forKey:kDefaultsExhibitionPlaceKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)exhibitionPlace {
    return _exhibitionPlace;
}

-(void)setExhibitionDaterange:(NSString *)exhibitionDaterange {
    _exhibitionDaterange = exhibitionDaterange;
    [[NSUserDefaults standardUserDefaults] setObject:exhibitionDaterange forKey:kDefaultsExhibitionDaterangeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)exhibitionDaterange {
    return _exhibitionDaterange;
}

-(void)setExhibitionDate:(NSDate *)exhibitionDate{
    _exhibitionDate = exhibitionDate;
    [[NSUserDefaults standardUserDefaults] setObject:exhibitionDate forKey:kDefaultsExhibitionDateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSDate*)exhibitionDate{
    return _exhibitionDate;
}

-(void)setEmailSender:(NSString *)sender{
    _emailSender = sender;
    [[NSUserDefaults standardUserDefaults] setObject:sender forKey:kDefaultsEmailSenderKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)emailSender {
    return _emailSender;
}

-(void)setEmailSubject:(NSString *)subject{
    _emailSubject = subject;
    [[NSUserDefaults standardUserDefaults] setObject:subject forKey:kDefaultsEmailSubjectKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)emailSubject {
    return _emailSubject;
}

-(void)setEmailContentDE:(NSString *)content{
    _emailContent_DE = content;
    [[NSUserDefaults standardUserDefaults] setObject:content forKey:kDefaultsEmailContentDEKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)emailContentDE {
    return _emailContent_DE;
}
-(void)setEmailContentEN:(NSString *)content{
    _emailContent_EN = content;
    [[NSUserDefaults standardUserDefaults] setObject:content forKey:kDefaultsEmailContentENKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)emailContentEN {
    return _emailContent_EN;
}

-(void)setNewOcrNeeded:(NSString*)newOcrNeeded{
    _reOcrNeeded = newOcrNeeded;
    [[NSUserDefaults standardUserDefaults] setObject:newOcrNeeded forKey:kDefaultsOcrNeeded];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString*)newOcrNeeded{
    return _reOcrNeeded;
}

-(void)setIdForVendor:(NSString *)idForVendor{
    _idForVendor = idForVendor;
    [[NSUserDefaults standardUserDefaults] setObject:idForVendor forKey:kDefaultsIdForVendor];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString*)idForVendor{
    return _idForVendor;
}

-(void)setDeleteAfterExport:(NSString *)deleteAfterExport{
    _deleteAfterExport = deleteAfterExport;
    [[NSUserDefaults standardUserDefaults] setObject:deleteAfterExport forKey:kDefaultsDeleteAfterExport];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString*)deleteAfterExport{
    return _deleteAfterExport;
}

//  setter and getter for ftps
- (void)setDocumentsFtpRootUrl:(NSString *)documentsFtpRootUrl{
    _documentsFtpRootUrl = documentsFtpRootUrl;
    [[NSUserDefaults standardUserDefaults] setObject:_documentsFtpRootUrl forKey:kDefaultsDocumentsFtpRootUrlKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString*)documentsFtpRootUrl{
    return _documentsFtpRootUrl;
}

-(void)setDocumentsFtpServer:(NSString *)documentsFtpServer{
    _documentsFtpServer = documentsFtpServer;
    [[NSUserDefaults standardUserDefaults] setObject:documentsFtpServer forKey:kDefaultsDocumentsFtpServerKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)documentsFtpServer {
    return _documentsFtpServer;
}

-(void)setDocumentsFtpSyncId:(NSString *)documentsFtpSyncId{
    _documentsFtpSyncId = documentsFtpSyncId;
    [[NSUserDefaults standardUserDefaults] setObject:documentsFtpSyncId forKey:kDefaultsDocumentsFtpSyncIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)documentsFtpSyncId {
    return _documentsFtpSyncId;
}

-(void)setDocumentsFtpUName:(NSString *)documentsFtpUName{
    _documentsFtpUName = documentsFtpUName;
    [[NSUserDefaults standardUserDefaults] setObject:documentsFtpUName forKey:kDefaultsDocumentsFtpUNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)documentsFtpUName {
    return _documentsFtpUName;
}

-(void)setDocumentsFtpPassword:(NSString *)documentsFtpPassword{
    _documentsFtpPassword = documentsFtpPassword;
    [[NSUserDefaults standardUserDefaults] setObject:documentsFtpPassword forKey:kDefaultsDocumentsFtpPasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)documentsFtpPassword {
    return _documentsFtpPassword;
}

-(void)setUserFtpServer:(NSString *)userFtpServer{
    _userFtpServer = userFtpServer;
    [[NSUserDefaults standardUserDefaults] setObject:userFtpServer forKey:kDefaultsUserFtpServerKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)userFtpServer {
    return _userFtpServer;
}

-(void)setUserFtpUName:(NSString *)userFtpUName{
    _userFtpUName = userFtpUName;
    [[NSUserDefaults standardUserDefaults] setObject:userFtpUName forKey:kDefaultsUserFtpUNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)userFtpUName {
    return _userFtpUName;
}

-(void)setUserFtpPassword:(NSString *)userFtpPassword{
    _userFtpPassword = userFtpPassword;
    [[NSUserDefaults standardUserDefaults] setObject:userFtpPassword forKey:kDefaultsUserFtpPswdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)userFtpPassword {
    return _userFtpPassword;
}

- (void)setSelectedPdfUrl:(NSString *)selectedPdfUrl{
    _selectedPdfUrl = selectedPdfUrl;
    [[NSUserDefaults standardUserDefaults] setObject:selectedPdfUrl forKey:kDefaultsCurrentFtpPreviewUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString*)selectedPdfUrl{
    return _selectedPdfUrl;
}

@end
