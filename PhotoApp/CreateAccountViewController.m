//
//  CreateAccountViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController

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
    
    _firstNameTextField.delegate = self;
    _lastNameTextField.delegate = self;
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    _confirmPasswordTextField.delegate = self;
    _greetingTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createBarButtonPressed:(UIBarButtonItem *)sender {
    
    if ([_firstNameTextField.text isEqualToString:@""] || [_lastNameTextField.text isEqualToString:@""] || [_emailTextField.text isEqualToString:@""] ||[_passwordTextField.text isEqualToString:@""] || [_confirmPasswordTextField.text isEqualToString:@""] || [_greetingTextField.text isEqualToString:@""] || _profileImageView.image == nil){
        
        NSLog(@"profileImage is nil");
                
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in all required fields before continuing." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else if([_passwordTextField.text isEqualToString:_confirmPasswordTextField.text]){
        
        [self.navigationController popViewControllerAnimated:YES];

        
        User *user = [User createEntity];
        
        user.firstName = _firstNameTextField.text;
        user.lastName = _lastNameTextField.text;
        user.email = _emailTextField.text;
        user.password = _passwordTextField.text;
        user.biography = _greetingTextField.text;
        user.profileImage = _profileImageView.image;
        
        [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Congradulations your account has been created." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords do not match.  Please reenter the password and confirmation." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (IBAction)chooseProfileImage:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    //Logic if camera is avaliable.
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"there is a camera!");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        NSLog(@"Apple why do you make me pay to use my camera?!");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - TextField Delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textFIeldShouldReturn");
    [_firstNameTextField resignFirstResponder];
    [_lastNameTextField resignFirstResponder];
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_confirmPasswordTextField resignFirstResponder];
    [_greetingTextField resignFirstResponder];

    
    return YES;
}
#pragma mark - UIPickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    _profileImageView.image = originalImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
