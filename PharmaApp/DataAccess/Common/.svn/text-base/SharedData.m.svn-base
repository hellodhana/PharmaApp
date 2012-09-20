//
//  SharedData.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SharedData.h"

static SharedData *sharedObj = nil;

@implementation SharedData
@synthesize brand=_brand;
@synthesize region=_region;
@synthesize district=_district;
@synthesize territory=_territory;
@synthesize hierarchy=_hierarchy;
@synthesize period=_period;
@synthesize perfData=_perfData;
@synthesize RegionData=_RegionData;
@synthesize PerformancebuttonTag=_PerformancebuttonTag;
@synthesize showToolbar=_showToolbar;

@synthesize doTime=_doTime;
@synthesize doRegion=_doRegion;
@synthesize doBrand=_doBrand;

+ (id)sharedObj {
    @synchronized(self) 
    {
        if (sharedObj == nil)
            sharedObj = [[self alloc] init];
    }
    return sharedObj;
}

-(void) setRegion:(NSString *)region
{
    self.region = region;
    self.district = nil;
    self.territory = nil;
}

-(void) setDistrict:(NSString *)district
{
    self.district = district;
    self.territory = nil;    
}
@end
