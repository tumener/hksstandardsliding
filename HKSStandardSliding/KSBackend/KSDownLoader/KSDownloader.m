//
//  KSDownloader.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "KSDownloader.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "KSBackend.h"
#import "KSSettings.h"

@interface KSDownloader()
@property (nonatomic, strong) UIViewController *callingController;
@property (nonatomic, strong) KSBackend *backend;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) KSSettings *settings;
@property (nonatomic, strong) FTPManager *ftpManager;

@end

@implementation KSDownloader

+ (instancetype)newDownLoader
{
    static KSDownloader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.fileManager  = [[NSFileManager alloc] init];
        self.ftpManager = [[FTPManager alloc] init];
        self.ftpManager.delegate = self;
        self.backend = [KSBackend sharedController];
        self.settings = [KSSettings sharedSettings];
        self.callingController = (UIViewController*)self.delegate;
    }
    return self;
}

- (BOOL)ftpSettingsReady {
    return _settings.documentsFtpServer.length>0 && _settings.documentsFtpUName.length>0 && _settings.documentsFtpUName.length>0;
}

- (UIAlertView*)alertCheckInternet{
    return [[UIAlertView alloc] initWithTitle:NSLocalizedString(LSCommonError, nil) message:NSLocalizedString(LSCheckInternetMsg, nil) delegate:nil cancelButtonTitle:NSLocalizedString(LSCommonOk, nil) otherButtonTitles:nil, nil];
}

- (void)checkAndStartDownLoader
{
    if (self.backend.internetReachability.currentReachabilityStatus == NotReachable) {
        [[self alertCheckInternet] show];
    } else {
        NSString *urlString = _settings.documentsFtpRootUrl;
        FMServer *server = [FMServer serverWithDestination:urlString username:_settings.documentsFtpUName password:_settings.documentsFtpPassword];
        server.port = 21;
        
        if([_ftpManager checkLogin:server]){
            NSLog(@"!!\ncheck login Success!\n");
            NSArray *contentsOfServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
            NSString *currentFilePath = kFtpDocumentsPath;
            [self creatDirectoryAtPath:currentFilePath];
            for(int i=0;i<contentsOfServer.count;i++){
                NSDictionary *resource = [[NSDictionary alloc] initWithDictionary:[contentsOfServer objectAtIndex:i]];
                NSString *fileName = resource[(id)kCFFTPResourceName];
                NSInteger fileType = [resource[(id)kCFFTPResourceType] intValue];
                if(![fileName isEqualToString:@"."] && ! [fileName isEqualToString:@".."]){
                    NSString *newLocalPath = currentFilePath;
                    NSString *newUrlString = [NSString stringWithFormat:@"%@/%@/", urlString, fileName];//[urlString stringByAppendingPathComponent:fileName];
                    if(fileType==FTPResourceDirectory){
                        newLocalPath = [NSString stringWithFormat:@"%@/%@/", newLocalPath, fileName];
                        [self creatDirectoryAtPath:newLocalPath];
                        
                        server = [FMServer serverWithDestination:newUrlString username:_settings.documentsFtpUName password:_settings.documentsFtpPassword];
                        server.port = 21;
                        
                        NSArray *contentsOfNewServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
                        NSLog(@"subdirectory has fileNumber:%d", (int)contentsOfNewServer.count);
                        for(int j=0; j<contentsOfNewServer.count; j++){
                            NSDictionary *theResource = [[NSDictionary alloc] initWithDictionary:[contentsOfNewServer objectAtIndex:j]];
                            NSString *theFileName = theResource[(id)kCFFTPResourceName];
                            NSInteger theFileType = [theResource[(id)kCFFTPResourceType] intValue];
                            
                            if(![theFileName isEqualToString:@"."] && ![theFileName isEqualToString:@".."]){
                                if(theFileType == FTPResourceDocument){
                                    [self startNewDownLoadWithFileName:theFileName url:newUrlString andDestination:newLocalPath];
                                }
                            }
                        }
                    }
                    else if(fileType==FTPResourceDocument){
                        [self startNewDownLoadWithFileName:fileName url:urlString andDestination:newLocalPath];
                    }
                    NSLog(@"%@ with Name:%@", fileType==4?@"Directory":@"File", fileName);
                }
            }
        }
        else{
            NSLog(@"check Login Error!");
        }
        
    }
}

