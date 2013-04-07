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
    
    _users = [User findAll];
    
}

-(void)viewDidAppear:(BOOL)animated{
    _users = [User findAll];
    NSLog(@"%@", _users);
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
        
    for (int x = 0; x < _users.count; x ++){
        User *user = [_users objectAtIndex:x];
        NSLog(@"%@ %@", user.email, user.password);
        
        if ([user.email isEqualToString: _userNameTextField.text] && [user.email isEqualToString: _userNameTextField.text]){
            _signInSuccessful = YES;
        }
    }
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:user.email forKey:@"userEmail"];
//            [defaults setObject:user.password forKey:@"userPassword"];
//            [defaults setObject:user.biography forKey:@"userBiography"];
//            [defaults setObject:user.firstName forKey:@"userFirstName"];
//            [defaults setObject:user.lastName forKey:@"userLastName"];
//        }
//    }
//
//    if (_signInSuccessful == YES){
//        [self performSegueWithIdentifier:@"signInSegue" sender:nil];
//    }
//    else{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please reenter your information or create an account." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    
    [self performSegueWithIdentifier:@"signInSegue" sender:nil];
}

#pragma mark - TextField Delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    return YES;
}

@end
