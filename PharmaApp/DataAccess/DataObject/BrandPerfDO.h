//
//  BrandPerfDO.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandDO.h"

@interface BrandPerfDO : NSObject
{
    BrandDO *_brandDO;
    NSNumber *_alert;
    NSNumber *_performance;
    NSNumber *_revenue;
    NSNumber *_health;
    NSNumber *_execution;
    NSNumber *_socialPos;
}

@property(nonatomic, retain) BrandDO *brandDO;
@property(nonatomic, retain) NSNumber *alert;
@property(nonatomic, retain) NSNumber *performance;
@property(nonatomic, retain) NSNumber *revenue;
@property(nonatomic, retain) NSNumber *health;
@property(nonatomic, retain) NSNumber *execution;
@property(nonatomic, retain) NSNumber *socialPos;

-(id)initWithBrand:(BrandDO *)brandDO performance:(NSNumber *)perf
             revenue:(NSNumber *)revenue health:(NSNumber *)health execution:(NSNumber *)execution socialPos:(NSNumber *)socialPos andAlert:(NSNumber *)alert;
@end
