//
//  ViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *mainButton;

- (IBAction)buttonPressed:(UIButton *)sender;
//properties
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) int numberOfTimesButtonPressed;

@property (strong, nonatomic) NSMutableArray *photoFeed;


//methods
- (IBAction)takePhotoPressed:(UIButton *)sender;





@end
