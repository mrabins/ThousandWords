//
//  TWPhotoDetailViewController.h
//  Thousand Words
//
//  Created by Mark Rabins on 7/28/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface TWPhotoDetailViewController : UIViewController

@property (strong,nonatomic) Photo *photo;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;




@end
