//
//  UserPhoto.h
//  PhotoApp
//
//  Created by Eliot Arntz on 4/7/13.
//  Copyright (c) 2013 EliotArntz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserPhoto : NSManagedObject

@property (nonatomic, retain) id photo;
@property (nonatomic, retain) NSString * tag;

@end
