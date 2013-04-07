//
//  ProfileViewController.m
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"userFirstName"];
    NSString *biography = [defaults objectForKey:@"userBiography"];

    _nameLabel.text = firstName;
    _biography.text = biography;
    
    NSArray *users = [User findAll];
    for (int x = 0; x < users.count; x ++){
        User *user = [users objectAtIndex:x];
        if ([user.email isEqualToString:[defaults objectForKey:@"userEmail" ]]){
        _profileImage.image = user.profileImage;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
