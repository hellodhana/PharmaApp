//
//  BrandPerfDO.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandPerfDO.h"

@implementation BrandPerfDO
@synthesize brandDO=_brandDO;
@synthesize performance=_performance;
@synthesize revenue=_revenue;
@synthesize health=_health;
@synthesize execution=_execution;
@synthesize socialPos=_socialPos;
@synthesize alert=_alert;

-(id)initWithBrand:(BrandDO *)brandDO performance:(NSNumber *)perf
           revenue:(NSNumber *)revenue health:(NSNumber *)health execution:(NSNumber *)execution socialPos:(NSNumber *)socialPos andAlert:(NSNumber *)alert;
{
    self = [super init];
    if(self)
    {
        self.brandDO = brandDO;
        self.performance = perf;
        self.revenue = revenue;
        self.health = health;
        self.execution = execution;
        self.socialPos = socialPos;
        self.alert = alert;
    }
    
    return self;
}
@end
