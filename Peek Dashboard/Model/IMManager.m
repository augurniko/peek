//
//  IMClientServer.m
//  Peek Dashboard
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//
 
#import "IMManager.h"
#import "KeychainWrapper.h"

@implementation IMManager

+ (id)sharedClient
{
    static IMManager *sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    
    return sharedClient;
}

#pragma mark ------ LOGIN TEST ------
/* CHECK LOGIN/LOGOUT */
- (BOOL)checkLoginLogout
{
    KeychainWrapper* keychain = [KeychainWrapper new];
    NSString *userName = [keychain myObjectForKey:(__bridge id)kSecAttrAccount];
    NSString *password = [keychain myObjectForKey:(__bridge id)kSecValueData];
    
    if ((userName != nil) && (![userName isEqualToString:@""]) &&
        (password != nil) && (![password isEqualToString:@""]))
        return YES;
    else
        return NO;
}

/* SAVE USERNAME / PASSWORD */
- (void)saveUserNamePassword:(NSString*)username pass:(NSString*)pass
{
    KeychainWrapper* keychain = [KeychainWrapper new];
    [keychain mySetObject:username  forKey:(__bridge id)kSecAttrAccount];
    [keychain mySetObject:pass      forKey:(__bridge id)kSecValueData];
    [keychain writeToKeychain];
}

/* RESET USERNAME / PASSWORD */
- (void)resetUserNamePassword
{
    KeychainWrapper* keychain = [KeychainWrapper new];
    [keychain mySetObject:@"" forKey:(__bridge id)kSecAttrAccount];
    [keychain mySetObject:@"" forKey:(__bridge id)kSecValueData];
    [keychain writeToKeychain];
}

#pragma mark ------ ONLINE FUNCTIONS ------
/* CHECK INTERNET CONNEXION */
- (void)reachability {
    
    __block BOOL haveInternetConnection     = NO;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                haveInternetConnection = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                haveInternetConnection = NO;
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
