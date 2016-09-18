//
//  ViewController.m
//  Peek Dashboard
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import "IMLoaderViewController.h"

#import "IMClientServer.h"

@interface IMLoaderViewController () < UITextFieldDelegate, IMClientServerDelegate >

@property (nonatomic, weak) IBOutlet UITextField    *userNameTextField;
@property (nonatomic, weak) IBOutlet UITextField    *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton       *loginButton;
@property (nonatomic, weak) IBOutlet UIButton       *createAccountButton;

- (IBAction)loginButton:(id)sender;
- (IBAction)createAccountButton:(id)sender;

@end
 
@implementation IMLoaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _loginButton.layer.cornerRadius = 15.f;
    _loginButton.layer.borderColor  = [UIColor redColor].CGColor;
    _loginButton.layer.borderWidth  = 1.f;    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----- BUTTON ACTION -----
- (IBAction)loginButton:(id)sender
{
    IMClientServer *client = [IMClientServer new];
    [client setDelegate:self];
    NSDictionary *params = @{@"username"   : _userNameTextField.text,
                             @"password"  : _passwordTextField.text
                             };
    
    [client tryToLogin:params];
}

- (IBAction)createAccountButton:(id)sender
{
    [self performSegueWithIdentifier:@"loader-createaccount-segue" sender:self];
}

#pragma mark ----- CLIENTSERVER DELEGATE -----
- (void)loggedToServer:(IMClientServer *)IMClientServer
{
    [self performSegueWithIdentifier:@"loader-main-segue" sender:self];
}

- (void)loggedError:(IMClientServer *)IMClientServer error:(NSString *)error
{
    
}

@end
