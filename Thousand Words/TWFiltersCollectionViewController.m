//
//  TWFiltersCollectionViewController.m
//  Thousand Words
//
//  Created by Mark Rabins on 7/29/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "TWFiltersCollectionViewController.h"
#import "TWPhotoCollectionViewCell.h"
#import "Photo.h"

@interface TWFiltersCollectionViewController ()

@property (strong,nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) CIContext *context;

@end

@implementation TWFiltersCollectionViewController

-(NSMutableArray *)filters
{
    if (!_filters) _filters = [[NSMutableArray alloc] init];
    
    return _filters;
}

-(CIContext *)context
{
    if (!_context) _context = [CIContext contextWithOptions:nil];
    
    return _context;
}

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
    
    self.filters = [[[self class] photoFilters] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Filters

+ (NSArray *)photoFilters
{
    CIFilter *blendMode = [CIFilter filterWithName:@"CILightenBlendMode" keysAndValues:nil];
    CIFilter *lightTunnel = [CIFilter filterWithName:@"CILightTunnel" keysAndValues:nil];
    CIFilter *bloom = [CIFilter filterWithName:@"CIBloom" keysAndValues:nil];
    CIFilter *lineScreen = [CIFilter filterWithName:@"CILineScreen" keysAndValues:nil];
    CIFilter *muliBlendMode = [CIFilter filterWithName:@"CIMultiplyBlendMode" keysAndValues: nil];
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: nil];
    CIFilter *colorControl = [CIFilter filterWithName:@"CIColorControls" keysAndValues: kCIInputSaturationKey, @0.95, nil];
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues: nil];
    
    NSArray *allFilters = @[blendMode, lightTunnel, bloom, lineScreen, muliBlendMode, vignette, colorControl, transfer];
    
    return allFilters;
}

-(UIImage *)filteredImageFromImage:(UIImage *)image andFilter:(CIFilter *)filter
{
    CIImage *unfilterImage = [[CIImage alloc] initWithCGImage:image.CGImage];
    [filter setValue:unfilterImage forKey:kCIInputImageKey];
    CIImage *filteredImage = [filter outputImage];
    
    CGRect extent = [filteredImage extent];
    
    CGImageRef cgImage = [self.context createCGImage:filteredImage fromRect:extent];
    
    UIImage *finalImage = [UIImage imageWithCGImage:cgImage];
    
    NSLog(@"Look at all of this data %@", UIImagePNGRepresentation(finalImage));
    
    return finalImage;
}

#pragma mark - UICollectionView DataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    
    TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    dispatch_queue_t filterQueue = dispatch_queue_create("filter queue", NULL);
    
    dispatch_async(filterQueue, ^{
        UIImage *filterImage = [self filteredImageFromImage:self.photo.image andFilter:self.filters[indexPath.row]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = filterImage;
        });
    });
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filters count];
}

#pragma mark - UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWPhotoCollectionViewCell *selectedCell = (TWPhotoCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    
    self.photo.image = selectedCell.imageView.image;
    
    if(self.photo.image){
        
    }
    
    NSError *error = nil;
    
    if(![[self.photo managedObjectContext] save:&error]){
        //Handel Error
        NSLog(@"%@", error);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
