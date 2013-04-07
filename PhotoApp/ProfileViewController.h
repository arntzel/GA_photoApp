//
//  ProfileViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *biography;



@end
