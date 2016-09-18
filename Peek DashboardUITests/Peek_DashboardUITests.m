//
//  Peek_DashboardUITests.m
//  Peek DashboardUITests
//
//  Created by Mac on 04/09/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Peek_DashboardUITests : XCTestCase

@end

@implementation Peek_DashboardUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Create account"] tap];
    
    XCUIElement *firstNameTextField = app.textFields[@"First name"];
    
    [firstNameTextField tap];
    
    XCTAssertEqualObjects(firstNameTextField.value, @"", @"firstNameTextField value must to be empty");
    [firstNameTextField typeText:@"Nicolas"];
    XCTAssertEqualObjects(firstNameTextField.value, @"Nicolas", @"firstNameTextField value must to be Nicolas");
    
    XCUIElement *familyNameTextField = app.textFields[@"Family name"];
    [familyNameTextField tap];
 //   [familyNameTextField typeText:@"Demogue"];
    
    XCUIElement *eMailTextField = app.textFields[@"E-mail"];
    [eMailTextField tap];
    [eMailTextField typeText:@"augur.niko@gmail.com"];
    
    XCUIElement *passwordTextField = app.secureTextFields[@"Password"];
    [passwordTextField tap];
    [passwordTextField typeText:@"54fp0a00"];
    
    XCUIElement *confirmPasswordTextField = app.secureTextFields[@"Confirm password"];
    [confirmPasswordTextField tap];
    [confirmPasswordTextField typeText:@"54fp0a00"];

    XCUIElement *phoneTextField = app.textFields[@"Phone"];
    [phoneTextField tap];
    [phoneTextField typeText:@"0888936532"];

    [app.buttons[@"Register"] tap];
    
}

@end
