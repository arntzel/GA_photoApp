//
//  ViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "BFAWSManager.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

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
    
    _photoFeed = [[NSMutableArray alloc]init];
    _s3Files = [[NSMutableArray alloc]init];
}

- (IBAction)pressedGetPhotos:(UIButton *)sender {
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-242-42-235.compute-1.amazonaws.com:3000/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    [httpClient setDefaultHeader:@"Accept" value:@"application/json"];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [httpClient getPath:@"/photo" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON){
        //NSLog(@"success getting photos %@",JSON);
        [self parseJSON:JSON];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
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
    
    NSData *uploadedData = UIImageJPEGRepresentation(filteredImage, 0.6f);
    
    CFUUIDRef UUIDRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUIDStRef = CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
    NSString *uuid = [NSString stringWithFormat:@"1-%@",UUIDStRef];
    NSLog(@"my uuid is %@",uuid);
    [self uploadPhotoWithFilename:uuid];
    [BFAWSManager uploadFileWithData:uploadedData named:uuid];
    
    NSLog(@"this is my photo feed: %@",_photoFeed);


    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
}

#pragma mark - Photo Effects


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

#pragma mark Networking

-(void)uploadPhotoWithFilename:(NSString *)filename{
    NSURL *url = [NSURL URLWithString:@"http://ec2-54-242-42-235.compute-1.amazonaws.com:3000/"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:filename,@"s3_name", nil];
    [httpClient postPath:@"photo/create" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"success");
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"failure %@", error);
    }];
}


-(void)parseJSON:(NSArray *)json{
    int count = json.count;
    
    for (int x = 0; x < count; x++) {
        NSDictionary *firstDictionary = [[NSDictionary alloc]init];
        firstDictionary = json[x];
        NSLog(@"****first dictionary: %@",firstDictionary);
        NSDictionary *secondDictionary = [[NSDictionary alloc]init];
        secondDictionary = firstDictionary[@"photo"];
        NSLog(@"second dictionary: %@",secondDictionary);
        NSString *photoName = secondDictionary[@"s3_name"]
        ;
        NSLog(@"photo name: %@",photoName);
        [_s3Files addObject:photoName];
        NSLog(@"final array is %@",_s3Files);
    }
}

@end
