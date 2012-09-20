//
//  DOExecution.h
//  PharmaApp
//
//  Created by Deloitte-1 on 22/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DORegion.h"

@interface DOExecution : NSObject
{
    DORegion *_regionDO;
    NSNumber *_targetReached;
    NSNumber *_frequencyReached;
    NSNumber *_sampleAllocationReached;
    NSNumber *_financePerforminPer;
    NSNumber *_financePerformActual;
    NSNumber *f_inancePerformTarget;
}

@property(nonatomic, retain) DORegion *regionDO;

@property(nonatomic, retain) NSNumber *targetReached;
@property(nonatomic, retain) NSNumber *frequencyReached;
@property(nonatomic, retain) NSNumber *sampleAllocationReached;
@property(nonatomic,retain) NSNumber *financePerforminPer;
@property(nonatomic,retain) NSNumber *financePerformActual;
@property(nonatomic,retain) NSNumber *financePerformTarget;

-(id) initWithRegionDO:(DORegion *)regionDO TargetReached:(NSNumber *)targetReached FrequencyReached:(NSNumber *)frequencyReached SampleAllocationReached:(NSNumber *)sampleAllocationReached financePerforminPer:(NSNumber *)financePerforminPer financePerformACT:(NSNumber *)financePerformActual financePerformTarget:(NSNumber *)financePerformTarget;
@end
