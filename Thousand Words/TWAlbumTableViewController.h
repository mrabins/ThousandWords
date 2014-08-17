//
//  TWAlbumTableViewController.h
//  Thousand Words
//
//  Created by Mark Rabins on 7/23/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAlbumTableViewController : UITableViewController 

@property (strong, nonatomic) NSMutableArray *albums;

- (IBAction)addAlbumBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
