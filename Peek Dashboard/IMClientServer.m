//
//  IMClientServer.m
//  Peek Dashboard
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import "IMClientServer.h"

@implementation IMClientServer

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
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

/* LOGIN WITH NAME/PASSWORD */
- (void)tryToLogin:(NSDictionary*)params
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",
                           URL_ISLANDMEDIAPLUS,
                           @"tryToLogin.php"];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    [manager GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSString *success = [responseObject objectAtIndex:0];
            if ([success isEqualToString:@"Good"])
            {
                NSLog(@"Logged!");
                [_delegate loggedToServer:self];
            }
            else
            {
                NSLog(@"Error login!");
                [_delegate loggedError:self error:[responseObject objectAtIndex:1]];
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_delegate loggedError:self error:@"Unknow error"];
    }];
}


/* REGISTERED NEW OWNER */
- (void)registeredNewOwner:(NSDictionary*)user
{
    __block NSString *result = nil;
    
    NSDictionary *params = @{@"firstname"   : [user objectForKey:@"firstname"],
                             @"familyname"  : [user objectForKey:@"familyname"],
                             @"push"        : @"HGdd121fre654gr132fg16d8gfd1gd3f2g165f4ddf1",
                             @"email"       : [user objectForKey:@"email"],
                             @"password"    : [user objectForKey:@"password" ],
                             @"phone"       : [user objectForKey:@"phone"]
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",
                           URL_ISLANDMEDIAPLUS,
                           @"registerNewUser.php"];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
    
    [manager POST:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionTask *task, id _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]])
        {
            NSString *success = [responseObject objectAtIndex:0];
            if ([success isEqualToString:@"Good"])
            {
                result = @"Account created";
                [_delegate accountCreated:self];
            }
            else
            {
                result = @"Account already exist";
                [_delegate accountError:self error:result];
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_delegate accountError:self error:@"Error when creating account !\nTry again later"];
    }];
}

@end
