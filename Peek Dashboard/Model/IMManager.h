//
//  IMClientServer.h
//  Peek Dashboard
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <CoreData/CoreData.h>
#import "IMConstants.h"

@interface IMManager : NSObject

+ (IMManager*)sharedClient;

- (void)reachability;
- (BOOL)checkLoginLogout;

@end
