//
//  ViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 3/2/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
<UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>



//properties
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) int numberOfTimesButtonPressed;

@property (strong, nonatomic) NSMutableArray *photoFeed;
@property (strong, nonatomic) NSMutableArray *s3Files;


//methods
- (IBAction)takePhotoPressed:(UIButton *)sender;





@end
