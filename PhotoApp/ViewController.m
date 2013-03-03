//
//  ViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
//    CIContext *context;
//    CIFilter *filter;
//    CIImage *beginImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"view %@", self.view);
    
    _titleLabel.textColor = [UIColor blackColor];
    _numberOfTimesButtonPressed = 0;
    _textField.delegate = self;
    
    _photoFeed = [[NSMutableArray alloc]init];
    
    
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
    
    //_imageView.image = originalImage;
    
    UIImage *filteredImage = [self effects:originalImage];
    [_photoFeed insertObject:filteredImage atIndex:0];
    _imageView.image = filteredImage;
    
    NSLog(@"this is my photo feed: %@",_photoFeed);


    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}

#pragma mark - Photo Effects

/*
 
 Create a CIImage object. CIImage has the following initialization methods: imageWithURL, imageWithData, imageWithCVPixelBuffer, and imageWithBitmapData:bytesPerRow:size:format:colorSpace. You’ll most likely be working with imageWithURL most of the time.
 Create a CIContext. A CIContext can be CPU or GPU based.
 Create a CIFilter. When you create the filter, you configure a number of properties on it, that depend on the filter you’re using.
 Get the filter output. The filter gives you an output image as a CIImage – you can convert this to a UIImage using the CIContext, as you’ll see below.
 */

//CIImage. This class hold the image data. It can be creating from a UIImage, from an image file, or from pixel data.


//CIContext. All of the processing of a core image is done in a CIContext. This is somewhat similar to a Core Graphics or OpenGL context.


//CIFilter. The filter class has a dictionary that defines the attributes of the particular filter that it represents. Examples of filters are vibrance filters, color inversion filters, cropping filters, and much more.

//CIVignette - Reduces the brightness of an image at the periphery.
//CIUnsharpMask - Increases the contrast of the edges between pixels of different colors in an image.
//CIStraightenFilter - Rotates the source image by the specified angle in radians.
//CISepiaTone - Maps the colors of an image to various shades of brown.
//import the coreimage framework
-(UIImage *)effects:(UIImage *)photoImage {
    
    NSLog(@"%@",photoImage);
    CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(photoImage)];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CIVignette"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", [NSNumber numberWithFloat:0.2], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    photoImage = [UIImage imageWithCGImage:cgimg];
    
    return photoImage;
}

#pragma mark Transitions

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    TableViewController *tableView = [segue destinationViewController];
    tableView.photoArray = _photoFeed;
}

@end
