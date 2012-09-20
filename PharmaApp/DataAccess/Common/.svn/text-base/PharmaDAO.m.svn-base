//
//  PharmaDAO.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PharmaDAO.h"
#import "SocialPostDO.h"

#define REGION_NATIONAL_HIER 1
#define REGION_REGION_HIER 2
#define REGION_STATE_HIER 3
#define REGION_TERRITORY_HIER 4

static PharmaDAO *sharedDAO = nil;

@interface PharmaDAO()
    - (void)loadInitialData;
@end
@implementation PharmaDAO
@synthesize databasePath=_databasePath;
@synthesize regions=_regions;
@synthesize states=_states;

#pragma mark Singleton Methods

+ (id)sharedDAO {
    @synchronized(self) 
    {
        if (sharedDAO == nil)
            sharedDAO = [[self alloc] init];
    }
    return sharedDAO;
}

- (id)init {
    
    if (self = [super init]) 
    {
        NSString *dbFileName = @"Pharma.sql";
        
//  1. Copy DB file to Application folder if doesn't exist.
        
        NSURL *urlToDocumentsDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:dbFileName];
        
        //set database path
        self.databasePath = [urlToDocumentsDirectory absoluteString];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:[urlToDocumentsDirectory absoluteString]]) 
        {
            NSURL *urlToFile = [[NSBundle mainBundle] URLForResource:@"Pharma" withExtension:@"sql"];
            NSError* error = nil;
                        
            [[NSFileManager defaultManager] copyItemAtURL:urlToFile toURL:urlToDocumentsDirectory error:&error];            
        }
//  2. Retrieve commonly used DO data
        //[self loadInitialData];        
    }    
    return self;
}

-(void)loadInitialData
{
//    // Setup the database object
//	sqlite3 *database;
//    
//	// Init the Region and State Array
//	self.regions = [[NSMutableArray alloc] init];
//    self.states = [[NSMutableArray alloc] init];
//    
//	// Open the database from the users filessytem
//	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
//		
//        // Fetch All regions
//		const char *sqlStatement = "select * from region";
//		sqlite3_stmt *compiledStatement;
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
//			// Loop through the results and add them to the feeds array
//			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
//				// Read the data from the result row
//				NSNumber *regionCode = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
//				NSString *region = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
//                
//				// Create a new Region object with the data from the database
//				RegionDO *regionDO = [[RegionDO alloc] initWithCode:regionCode region:region];
//                
//				// Add the animal object to the animals Array
//				[self.regions addObject:regionDO];
//			}
//		}
//		// Release the compiled statement from memory
//		sqlite3_finalize(compiledStatement);
//        
//        // Fetch All states
//		sqlStatement = "select * from states";
//		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
//			// Loop through the results and add them to the feeds array
//			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
//				// Read the data from the result row
//				NSNumber *regionCode = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
//				NSString *stateCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
//				NSString *stateDesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
//                
//				// Create a new State object with the data from the database
//                StateDO *stateDO = [[StateDO alloc] initWithCode:regionCode state:stateCode andDesc:stateDesc];
//                
//                [self.states addObject:stateDO];
//			}
//		}
//		// Release the compiled statement from memory
//		sqlite3_finalize(compiledStatement);        
//	}
//	sqlite3_close(database);
    
}
-(NSArray *)getAllRegions
{
    return self.regions;
}