- (void)creatDirectoryAtPath:(NSString*)path
{
    BOOL isDirectory = YES;
    if(![_fileManager fileExistsAtPath:path isDirectory: &isDirectory]){
        [_fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)startNewDownLoadWithFileName:(NSString*)fileName url:(NSString*)url andDestination:(NSString*)destination
{
    dispatch_async(dispatch_get_main_queue(), ^{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FMServer *newServer = [FMServer serverWithDestination:url username:_settings.documentsFtpUName password:_settings.documentsFtpPassword];
        newServer.port = 21;
        BOOL success = [_ftpManager downloadFile:fileName toDirectory:[NSURL URLWithString:destination] fromServer:newServer];
        NSLog(@"downloading success:%@", success?@"YES":@"NO");
    });
}

#pragma -mark class getter
- (double)downLoadSize{
    if(!_downLoadSize){
        if(_backend.internetReachability != NotReachable){
            [self updateFileNamesAndSize];
        }else{
            [[self alertCheckInternet] show];
        }
    }
    return _downLoadSize;
}

- (NSInteger)fileNumber{
    if(!_fileNumber){
        if(_backend.internetReachability != NotReachable){
            [self updateFileNamesAndSize];
        }else{
            [[self alertCheckInternet] show];
        }
    }
    return _fileNumber;
}

- (void)updateFileNamesAndSize
{
    NSString *urlString = _settings.documentsFtpRootUrl;
    FMServer *server = [FMServer serverWithDestination:urlString username:_settings.documentsFtpUName password:_settings.documentsFtpPassword];
    server.port = 21;
    NSInteger number = 0;
    double downLoadSize = 0.0;
    if([_ftpManager checkLogin:server]){
        NSLog(@"!!\ncheck login Success!\n");
        NSArray *contentsOfServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
        NSString *currentFilePath = kFtpDocumentsPath;
        [self creatDirectoryAtPath:currentFilePath];
        
        for(int i=0;i<contentsOfServer.count;i++){
            NSDictionary *resource = [[NSDictionary alloc] initWithDictionary:[contentsOfServer objectAtIndex:i]];
            if(i==0){NSLog(@"resorceKeys:%@ values:%@", resource.allKeys, resource.allValues);}
//            NSString *fileName = resource[(id)kCFFTPResourceName];
//            NSInteger fileType = [resource[(id)kCFFTPResourceType] intValue];
            /*
            if(![fileName isEqualToString:@"."] && ! [fileName isEqualToString:@".."]){
                NSString *newLocalPath = currentFilePath;
                NSString *newUrlString = [NSString stringWithFormat:@"%@/%@/", urlString, fileName];
                if(fileType==FTPResourceDirectory){
                    NSManagedObjectContext *context = [_backend mainManagedObjectContext];
                    newLocalPath = [NSString stringWithFormat:@"%@/%@/", newLocalPath, fileName];
                    [self creatDirectoryAtPath:newLocalPath];
                    server = [FMServer serverWithDestination:newUrlString username:_settings.documentsFtpUName password:_settings.documentsFtpPassword];
                    server.port = 21;
                    
                    NSString *cateSyncId = _settings.documentsFtpSyncId;
                    KSCategory *newCategory = [_backend findOrCreateCategoryWithSycId:cateSyncId name:fileName inContext:context];
                    newCategory.downloadLink = newUrlString;
                    newCategory.localLink = newLocalPath;
                    newCategory.sortId = [NSNumber numberWithInt:i];
                    double totleSize = 0.0;
                    NSArray *contentsOfNewServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
                    NSLog(@"subdirectory has fileNumber:%ld", contentsOfNewServer.count);
                    for(int j=0; j<contentsOfNewServer.count; j++){
                        NSDictionary *theResource = [[NSDictionary alloc] initWithDictionary:[contentsOfNewServer objectAtIndex:j]];
                        NSString *theFileName = theResource[(id)kCFFTPResourceName];
                        NSInteger theFileType = [theResource[(id)kCFFTPResourceType] intValue];
                        
                        if(![theFileName isEqualToString:@"."] && ![theFileName isEqualToString:@".."]){
                            if(theFileType == FTPResourceDocument){
                                NSNumber *downloadSize = [NSNumber numberWithDouble: [theResource[(id)kCFFTPResourceSize] doubleValue]];
                                KSDocument *newDocument = [_backend findOrCreateDocumentWithName:theFileName downloadSize:downloadSize inContext:nil];
                                newDocument.localLink = newLocalPath;
                                newDocument.downloadLink = newUrlString;
                                newDocument.type = ([theFileName rangeOfString:@"."].location == NSNotFound)?@"":[[theFileName componentsSeparatedByString:@"."] objectAtIndex:1];
                                newDocument.category = newCategory;
                                newDocument.name = theFileName;
                                totleSize += [newDocument.downloadSize doubleValue];
                                number++;
                                downLoadSize += [newDocument.downloadSize doubleValue];
                                [self.backend saveContext];
                            }
                        }
                    }
                    newCategory.downloadSize = [NSNumber numberWithDouble:totleSize];
                    [self.backend saveContext];
                }
                else if(fileType==FTPResourceDocument){
                    NSNumber *downloadSize = [NSNumber numberWithDouble: [resource[(id)kCFFTPResourceSize] doubleValue]];
                    KSDocument *newDocument = [_backend findOrCreateDocumentWithName:fileName downloadSize:downloadSize inContext:nil];
                    newDocument.downloadLink = newUrlString;
                    newDocument.localLink = newLocalPath;
                    newDocument.type = ([fileName rangeOfString:@"."].location == NSNotFound)?@"":[[fileName componentsSeparatedByString:@"."] objectAtIndex:1];
                    number++;
                    downLoadSize += [newDocument.downloadSize doubleValue];
                    [self.backend saveContext];
                }
                NSLog(@"%@ with Name:%@", fileType==4?@"Directory":@"File", fileName);
            }
            */
        }
    }
    else{
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(LSConnectionErrorTitle, nil) message:NSLocalizedString(LSConnectionErrorMsg, nil) delegate:nil cancelButtonTitle:NSLocalizedString(LSCommonOk, nil) otherButtonTitles:nil, nil] show];
        NSLog(@"check Login Error!");
    }
    self.downLoadSize = downLoadSize;
    self.fileNumber = number;
}


#pragma mark - FTPManager delegate
- (void)ftpManagerUploadProgressDidChange:(NSDictionary *)processInfo{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)ftpManagerDownloadProgressDidChange:(NSDictionary *)processInfo
{
    if(self.delegate){
//        [self.delegate documentsDownloader:self progressDidChange:processInfo];
    }
    
    double progress = [processInfo[@"progress"] doubleValue];
    int progress100 = 100*progress;
    if(progress<1.0 && progress100%20==1){
        NSLog(@"%s info:%@, %@", __PRETTY_FUNCTION__, processInfo.allKeys, processInfo.allValues);
    }
    if(progress==1.0){
        NSLog(@"did finisch with downloading");
    }
}


@end
