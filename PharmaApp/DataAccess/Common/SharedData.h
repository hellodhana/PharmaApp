//
//  SharedData.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOTime.h"
#import "DORegion.h"
#import "DOBrand.h"

@interface SharedData : NSObject
{
    NSString *_brand;
    NSString *_region;
    NSString *_district;
    NSString *_territory;    
    NSNumber *_hierarchy;
    NSString *_period;
    NSArray *_perfData;
    NSString *_RegionData;
    int _PerformancebuttonTag;
    int _showToolbar;
    
    
    
    DOTime *_doTime;
    DORegion *_doRegion;
    DOBrand *_doBrand;
}

@property(nonatomic, retain) NSString *brand;
@property(nonatomic, retain) NSString *region;
@property(nonatomic, retain) NSString *district;
@property(nonatomic, retain) NSString *territory;    
@property(nonatomic, retain) NSNumber *hierarchy;
@property(nonatomic, retain) NSString *period;
@property(nonatomic, retain) NSArray *perfData;
@property(nonatomic, retain) NSString *RegionData;
@property(nonatomic) int PerformancebuttonTag;
@property(nonatomic)  int showToolbar;

//New Data
@property(nonatomic, retain) DOTime *doTime;
@property(nonatomic, retain) DORegion *doRegion;
@property(nonatomic, retain) DOBrand *doBrand;

+ (id)sharedObj;
@end