-(RegionDO *)getRegionForCode:(NSNumber *)code
{
    RegionDO *regionDO = [[self.regions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.code=%@", code]] lastObject];
    return regionDO;
}

-(NSArray *)getStatesForRegion:(RegionDO *)region
{
//    if(region != nil && region.code != nil)
//    {
//        return 
//            [self.states filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.code=%@", region.code]];
//    }
//    else
//    {
//        return nil;
//    }
    return nil;
}

-(NSMutableArray *)getOverallFinancialPerformances
{
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *regionPerfArray = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		const char *sqlStatement = "select region_perfs.region,regions.regiondesc, regions.regionhier, region_perfs.alert_flag ,region_perfs.performance,region_perfs.revenue,region_perfs.execution, regions.parent, regions.center from region_perfs inner join regions on region_perfs.region = regions.region";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *regionCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *regionDesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];                                                  
				NSNumber *regionhier = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] intValue]];  
				NSNumber *alertflag = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] intValue]];                 
				NSNumber *perform = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] intValue]];  
				NSNumber *revenue = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];                 
				NSNumber *execution  = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] intValue]]; 
               
				NSString *parentReg  = nil;
                char *parentRegChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(parentRegChar)
                {    
                    parentReg = [NSString stringWithUTF8String:parentRegChar];
                }

				NSString *regionCtr  = nil;
                char *regionCtrChar = (char *)sqlite3_column_text(compiledStatement, 8);
                if(regionCtrChar)
                {    
                    regionCtr = [NSString stringWithUTF8String:regionCtrChar];
                }
                                
                BrandPerfRegionDO *perfDO = [[BrandPerfRegionDO alloc] initWithRegion:regionCode regionTxt:regionDesc regionCtr:regionCtr hierarchy:regionhier performance:perform revenue:revenue health:nil execution:execution socialPos:nil alert:alertflag andParentReg:parentReg];
                                              
				// Add the animal object to the animals Array
				[regionPerfArray addObject:perfDO];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
    
    return regionPerfArray;
}

-(NSMutableArray *)getOverAllBrandPerformances
{
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *brandPerfArray = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		const char *sqlStatement = "select brands.brandid,brands.brand_desc, brand_perfs.alert_flag,brand_perfs.performance, brand_perfs.revenue, brand_perfs.execution, brand_perfs.health, brand_perfs.social from brands INNER JOIN brand_perfs ON brands.brandid = brand_perfs.brandid where brand_perfs.region = 'USA'";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *brandid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
                
                NSString *brandDesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                
                NSNumber *alertflag = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] intValue]];   
                
				NSNumber *performance = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] intValue]];
                
				NSNumber *revenue = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] intValue]];
                
				NSNumber *health = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];
                
				NSNumber *execution = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] intValue]];  

                NSNumber *socialPos = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] intValue]];  
                
                BrandDO *brandDO = [[BrandDO alloc] initWithBrandID:brandid brandDesc:brandDesc];
                
				// Create a new Region object with the data from the database
				BrandPerfDO *brandPerfDO = [[BrandPerfDO alloc] initWithBrand:brandDO performance:performance revenue:revenue health:health execution:execution socialPos:socialPos andAlert:alertflag];
                
				// Add the animal object to the animals Array
				[brandPerfArray addObject:brandPerfDO];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
    
    return brandPerfArray;
}


