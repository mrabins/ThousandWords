//
//  TWCoreDataHelper.m
//  Thousand Words
//
//  Created by Mark Rabins on 7/25/14.
//  Copyright (c) 2014 edu.self.edu. All rights reserved.
//

#import "TWCoreDataHelper.h"

@implementation TWCoreDataHelper

+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
