//
//  RegionBrandPerfDO.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegionBrandPerfDO.h"

@implementation RegionBrandPerfDO
@synthesize region=_region;
@synthesize regionTxt=_regionTxt;
@synthesize regionHier=_regionHier;
@synthesize regionCtr=_regionCtr;
@synthesize parent=_parent;
@synthesize brandPerfDO=_brandPerfDO;
@synthesize child=_child;

-(id)initWithRegion:(NSString *)region regionTxt:(NSString *)regionTxt hierarchy:(NSNumber *)regionHier regionCtr:(NSString *)regionCtr parent:(RegionBrandPerfDO *)parent brandPerf:(BrandPerfDO *)brandPerf andChild:(NSArray *)child;
{
    self = [super init];
    if(self)
    {
        self.region = region;
        self.regionTxt = regionTxt;
        self.regionHier = regionHier;
        self.regionCtr = regionCtr;
        self.parent = parent;
        self.brandPerfDO = brandPerf;
        self.child = child;
    }
                    
    return self;
}
@end