-(RegionBrandPerfDO *)getPerformanceForParent:(RegionBrandPerfDO *)region andBrand:(BrandDO *)brand
{
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	RegionBrandPerfDO *returnObj = nil;
    NSMutableArray *childRegions = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) 
    {        
        if(region == nil)
        {
            NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select regions.region,regions.regionhier, regions.regiondesc,brand_perfs.alert_flag, brand_perfs.performance,brand_perfs.revenue,brand_perfs.health,brand_perfs.execution,brand_perfs.social, regions.center from  brand_perfs inner join regions on brand_perfs.region = regions.region"];
            
            [sqlString appendFormat:@" where regions.regionhier < 3 and brand_perfs.brandid = '%d'",[brand.brandID intValue]];
            
            [sqlString appendString:@" order by regions.regionhier"];
            const char *sqlStatement = [sqlString UTF8String];
            
            sqlite3_stmt *compiledStatement;
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
            {
                // Loop through the results and add them to the feeds array
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
                {
                    // Read the data from the result row
                    NSString *regionid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                                        
                    NSNumber *regionhier = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] intValue]];
                    
                    NSString *regiondesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];             
                    
                    NSNumber *alertflag = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] intValue]];      
                    
                    NSNumber *performance = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] intValue]];                     
                    
                    NSNumber *revenue = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];  
                    
                    NSNumber *health = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)] intValue]];
                    
                    NSNumber *execution = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] intValue]];  
                    
                    NSNumber *socialPos = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] intValue]];  
                    
                    NSString *regionCtr  = nil;
                    char *regionCtrChar = (char *)sqlite3_column_text(compiledStatement, 9);
                    if(regionCtrChar)
                    {    
                        regionCtr = [NSString stringWithUTF8String:regionCtrChar];
                    }
                    
                    // Create a new Region object with the data from the database
                    BrandPerfDO *brandPerfDO = [[BrandPerfDO alloc] initWithBrand:brand performance:performance revenue:revenue health:health execution:execution socialPos:socialPos andAlert:alertflag]; 
                    
                    if([regionhier intValue] == 1)
                    {
                        returnObj = [[RegionBrandPerfDO alloc] initWithRegion:regionid regionTxt:regiondesc hierarchy:regionhier regionCtr:regionCtr parent:nil brandPerf:brandPerfDO andChild:nil];
                    }
                    else
                    {
                        RegionBrandPerfDO *childObj = [[RegionBrandPerfDO alloc] initWithRegion:regionid regionTxt:regiondesc hierarchy:regionhier regionCtr:regionCtr parent:nil brandPerf:brandPerfDO andChild:nil];
                        
                        childObj.parent = returnObj;
                        [childRegions addObject:childObj];
                    }
                    
                } //End of While
                
                if(returnObj)
                {
                    returnObj.child = childRegions;
                }
            } //End of prepare statement if
            // Release the compiled statement from memory
            sqlite3_finalize(compiledStatement);
        } // End of region check
        else
        {
            returnObj = region;
            
            NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select regions.region,regions.regionhier, regions.regiondesc,brand_perfs.alert_flag, brand_perfs.performance,brand_perfs.revenue, brand_perfs.health, brand_perfs.execution, brand_perfs.social,regions.center from  brand_perfs inner join regions on brand_perfs.region = regions.region"];
            
            int queryHier = [region.regionHier intValue];
            queryHier = queryHier + 1;
            [sqlString appendFormat:@" where regions.parent = '%@' and regions.regionhier = '%d' and brand_perfs.brandid = '%d'", region.region, queryHier,[brand.brandID intValue]];
            
            [sqlString appendString:@" order by regions.regionhier"];
            // NSLog(@"%@",sqlString);
            const char *sqlStatement = [sqlString UTF8String];
            
            sqlite3_stmt *compiledStatement;
            if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) 
            {
                // Loop through the results and add them to the feeds array
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) 
                {
                    // Read the data from the result row
                    NSString *regionid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                    
                    NSNumber *regionhier = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] intValue]];
                    
                    NSString *regiondesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];             
                    
                    NSNumber *alertflag = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] intValue]];      
                    
                    NSNumber *performance = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] intValue]];                     
                    
                    NSNumber *revenue = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];  
                    
                    NSNumber *health = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,6)] intValue]];
                    
                    NSNumber *execution = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] intValue]];  
                    
                    NSNumber *socialPos = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] intValue]]; 

                    NSString *regionCtr  = nil;
                    char *regionCtrChar = (char *)sqlite3_column_text(compiledStatement, 9);
                    if(regionCtrChar)
                    {    
                        regionCtr = [NSString stringWithUTF8String:regionCtrChar];
                    }
                    
                    // Create a new Region object with the data from the database
                    BrandPerfDO *brandPerfDO = [[BrandPerfDO alloc] initWithBrand:brand  performance:performance revenue:revenue health:health execution:execution socialPos:socialPos andAlert:alertflag]; 
                    

                    RegionBrandPerfDO *childObj = [[RegionBrandPerfDO alloc] initWithRegion:regionid regionTxt:regiondesc hierarchy:regionhier regionCtr:regionCtr parent:nil brandPerf:brandPerfDO andChild:nil];
                        
                    childObj.parent = returnObj;
                    [childRegions addObject:childObj];
                    
                    
                } //End of While
                
                if(returnObj)
                {
                    returnObj.child = childRegions;
                }
            } //End of prepare statement if
            // Release the compiled statement from memory
            sqlite3_finalize(compiledStatement);
        }

    }
    sqlite3_close(database);
    return returnObj;
}


