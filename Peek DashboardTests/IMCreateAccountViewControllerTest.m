//
//  IMCreateAccountViewControllerTest.m
//  Peek Dashboard
//
//  Created by Mac on 04/09/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "IMCreateAccountViewController.h"

@interface IMCreateAccountViewControllerTest : XCTestCase

@property (nonatomic) IMCreateAccountViewController *viewController;

@end

@interface IMCreateAccountViewController (Test)

- (BOOL)checkEmail:(NSString*)email;

@end

@implementation IMCreateAccountViewControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.viewController = [IMCreateAccountViewController new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCheckEmail
{
    NSString *enteredMail = @"nicolas.demogue@gmail.com";
    BOOL result = [self.viewController checkEmail:enteredMail];
    XCTAssertEqual(result, YES, @"Invalid mail form");
    
    enteredMail = @"nicolas.demoguegmail.com";
    result = [self.viewController checkEmail:enteredMail];
    XCTAssertEqual(result, NO, @"Invalid mail form");
    
    enteredMail = @"nicolas.demogue@gmailcom";
    result = [self.viewController checkEmail:enteredMail];
    XCTAssertEqual(result, NO, @"Invalid mail form");
    
    enteredMail = @"";
    result = [self.viewController checkEmail:enteredMail];
    XCTAssertEqual(result, NO, @"Invalid mail form");
    
    enteredMail = nil;
    result = [self.viewController checkEmail:enteredMail];
    XCTAssertEqual(result, NO, @"Invalid mail form");
}

@end
