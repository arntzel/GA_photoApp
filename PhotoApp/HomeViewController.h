//
//  HomeViewController.h
//  PhotoApp
//
//  Created by Eliot Arntz on 4/5/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *photoStreamTableView;

- (IBAction)logOutPressed:(UIBarButtonItem *)sender;
- (IBAction)cameraButtonPressed:(UIButton *)sender;
- (IBAction)profileButtonPressed:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
