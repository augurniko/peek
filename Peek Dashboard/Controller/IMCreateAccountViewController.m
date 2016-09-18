//
//  IMCreateAccountViewController.m
//  Peek Dashboard
//
//  Created by Mac on 20/07/2016.
//  Copyright © 2016 Nicolas Demogue. All rights reserved.
//

#import "IMCreateAccountViewController.h"

#import "IMClientServer.h"

@interface IMCreateAccountViewController () < UITextFieldDelegate, IMClientServerDelegate >

@property (nonatomic, weak) IBOutlet UITextField        *firstNameTextField;
@property (nonatomic, weak) IBOutlet UITextField        *familyNameTextField;
@property (nonatomic, weak) IBOutlet UITextField        *emailTextField;
@property (nonatomic, weak) IBOutlet UITextField        *passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField        *confirmPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField        *phoneTextField;

@property (nonatomic, weak) IBOutlet UIImageView        *firstNameImageView;
@property (nonatomic, weak) IBOutlet UIImageView        *familyNameImageView;
@property (nonatomic, weak) IBOutlet UIImageView        *emailImageView;
@property (nonatomic, weak) IBOutlet UIImageView        *passwordImageView;
@property (nonatomic, weak) IBOutlet UIImageView        *confirmPasswordImageView;
@property (nonatomic, weak) IBOutlet UIImageView        *phoneImageView;

@property (nonatomic, weak) IBOutlet UIButton           *registerButton;

@property (nonatomic, weak) IBOutlet UIView             *resultView;
@property (nonatomic, weak) IBOutlet UIImageView        *resultImageView;
@property (nonatomic, weak) IBOutlet UILabel            *resultLabel;

- (IBAction)registerButton:(id)sender;


@end

@implementation IMCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _registerButton.layer.cornerRadius = 15.f;
    _registerButton.layer.borderColor  = [UIColor redColor].CGColor;
    _registerButton.layer.borderWidth  = 1.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

#pragma mark ----- BUTTON ACTION -----
- (IBAction)registerButton:(id)sender
{
    BOOL canRegistered = YES;
    // First name check
    if ([_firstNameTextField.text isEqualToString:@""])
    {
        _firstNameImageView.image = [UIImage imageNamed:@"invalid.png"];
        canRegistered = NO;
    }
    else
    {
         _firstNameImageView.image = [UIImage imageNamed:@"valid.png"];
    }
    // Family name check
    if ([_familyNameTextField.text isEqualToString:@""])
    {
        _familyNameImageView.image = [UIImage imageNamed:@"invalid.png"];
        canRegistered = NO;
    }
    else
    {
        _familyNameImageView.image = [UIImage imageNamed:@"valid.png"];
    }
    // Email check
    if (([_emailTextField.text isEqualToString:@""]) || (![self checkEmail:_emailTextField.text]))
    {
        _emailImageView.image = [UIImage imageNamed:@"invalid.png"];
        canRegistered = NO;
    }
    else
    {
        _emailImageView.image = [UIImage imageNamed:@"valid.png"];
    }
    // Password check
    if ([_passwordTextField.text isEqualToString:@""])
    {
        _passwordImageView.image = [UIImage imageNamed:@"invalid.png"];
        canRegistered = NO;
    }
    else
    {
        _passwordImageView.image = [UIImage imageNamed:@"valid.png"];
    }
    // Confirm password check
    if ([_confirmPasswordTextField.text isEqualToString:@""])
    {
        _confirmPasswordImageView.image = [UIImage imageNamed:@"invalid.png"];
        canRegistered = NO;
    }
    else
    {
        // Confirm comparaison to password
        if (![_confirmPasswordTextField.text isEqualToString:_passwordTextField.text])
        {
            _confirmPasswordImageView.image = [UIImage imageNamed:@"invalid.png"];
            canRegistered = NO;
        }
        else
        {
            _confirmPasswordImageView.image = [UIImage imageNamed:@"valid.png"];
        }
    }
    // Phone check
    if ([_phoneTextField.text isEqualToString:@""])
    {
        _phoneImageView.image = [UIImage imageNamed:@"invalid.png"];
        canRegistered = NO;
    }
    else
    {
        _phoneImageView.image = [UIImage imageNamed:@"valid.png"];
    }
    
    if (canRegistered)
    {
        NSDictionary *params = @{@"firstname"   : _firstNameTextField.text,
                                 @"familyname"  : _familyNameTextField.text,
                                 @"email"       : _emailTextField.text,
                                 @"password"    : _passwordTextField.text,
                                 @"phone"       : _phoneTextField.text
                                 };
        
        IMClientServer *client = [IMClientServer new];
        [client setDelegate:self];
        [client registeredNewOwner:params];
    }
}

/* Check Email function */
- (BOOL)checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark    ---------- FADE IN ANIMATION ----------
-(void) fadeIn
{
    [self.resultView setAlpha:0];
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:TIMER_FADE_IN];
    [self.resultView setAlpha:1];
    [UIView commitAnimations];
}

#pragma mark    ---------- IGCLIENTSERVER DELEGATE -----------
- (void)accountCreated:(IMClientServer *)IMClientServer
{
    NSLog(@"account created");
    _resultImageView.image = [UIImage imageNamed:@"valid.png"];
    _resultLabel.text = @"Account created";
    [self fadeIn];
    
}

- (void)accountError:(IMClientServer *)IMClientServer error:(NSString *)error
{
    NSLog(@"%@",error);
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:error
                                                                        preferredStyle:UIAlertControllerStyleAlert                   ];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Close"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here, eg dismiss the alertwindow
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                             
                         }];

    [myAlertController addAction: ok];
    [self presentViewController:myAlertController animated:YES completion:nil];
}

@end
