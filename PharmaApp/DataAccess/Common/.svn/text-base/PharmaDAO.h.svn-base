//
//  PharmaDAO.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegionDO.h"
#import "StateDO.h"
#import "RegionPerfDO.h"
#import "BrandPerfDO.h"
#import "RegionBrandPerfDO.h"
#import "BrandDO.h"
#import "BrandPerfRegionDO.h"
#import "sqlite3.h"

@interface PharmaDAO : NSObject
{
    //Database Path
    NSString *_databasePath;
    
    //Frequently used DO Data in Application
    NSMutableArray *_regions;
    NSMutableArray *_states;
    
    
}

@property(nonatomic, retain) NSString *databasePath;
@property(nonatomic, retain) NSMutableArray *regions;
@property(nonatomic, retain) NSMutableArray *states;

//Data Access Methods

-(NSArray *)getAllRegions;

-(RegionDO *)getRegionForCode:(NSNumber *)code;

-(NSArray *)getStatesForRegion:(RegionDO *)region;

-(NSMutableArray *)getOverallFinancialPerformances;

-(NSMutableArray *)getOverAllBrandPerformances;

-(RegionBrandPerfDO *)getPerformanceForParent:(RegionBrandPerfDO *)region andBrand:(BrandDO *)brand;

-(NSMutableArray *)getPerformanceForBrand:(BrandDO *)brand;

-(NSMutableArray *)getSocialPostsForBrand:(BrandDO *)brand  rskflag:(NSInteger)flag;//gaurav

-(NSMutableArray *)getAllBrands;

+ (id)sharedDAO;
@end
