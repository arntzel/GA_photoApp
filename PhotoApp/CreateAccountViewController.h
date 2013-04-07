//
//  CreateAccountViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CreateAccountViewController : UIViewController <UITextFieldDelegate,UIAlertViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *greetingTextField;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

- (IBAction)createBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)chooseProfileImage:(UIButton *)sender;

@end
