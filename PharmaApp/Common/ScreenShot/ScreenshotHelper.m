//
//  ScreenshotHelper.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 18/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScreenshotHelper.h"
#import "SFAUtils.h"

#define SCREENSHOT_DIRECTORY @"Screenshots"

static ScreenshotHelper *sharedInstance = nil;

@implementation ScreenshotHelper

+ (id)sharedInstance
{
    @synchronized(self) 
    {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


-(void) refreshStorage
{
    if([SFAUtils directoryExistsAtAbsolutePath:SCREENSHOT_DIRECTORY])
    {
        
    }
}

-(void) writeImagetoStore:(UIImage *)image
{
    return;
}

-(void) writeImagetoStore:(UIImage *)image fileName:(NSString *)fileName
{
    return;
}

-(NSArray *)readImageStore
{
    return nil;
}
@end
