//
//  ViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"view %@", self.view);
    
    _titleLabel.textColor = [UIColor blackColor];
    _numberOfTimesButtonPressed = 0;
    _textField.delegate = self;
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 100, 50)];
    myLabel.text = @"custom label";
    myLabel.textColor = [UIColor greenColor];
    [self.view addSubview:myLabel];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    _titleLabel.text = _textField.text;
    _numberOfTimesButtonPressed = _numberOfTimesButtonPressed +1;
    
    if (_numberOfTimesButtonPressed%2 == 0){
        _titleLabel.textColor =
        [UIColor greenColor];
    }
    else{
        _titleLabel.textColor =
        [UIColor blackColor];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_textField resignFirstResponder];
    
    return YES;
}

- (IBAction)takePhotoPressed:(UIButton *)sender {
    
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

#pragma mark - UIPickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = originalImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}
@end
