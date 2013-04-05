//
//  HomeViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *photoStreamTableView;

- (IBAction)logOutPressed:(UIBarButtonItem *)sender;
- (IBAction)cameraButtonPressed:(UIButton *)sender;
- (IBAction)profileButtonPressed:(UIButton *)sender;

@end
