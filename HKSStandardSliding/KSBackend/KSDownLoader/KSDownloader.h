//
//  KSDocumentsDownloader.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPManager.h"
#import "KSLocalizedKeys.h"
#import "sys/dirent.h"

typedef enum{
    FTPResourceDirectory = 4,
    FTPResourceDocument = 8
}FTPResourceTypes;

@class KSDownloader;

@protocol KSDownloaderDelegate <NSObject>
- (void)KSDownloader:(KSDownloader*)downloader progressDidChange:(NSDictionary *)processInfo;
@end

@interface KSDownloader : NSObject <FTPManagerDelegate>

@property (nonatomic, assign) float progress;
@property (nonatomic, copy) void (^progressCallback) (float);
@property (nonatomic, weak) id <KSDownloaderDelegate> delegate;
@property (nonatomic, assign) double downLoadSize;
@property (nonatomic, assign) NSInteger fileNumber;

+ (instancetype)newDownLoader;
- (void)updateFileNamesAndSize;
- (void)checkAndStartDownLoader;
- (void)startNewDownLoadWithFileName:(NSString*)fileName url:(NSString*)url andDestination:(NSString*)destination;

@end
