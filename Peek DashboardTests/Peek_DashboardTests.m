//
//  Peek_DashboardTests.m
//  Peek DashboardTests
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IMLoaderViewController.h"
#import "AppDelegate.h"

@interface Peek_DashboardTests : XCTestCase

@property (nonatomic, weak) IMLoaderViewController *viewController;

@end

@implementation Peek_DashboardTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate = [application delegate];
    UIWindow *window = [appDelegate window];
    self.viewController = (IMLoaderViewController*)[window rootViewController];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIMLoaderViewControllerIsNotNil {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    XCAssertNotNil(self.viewController, @"ViewController is not set");
    XCTAssertNotNil(self.viewController, @"ViewController is not set");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
