//
//  TWPhotoCollectionViewCell.m
//  Thousand Words
//
//  Created by Mark Rabins on 7/25/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "TWPhotoCollectionViewCell.h"
#define IMAGE_BORDER_LENGTH 5


@implementation TWPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, IMAGE_BORDER_LENGTH, IMAGE_BORDER_LENGTH)];
    [self.contentView addSubview:self.imageView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
