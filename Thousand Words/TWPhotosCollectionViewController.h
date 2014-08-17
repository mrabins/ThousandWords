//
//  TWPhotosCollectionViewController.h
//  Thousand Words
//
//  Created by Mark Rabins on 7/25/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"


@interface TWPhotosCollectionViewController : UICollectionViewController

@property (strong, nonatomic) Album *album;

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
