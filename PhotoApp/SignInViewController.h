//
//  SignInViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface SignInViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) NSArray *users;
@property (nonatomic) BOOL signInSuccessful;



- (IBAction)createAccountPressed:(UIButton *)sender;
- (IBAction)SigninButtonPressed:(UIButton *)sender;


@end
