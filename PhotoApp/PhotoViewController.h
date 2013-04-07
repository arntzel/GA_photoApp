//
//  ViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserPhoto.h"

@interface PhotoViewController : UIViewController
<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>



//properties
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *tagTextField;

//methods
- (IBAction)takePhotoPressed:(UIButton *)sender;

- (IBAction)addFilterButtonPressed:(UIButton *)sender;

- (IBAction)saveButtonPressed:(UIButton *)sender;



@end
