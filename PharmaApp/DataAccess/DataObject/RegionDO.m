//
//  RegionDO.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 07/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegionDO.h"

@implementation RegionDO
@synthesize region=_region;
@synthesize regionTxt=_regionTxt;
@synthesize hierarchy=_hierarchy;
@synthesize parent=_parent;
   
-(id)initWithRegion:(NSString *)region regionDesc:(NSString *)regionDesc
          hierarchy:(NSNumber *)hierarchy parent:(NSString *)parent;
{
    self = [super init];
    if(self)
    {
        self.region = region;
        self.regionTxt = regionDesc;
        self.hierarchy = hierarchy;
        self.parent = parent;
    }    
    return self;
}
@end
