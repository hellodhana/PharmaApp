//
//  RegionBrandPerfDO.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 16/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BrandPerfDO.h"

@interface RegionBrandPerfDO : NSObject
{
    NSString *_region;
    NSString *_regionTxt;
    NSNumber *_regionHier;
    NSString *_regionCtr;
    RegionBrandPerfDO  *_parent;
    BrandPerfDO *_brandPerfDO;
    NSArray *_child;
}

@property(nonatomic, retain) NSString *region;
@property(nonatomic, retain) NSString *regionTxt;
@property(nonatomic, retain) NSNumber *regionHier;
@property(nonatomic, retain) NSString *regionCtr;
@property(nonatomic, retain) RegionBrandPerfDO *parent;
@property(nonatomic, retain) BrandPerfDO *brandPerfDO;
@property(nonatomic, retain) NSArray *child;

-(id)initWithRegion:(NSString *)region regionTxt:(NSString *)regionTxt hierarchy:(NSNumber *)regionHier regionCtr:(NSString *)regionCtr parent:(RegionBrandPerfDO *)parent brandPerf:(BrandPerfDO *)brandPerf andChild:(NSArray *)child;
@end
