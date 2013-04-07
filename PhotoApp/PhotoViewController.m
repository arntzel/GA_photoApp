//
//  ViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (IBAction)addFilterButtonPressed:(UIButton *)sender {
    
    [self effects:_imageView.image];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    UserPhoto *userPhoto = [UserPhoto createEntity];
    userPhoto.tag = _tagTextField.text;
    userPhoto.photo = _imageView.image;
    
    NSArray *users = [User findAll];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (int x = 0; x < users.count; x ++){
        User *user = [users objectAtIndex:x];
        if ([user.email isEqualToString:[defaults objectForKey:@"userEmail"]]){
            [user addPhotosObject:userPhoto];
            [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
            NSSet *setPhotos = user.photos;
            NSLog(@"%@", setPhotos);
            
            NSArray *photo = [NSArray arrayWithArray:[setPhotos allObjects]];
            NSLog(@"%@", photo);

        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    return YES;
}

#pragma mark - UIPickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    _imageView.image = originalImage;

    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Photo Effects


-(void)effects:(UIImage *)photoImage {
    
    CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(photoImage)];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    photoImage = [UIImage imageWithCGImage:cgimg];

    _imageView.image = photoImage;
    
}

@end
