//
//  DAOPharma.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOHCPPerf.h"
#import "sqlite3.h"
#import "DOBrand.h"

@interface DAOPharma : NSObject
{
    //Database Path
    NSString *_databasePath;
    NSArray *_brands;
    NSArray *_times;
    NSArray *_regions;
}

@property(nonatomic, retain) NSString *databasePath;
@property(nonatomic, retain) NSArray *brands;
@property(nonatomic, retain) NSArray *times;
@property(nonatomic, retain) NSArray *regions;

+ (id)sharedDAO;

/* 
 Overview: Get HCP Information for Brand, region and Time
 
 Detail: Given BrandID, Time ID and Region ID, this method returns HCP with performance
         and relation data.
*/

-(NSArray *)getHCPForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID andRegion:(NSNumber *)regionID;
/* 
 Overview: Get DurabilityIndex for Brand, region and Time
 
 Detail: Given BrandID, Time ID and Region ID, this method returns HCP with performance
 and relation data.
 */

-(NSArray *)getDurabilityIndexForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID andRegion:(NSNumber *)regionID;

/*
 Overview: Get Payer Access Index for Brand and Time
 
 Detail: Given BrandID, Time ID this method returns payer access Index data for all regions
*/

-(NSArray *)getPayerAccessForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID;

/*
 Overview: Get Execution Index for Brand and Time
 
 Detail: Given BrandID, Time ID this method returns execution Index data for all regions
 */

-(NSArray *)getExecutionForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID;


/*
 Overview: Get Overall Performance of Brand(Dashboard) for Period and Region
 
 Detail: Given Region ID, Time ID this method returns over all performance of all  brands
 */

-(NSArray *)getBrandPerformancesForPeriod:(NSNumber *)timID;


/*
 Overview: Get Overall Performance of Brand(Dashboard) for Period and Region
 
 Detail: Given Region ID, Time ID this method returns over all performance of all  brands
 */

-(NSArray *)getBrandPerformancesForPeriod:(NSNumber *)timID andBrand:(NSNumber *)brandID;

/*
 Overview: Get All brands for Drop Down
 
 Detail: Get All brands for Drop Down. Returns Array of DOBrand
 */
-(NSMutableArray *)getAllBrands;

/*
 Overview: Get All Periods for Drop Down
 
 Detail: Get All Periods for Drop Down. Returns Array of DOTime
 */
-(NSMutableArray *)getAllPeriods;

/*
 Overview: Get Overall Social Performance of Brand
 
 Detail: Given BrandID this method returns over all social performance of all  brands
 */
//gaurav

-(NSMutableArray *)getSocialPostsForBrand:(DOBrand *)brand  rskflag:(NSInteger)flag;//gaurav

-(NSArray *)getBrandSocialPerformance:(NSNumber *)brandID;

@end
