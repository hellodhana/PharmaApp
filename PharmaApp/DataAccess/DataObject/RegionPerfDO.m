//
//  RegionPerfDO.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegionPerfDO.h"

@implementation RegionPerfDO
@synthesize region=_region;
@synthesize perfPer=_perfPer;
@synthesize revenue=_revenue;
@synthesize execution=_execution;
@synthesize alert=_alert;

-(id)initWithRegion:(RegionDO *)region performance:(NSNumber *)perfPer andRevenue:(NSNumber *) revenue andExecution:(NSNumber *)execution andAlert:(NSNumber *)alert;
{
    self = [super init];
    if(self)
    {
        self.region = region;
        self.alert = alert;
        self.perfPer = perfPer;
        self.revenue = revenue;
        self.execution = execution;
    }
    return self;
}

@end
