//
//  HKSDefinitions.h
//  HKSStandardSliding
//
//  Created by Ke Song on 02.12.14.
//  Copyright (c) 2014 Ke Song. All rights reserved.
//

#ifndef HKSStandardSliding_HKSDefinitions_h
#define HKSStandardSliding_HKSDefinitions_h
#endif

//  Server definitions


#define kDefaultUserFtpServer   @"ftp://server2.cvbnm.de/"
#define kDefaultUserFtpUName    @"kesong"
#define kDefaultUserFtpPswd     @"hakes0ng"
#define kDocumentsFtpSyncId     @"hakesongslidingapp20141203"
#define kDocumentsFtpRootUrl    [NSString stringWithFormat:@"%@tmp/%@",kDefaultUserFtpServer ,kDocumentsFtpSyncId]
#define kDefaultIdVendor        [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//Local saved path
#define kFtpDocumentsPath                    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent: @"ViewsSettings/"]


#define HKSNaviLeftMenueIdentifier                          @"HKSLeftMenueViewNavigationController"
#define HKSNaviStartViewIdentifier                          @"HKSStartNavigationController"
#define HKSNaviTableViewIdentifier                          @"HKSTableViewNavigationController"
#define HKSNaviCollectionViewIdentifier                     @"HKSCollectionNavigationController"
#define HKSNaviWebViewIdentifier                            @"HKSWebViewNavigationController"
#define HKSNaviEmptyViewIdentifier                          @"HKSEmptyViewNavigationController"

#define HKSTableViewIdentifier                              @"HKSTableViewController"
#define HKSCollectionViewIdentifier                         @"HKSCollectionViewController"
#define HKSWebViewIdentifier                                @"HKSWebViewController"


