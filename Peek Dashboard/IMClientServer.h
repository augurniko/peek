//
//  IMClientServer.h
//  Peek Dashboard
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//
 
#import <Foundation/Foundation.h>
#import "IMManager.h"

@class IMClientServer;

// define the protocol for the delegate
@protocol IMClientServerDelegate

// Delegate account
- (void)accountCreated:(IMClientServer*)IMClientServer;
- (void)accountError:(IMClientServer*)IMClientServer error:(NSString*)error;
// Delegate login
- (void)loggedToServer:(IMClientServer*)IMClientServer;
- (void)loggedError:(IMClientServer*)IMClientServer error:(NSString*)error;

@end

@interface IMClientServer : NSObject

@property (nonatomic, weak)    id                   delegate;

- (id)init;

- (void)tryToLogin:(NSDictionary*)params;
- (void)registeredNewOwner:(NSDictionary*)user;

// Delegate
- (void)setDelegate:(id)delegate;

@end
