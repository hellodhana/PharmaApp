//
//  BrandPerfRegionDO.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandPerfRegionDO : NSObject
{
    NSString *_region;
    NSString *_regionTxt;
    NSString *_regionCtr;
    NSNumber *_hierarchy;    
    NSString *_parentReg;
    NSNumber *_alert;
    NSNumber *_performance;
    NSNumber *_revenue;
    NSNumber *_health;
    NSNumber *_execution;
    NSNumber *_socialPos;
}

@property(nonatomic, retain) NSString *region;
@property(nonatomic, retain) NSString *regionTxt;
@property(nonatomic, retain) NSString *regionCtr;
@property(nonatomic, retain) NSNumber *hierarchy; 
@property(nonatomic, retain) NSString *parentReg;
@property(nonatomic, retain) NSNumber *alert;
@property(nonatomic, retain) NSNumber *performance;
@property(nonatomic, retain) NSNumber *revenue;
@property(nonatomic, retain) NSNumber *health;
@property(nonatomic, retain) NSNumber *execution;
@property(nonatomic, retain) NSNumber *socialPos;

-(id)initWithRegion:(NSString *)region regionTxt:(NSString *)regionTxt regionCtr:(NSString *)regionCtr hierarchy:(NSNumber *)hierarchy performance:(NSNumber *)perf revenue:(NSNumber *)revenue health:(NSNumber *)health execution:(NSNumber *)execution socialPos:(NSNumber *)socialPos alert:(NSNumber *)alert andParentReg:(NSString *)parentReg;

@end
