//
//  SignInViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

#pragma mark - View Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods

- (IBAction)createAccountPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"createAccountSegue" sender:nil];
}

- (IBAction)SigninButtonPressed:(UIButton *)sender {

    [self performSegueWithIdentifier:@"signInSegue" sender:nil];

}

#pragma mark - TextField Delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFIeldShouldReturn");
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    return YES;
}

@end
