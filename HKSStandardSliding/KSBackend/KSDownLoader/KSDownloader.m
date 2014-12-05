//
//  KSDownloader.m
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import "KSDownloader.h"
#import "HKSDefinitions.h"
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
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSMutableArray *downloadingFiles;

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
        self.defaults = [[NSUserDefaults alloc] init];
        self.callingController = (UIViewController*)self.delegate;
    }
    return self;
}

- (UIAlertView*)alertCheckInternet{
    return [[UIAlertView alloc] initWithTitle:NSLocalizedString(LSCommonError, nil) message:NSLocalizedString(LSCheckInternetMsg, nil) delegate:nil cancelButtonTitle:NSLocalizedString(LSCommonOk, nil) otherButtonTitles:nil, nil];
}

- (void)checkAndStartDownLoader
{
    NSLog(@"number of files to douwload:%d and totle size:%f",(int)self.fileNumber, self.downLoadSize);
    _downloadingFiles = [[NSMutableArray alloc] init];
    if (self.backend.internetReachability.currentReachabilityStatus == NotReachable) {
        [[self alertCheckInternet] show];
    } else {
        NSString *urlString = kDocumentsFtpRootUrl;
        FMServer *server = [FMServer serverWithDestination:urlString username:kDefaultUserFtpUName password:kDefaultUserFtpPswd];
        server.port = 21;
        
        if([_ftpManager checkLogin:server]){
            NSLog(@"!!\ncheck login Success!\n");
            NSArray *contentsOfServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
            NSString *currentFilePath = kSettingsLocalBasePath;
//            [self creatDirectoryAtPath:currentFilePath];
            for(int i=0;i<contentsOfServer.count;i++){
                NSDictionary *resource = [[NSDictionary alloc] initWithDictionary:[contentsOfServer objectAtIndex:i]];
                NSString *fileName = resource[(id)kCFFTPResourceName];
                NSInteger fileType = [resource[(id)kCFFTPResourceType] intValue];
                if(![fileName isEqualToString:@"."] && ! [fileName isEqualToString:@".."]){
                    NSString *newLocalPath = currentFilePath;
                    NSString *newUrlString = [NSString stringWithFormat:@"%@/%@/", urlString, fileName];//[urlString stringByAppendingPathComponent:fileName];
                    if(fileType==FTPResourceDirectory){
                        newLocalPath = [NSString stringWithFormat:@"%@/%@/", newLocalPath, fileName];
//                        [self creatDirectoryAtPath:newLocalPath];
                        server = [FMServer serverWithDestination:newUrlString username:kDefaultUserFtpUName password:kDefaultUserFtpPswd];
                        server.port = 21;
                        NSArray *contentsOfNewServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
//                        NSLog(@"subdirectory has fileNumber:%d", (int)contentsOfNewServer.count);
                        for(int j=0; j<contentsOfNewServer.count; j++){
                            NSDictionary *theResource = [[NSDictionary alloc] initWithDictionary:[contentsOfNewServer objectAtIndex:j]];
                            NSString *theFileName = theResource[(id)kCFFTPResourceName];
                            NSInteger theFileType = [theResource[(id)kCFFTPResourceType] intValue];
//                            NSLog(@"theResource:%@", theResource);
                            if(![theFileName isEqualToString:@"."] && ![theFileName isEqualToString:@".."]){
                                if(theFileType == FTPResourceDocument){
                                    NSDate *fileModDate = theResource[(id)kCFFTPResourceModDate];
                                    NSDate *lastUpdateDate = [_settings lastModifiedForDocument:theFileName];
                                    NSLog(@"last updateDate:%@ fileModDate:%@",lastUpdateDate ,fileModDate);
                                    // first date eallier as the second one
                                    if([lastUpdateDate compare:fileModDate]==NSOrderedAscending){
                                        NSLog(@"the file:%@ will be downloaded!\n", theFileName);
                                        [_downloadingFiles addObject:theFileName];
                                        [self startNewDownLoadWithFileName:theFileName url:newUrlString andDestination:newLocalPath];
                                    }
                                }
                            }
                        }
                    }
                    else if(fileType==FTPResourceDocument){
                        NSDate *fileModDate = resource[(id)kCFFTPResourceModDate];
                        NSDate *lastUpdateDate = [_settings lastModifiedForDocument:fileName];
                        NSLog(@"last updateDate:%@ fileModDate:%@",lastUpdateDate ,fileModDate);
                        // first date eallier as the second one
                        if([lastUpdateDate compare:fileModDate]==NSOrderedAscending){
                            [_downloadingFiles addObject:fileName];
                            [self startNewDownLoadWithFileName:fileName url:urlString andDestination:newLocalPath];
                        }
                    }
//                    NSLog(@"%@ with Name:%@", fileType==4?@"Directory":@"File", fileName);
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
//    dispatch_async(dispatch_get_main_queue(), ^{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        FMServer *newServer = [FMServer serverWithDestination:url username:kDefaultUserFtpUName password:kDefaultUserFtpPswd];
        newServer.port = 21;
        BOOL success = [_ftpManager downloadFile:fileName toDirectory:[NSURL URLWithString:destination] fromServer:newServer];
        NSLog(@"downloading success:%@", success?@"YES":@"NO");
//    });
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
    NSString *urlString = kDocumentsFtpRootUrl;
    FMServer *server = [FMServer serverWithDestination:urlString username:kDefaultUserFtpUName password:kDefaultUserFtpPswd];
    server.port = 21;
    NSInteger number = 0;
    double downLoadSize = 0.0;
    
    if([_ftpManager checkLogin:server]){
        NSLog(@"!!\ncheck login Success!\n");
        NSArray *contentsOfServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
        NSString *currentFilePath = kSettingsLocalBasePath;
        [self creatDirectoryAtPath:currentFilePath];
        
        for(int i=0;i<contentsOfServer.count;i++){
            NSDictionary *resource = [[NSDictionary alloc] initWithDictionary:[contentsOfServer objectAtIndex:i]];
            if(i==0){NSLog(@"resorceKeys:%@ values:%@", resource.allKeys, resource.allValues);}
            
            NSString *fileName = resource[(id)kCFFTPResourceName];
            NSInteger fileType = [resource[(id)kCFFTPResourceType] intValue];
            if(![fileName isEqualToString:@"."] && ! [fileName isEqualToString:@".."]){
                NSString *newLocalPath = currentFilePath;
                NSString *newUrlString = [NSString stringWithFormat:@"%@/%@/", urlString, fileName];
                if(fileType==FTPResourceDirectory){
                    newLocalPath = [NSString stringWithFormat:@"%@/%@/", newLocalPath, fileName];
                    [self creatDirectoryAtPath:newLocalPath];
                    server = [FMServer serverWithDestination:newUrlString username:kDefaultUserFtpUName password:kDefaultUserFtpPswd];
                    server.port = 21;
                    
                    NSArray *contentsOfNewServer = [[NSArray alloc] initWithArray:[_ftpManager contentsOfServer:server]];
                    for(int j=0; j<contentsOfNewServer.count; j++){
                        NSDictionary *theResource = [[NSDictionary alloc] initWithDictionary:[contentsOfNewServer objectAtIndex:j]];
                        NSString *theFileName = theResource[(id)kCFFTPResourceName];
                        NSInteger theFileType = [theResource[(id)kCFFTPResourceType] intValue];
                        
                        if(![theFileName isEqualToString:@"."] && ![theFileName isEqualToString:@".."]){
                            if(theFileType == FTPResourceDocument){
                                NSDate *fileModDate = theResource[(id)kCFFTPResourceModDate];
                                NSDate *lastUpdateDate = [_settings lastModifiedForDocument:theFileName];
                                NSLog(@"last updateDate:%@ fileModDate:%@",lastUpdateDate ,fileModDate);
                                // first date eallier as the second one
                                if([lastUpdateDate compare:fileModDate]==NSOrderedAscending){
                                    NSLog(@"file:%@ added to download!", theFileName);
                                    double theSize = [theResource[(id)kCFFTPResourceSize] doubleValue];
                                    downLoadSize += theSize;
                                    number++;
                                }
                            }
                        }
                    }
                }
                else if(fileType==FTPResourceDocument){
                    NSDate *fileModDate = resource[(id)kCFFTPResourceModDate];
                    NSDate *lastUpdateDate = [_settings lastModifiedForDocument:fileName];
                    NSLog(@"last updateDate:%@ fileModDate:%@",lastUpdateDate ,fileModDate);
                    // first date eallier as the second one
                    if([lastUpdateDate compare:fileModDate]==NSOrderedAscending){
                        NSLog(@"file:%@ added to download", fileName);
                        double theSize = [resource[(id)kCFFTPResourceSize] doubleValue];
                        downLoadSize += theSize;
                        number++;
                    }
                }
            }
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
//        NSLog(@"%s info:%@, %@", __PRETTY_FUNCTION__, processInfo.allKeys, processInfo.allValues);
    }
    if(progress==1.0){
        _fileNumber--;
        if(_fileNumber==0){
            NSLog(@"download done successfully!");
            for(NSString *file in _downloadingFiles){
                [_settings setLastModifiedDate:[NSDate date] forDocument:file];
            }
        }
    }
}


@end