-(NSMutableArray *)getPerformanceForBrand:(BrandDO *)brand;
{    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    // Setup the database object
	sqlite3 *database;
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select regions.region,regions.regionhier, regions.regiondesc,brand_perfs.alert_flag, brand_perfs.performance,brand_perfs.revenue, brand_perfs.health, brand_perfs.execution, brand_perfs.social, regions.parent, regions.center from  brand_perfs inner join regions on brand_perfs.region = regions.region"];

        [sqlString appendFormat:@" where brand_perfs.brandid = '%d'", [brand.brandID intValue]];        
        [sqlString appendString:@" order by regions.regionhier"];
        // NSLog(@"%@",sqlString);
        
        const char *sqlStatement = [sqlString UTF8String];         
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSString *region = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
				NSNumber *regionHier = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] intValue]];
                
                NSString *regionDesc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                
                NSNumber *alertflag = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] intValue]];   
                
				NSNumber *performance = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] intValue]];
                
				NSNumber *revenue = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];
                
				NSNumber *health = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] intValue]];
                
				NSNumber *execution = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] intValue]];  
                
                NSNumber *socialPos = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] intValue]];  
                
                NSString *parentReg = nil;
                char *parentRegChar = (char *)sqlite3_column_text(compiledStatement, 9);
                if(parentRegChar)
                {    
                    parentReg = [NSString stringWithUTF8String:parentRegChar];
                }
                
				NSString *regionCtr  = nil;
                char *regionCtrChar = (char *)sqlite3_column_text(compiledStatement, 10);
                if(regionCtrChar)
                {    
                    regionCtr = [NSString stringWithUTF8String:regionCtrChar];
                }                

                
                BrandPerfRegionDO *brandPerfDO = [[BrandPerfRegionDO alloc] initWithRegion:region regionTxt:regionDesc regionCtr:regionCtr hierarchy:regionHier performance:performance revenue:revenue health:health execution:execution socialPos:socialPos alert:alertflag andParentReg:parentReg];
                
				// Add the animal object to the animals Array
				[returnArray addObject:brandPerfDO];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);        
    return returnArray;
}



//gaurav
-(NSMutableArray *)getSocialPostsForBrand:(BrandDO *)brand  rskflag:(NSInteger)flag

{
    NSMutableArray *returnArray;
    
    if(flag == 0){
        
        returnArray = [[NSMutableArray alloc] initWithObjects:
                       [[SocialPostDO alloc] initWithPost:@"Not Recommended" byUser:@"Hardy" onDate:@"May-14 / 2012" from:@"facebook"],
                       [[SocialPostDO alloc] initWithPost:@"Will make me very sleepy for a short period then I cannot sleep." byUser:@"Candy" onDate:@"Mar-18 / 2012" from:@"twitter"],   
                       [[SocialPostDO alloc] initWithPost:@"Seemed to help with the pain at first,then as time went on it didnt work as well" byUser:@"Smith" onDate:@"May-19 / 2012" from:@"blog"],                                   
                       nil];
        
    }
    else {
        
        returnArray = [[NSMutableArray alloc] initWithObjects:
                       [[SocialPostDO alloc] initWithPost:@"This is most effective" byUser:@"John" onDate:@"May-12 / 2012" from:@"twitter"],
                       [[SocialPostDO alloc] initWithPost:@"Consistent result achieved" byUser:@"Flora" onDate:@"Jan-16 / 2012" from:@"facebook"],   
                       [[SocialPostDO alloc] initWithPost:@"I recommend this often to my patients" byUser:@"Clarke" onDate:@"May-12 / 2012" from:@"blog"],                                   
                       nil];
        
    }
    return returnArray;
    
}


-(NSMutableArray *)getAllBrands
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    // Setup the database object
	sqlite3 *database;
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select brands.brand_desc from brands"];
        [sqlString appendString:@" order by brand_desc"];
        // NSLog(@"%@",sqlString);
        
        const char *sqlStatement = [sqlString UTF8String];         
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSString *region = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                
                [returnArray addObject:region];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);        
    return returnArray;
}

- (void)dealloc {
    
}
@end
