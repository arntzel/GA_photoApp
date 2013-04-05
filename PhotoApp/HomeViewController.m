//
//  HomeViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//unset the current user here and dismiss the view
- (IBAction)logOutPressed:(UIBarButtonItem *)sender {
    
    //dismisses the top frame on the view stack.
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cameraButtonPressed:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"photoSegue" sender:nil];
    
}

- (IBAction)profileButtonPressed:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@" sender:<#(id)#>]
    
}
@end
