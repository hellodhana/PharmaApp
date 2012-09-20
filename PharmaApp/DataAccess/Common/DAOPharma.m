//
//  DAOPharma.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DAOPharma.h"
#import "DOBrand.h"
#import "DOTime.h"
#import "DORegion.h"
#import "DOPayer.h"
#import "DOPayerPerf.h"
#import "DOExecution.h"
#import "DOBrandPerf.h"
#import "DOSocialPerf.h"
#import "SocialPostDO.h"
#import "DODurability.h"


#define REGION_NATIONAL_HIER 0
#define REGION_REGION_HIER 1
#define REGION_STATE_HIER 2
#define REGION_TERRITORY_HIER 3

static DAOPharma *sharedDAO = nil;

@interface DAOPharma()
- (void)loadInitialData;
@end

@implementation DAOPharma
@synthesize brands=_brands;
@synthesize times=_times;
@synthesize regions=_regions;
@synthesize databasePath=_databasePath;

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
        NSString *dbFileName = @"Pharma2.sql";
        
        //  1. Copy DB file to Application folder if doesn't exist.
        
        NSURL *urlToDocumentsDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:dbFileName];
        
        //set database path
        self.databasePath = [urlToDocumentsDirectory absoluteString];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:[urlToDocumentsDirectory absoluteString]]) 
        {
            NSURL *urlToFile = [[NSBundle mainBundle] URLForResource:@"Pharma2" withExtension:@"sql"];
            NSError* error = nil;
            
            [[NSFileManager defaultManager] copyItemAtURL:urlToFile toURL:urlToDocumentsDirectory error:&error];            
        }
        //  2. Retrieve commonly used DO data
        [self loadInitialData];        
    }
    return self;
}

- (void)loadInitialData
{
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *brandArray = [[NSMutableArray alloc] init];
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    NSMutableArray *regionArray = [[NSMutableArray alloc] init];    
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All Brands
		const char *sqlStatement = "select * from brands";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *brandID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				NSString *brandName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                
				// Create a new Region object with the data from the database
                DOBrand *brandDO = [[DOBrand alloc] initWithBrandID:brandID brandDesc:brandName];
                
				// Add the animal object to the animals Array
				[brandArray addObject:brandDO];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
        // Fetch All Time Dimensions
		sqlStatement = "select * from timdim";
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSNumber *timID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				NSString *month = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSNumber *year = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] intValue]];
                
				// Create a new State object with the data from the database
                DOTime *timeDO = [[DOTime alloc] init];
                timeDO.timID = timID;
                timeDO.month = month;
                timeDO.year = year;
                
                if([timeDO.month isEqualToString:@""])
                {
                    timeDO.month = @"YTD";
                }
                
                [timeArray addObject:timeDO];
			}
		}
        
        // Fetch All Regions
		sqlStatement = "select * from regions";
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSString *mapCenter = nil;
                char *mapCenterChar = (char *)sqlite3_column_text(compiledStatement, 0);
                if(mapCenterChar)
                {    
                    mapCenter = [NSString stringWithUTF8String:mapCenterChar];
                }     
                
				NSNumber *regionID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] intValue]];  
                
                NSString *territory = nil;
                char *territoryChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(territoryChar)
                {    
                    territory = [NSString stringWithUTF8String:territoryChar];
                } 
                
                NSString *state = nil;
                char *stateChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(stateChar)
                {    
                    state = [NSString stringWithUTF8String:stateChar];
                }   
                
                NSString *regionTxt = nil;
                char *regionTxtChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(regionTxtChar)
                {    
                    regionTxt = [NSString stringWithUTF8String:regionTxtChar];
                }    
                
				NSNumber *hierarchy = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];                                  
				NSString *descTxt = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                
				// Create a new State object with the data from the database
                DORegion *regionDO = [[DORegion alloc] init];
                regionDO.center = mapCenter;
                regionDO.regionID = regionID;
                regionDO.state = state;
                regionDO.region = regionTxt;
                regionDO.territory = territory;
                regionDO.desc = descTxt;
                regionDO.hier = hierarchy;
                
                [regionArray addObject:regionDO];
			}
		}
        
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);        
	}
	sqlite3_close(database);
    
    self.brands = brandArray;
    self.times = timeArray;
    self.regions = regionArray;
}

-(NSArray *)getHCPForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID andRegion:(NSNumber *)regionID
{
    
}


-(NSArray *)getDurabilityIndexForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID andRegion:(NSNumber *)regionID
{
    
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select DURABILITY_INDEX.NRx_MKT_SHR_PLN , DURABILITY_INDEX.NRx_MKT_SHR_ACT , DURABILITY_INDEX.TRx_MKT_SHR_PLN , DURABILITY_INDEX.TRx_MKT_SHR_ACT , DURABILITY_INDEX.NRx_MKT_GRTH , DURABILITY_INDEX.NRx_MKT_GRTH_PLN,DURABILITY_INDEX.TRx_MKT_GRTH , DURABILITY_INDEX.TRx_MKT_GRTH_PLN , DURABILITY_INDEX.TRxNRx_RATIO,DURABILITY_INDEX.NUM_NEW_PAT_START,DURABILITY_INDEX.NUM_NEW_PAT_STRT_PLN,DURABILITY_INDEX.NUM_SWH_PAT,DURABILITY_INDEX.NUM_SWH_PAT_STRT_PLN,DURABILITY_INDEX.RLT_COPAY_PLN,DURABILITY_INDEX.RLT_COPAY_ACT,brand_performance.DURBL_IDX_PLN,brand_performance.DURBL_IDX_ACT from DURABILITY_INDEX inner join brand_performance on DURABILITY_INDEX.regionid = brand_performance.regionid and DURABILITY_INDEX.brandid = brand_performance.brandid and DURABILITY_INDEX.timid = brand_performance.timid"];
        
        if([regionID intValue]==0){
        [sqlString appendFormat:@" where DURABILITY_INDEX.brandid = %d and DURABILITY_INDEX.timid = %d and DURABILITY_INDEX.regionid = 41", [brandID intValue], [timID intValue]];  
        }
        else{
              [sqlString appendFormat:@" where DURABILITY_INDEX.brandid = %d and DURABILITY_INDEX.timid = %d and DURABILITY_INDEX.regionid = %d", [brandID intValue], [timID intValue],[regionID intValue]];  
        }
        //[sqlString appendString:@" order by execution_index.regionid"];
   // NSLog(@"sqlString : %@",sqlString);
        
        // Fetch All Brands
		const char *sqlStatement = [sqlString UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                // Target Reached
                NSNumber *NRx_MKT_SHR_PLN = nil;
                NSNumber *NRx_MKT_SHR_ACT = nil;
                char *NRx_MKT_SHR_PLNChar = (char *)sqlite3_column_text(compiledStatement, 0);
                if(NRx_MKT_SHR_PLNChar)
                {    
                    NRx_MKT_SHR_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NRx_MKT_SHR_PLNChar] intValue]];
                } 
                
                char *NRx_MKT_SHR_ACTChar = (char *)sqlite3_column_text(compiledStatement, 1);
                if(NRx_MKT_SHR_ACTChar)
                {    
                    NRx_MKT_SHR_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NRx_MKT_SHR_ACTChar] intValue]];
                } 
                
                
                //  NSNumber *targetReached=[NSNumber numberWithFloat:([PCT_RCH_ACT floatValue]/[PCT_RCH_PLN floatValue]) * 100];
                //NSLog(@"targetReached : %d",[targetReached intValue]);
                
                
                NSNumber *TRx_MKT_SHR_PLN = nil;
                NSNumber *TRx_MKT_SHR_ACT = nil;
                char *TRx_MKT_SHR_PLNChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(TRx_MKT_SHR_PLNChar)
                {    
                    TRx_MKT_SHR_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:TRx_MKT_SHR_PLNChar] intValue]];
                } 
                
                char *TRx_MKT_SHR_ACTChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(TRx_MKT_SHR_ACTChar)
                {    
                    TRx_MKT_SHR_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:TRx_MKT_SHR_ACTChar] intValue]];
                } 
                
                
                NSNumber *NRx_MKT_GRTH = nil;
                NSNumber *NRx_MKT_GRTH_PLN = nil;
                char *NRx_MKT_GRTHChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(NRx_MKT_GRTHChar)
                {    
                    NRx_MKT_GRTH = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NRx_MKT_GRTHChar] intValue]];
                } 
                
                char *NRx_MKT_GRTH_PLNChar = (char *)sqlite3_column_text(compiledStatement, 5);
                if(NRx_MKT_GRTH_PLNChar)
                {    
                    NRx_MKT_GRTH_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NRx_MKT_GRTH_PLNChar] intValue]];
                } 
                
                NSNumber *TRx_MKT_GRTH = nil;
                NSNumber *TRx_MKT_GRTH_PLN = nil;
                char *TRx_MKT_GRTHChar = (char *)sqlite3_column_text(compiledStatement, 6);
                if(TRx_MKT_GRTHChar)
                {    
                    TRx_MKT_GRTH = [NSNumber numberWithInt:[[NSString stringWithUTF8String:TRx_MKT_GRTHChar] intValue]];
                } 
                
                char *TRx_MKT_GRTH_PLNChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(TRx_MKT_GRTH_PLNChar)
                {    
                    TRx_MKT_GRTH_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:TRx_MKT_GRTH_PLNChar] intValue]];
                } 
                
                
                // Read the data from the result row
                // Average Frequency Details
                
                NSNumber *TRxNRx_RATIO = nil;
                
                char *TRxNRx_RATIOChar = (char *)sqlite3_column_text(compiledStatement, 8);
                if(TRxNRx_RATIOChar)
                {    
                    TRxNRx_RATIO = [NSNumber numberWithInt:[[NSString stringWithUTF8String:TRxNRx_RATIOChar] intValue]];
                } 
                
                
                
                NSNumber *NUM_NEW_PAT_START = nil;
                NSNumber *NUM_NEW_PAT_STRT_PLN = nil;
                char *NUM_NEW_PAT_STARTChar = (char *)sqlite3_column_text(compiledStatement, 9);
                if(NUM_NEW_PAT_STARTChar)
                {    
                    NUM_NEW_PAT_START = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NUM_NEW_PAT_STARTChar] intValue]];
                } 
                
                char *NUM_NEW_PAT_STRT_PLNChar = (char *)sqlite3_column_text(compiledStatement,10);
                if(NUM_NEW_PAT_STRT_PLNChar)
                {    
                    NUM_NEW_PAT_STRT_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NUM_NEW_PAT_STRT_PLNChar] intValue]];
                } 
                
                
                NSNumber *NUM_SWH_PAT = nil;
                NSNumber *NUM_SWH_PAT_STRT_PLN = nil;
                char *NUM_SWH_PATChar = (char *)sqlite3_column_text(compiledStatement, 11);
                if(NUM_SWH_PATChar)
                {    
                    NUM_SWH_PAT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NUM_SWH_PATChar] intValue]];
                } 
                
                char *NUM_SWH_PAT_STRT_PLNChar = (char *)sqlite3_column_text(compiledStatement, 12);
                if(NUM_SWH_PAT_STRT_PLNChar)
                {    
                    NUM_SWH_PAT_STRT_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:NUM_SWH_PAT_STRT_PLNChar] intValue]];
                } 
                
                
                NSNumber *RLT_COPAY_PLN = nil;
                NSNumber *RLT_COPAY_ACT = nil;
                char *RLT_COPAY_PLNChar = (char *)sqlite3_column_text(compiledStatement, 13);
                if(RLT_COPAY_PLNChar)
                {    
                    RLT_COPAY_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:RLT_COPAY_PLNChar] intValue]];
                } 
                
                char *RLT_COPAY_ACTChar = (char *)sqlite3_column_text(compiledStatement, 14);
                if(RLT_COPAY_ACTChar)
                {    
                    RLT_COPAY_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:RLT_COPAY_ACTChar] intValue]];
                } 
                
                NSNumber *DURBL_IDX_ACT = nil;
                NSNumber *DURBL_IDX_PLN = nil;
                char *DURBL_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 15);
                if(DURBL_IDX_PLNChar)
                {    
                    DURBL_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:DURBL_IDX_PLNChar] intValue]];
                } 
                
                char *DURBL_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 16);
                if(DURBL_IDX_ACTChar)
                {    
                    DURBL_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:DURBL_IDX_ACTChar] intValue]];
                } 
                
                DODurability *durability = [[DODurability alloc] init];
                
                durability.nrx_mkt_shr_pln = NRx_MKT_SHR_PLN;
                durability.nrx_mkt_shr_act = NRx_MKT_SHR_ACT;
                durability.trx_mkt_shr_pln = TRx_MKT_SHR_PLN;
                durability.trx_mkt_shr_act = TRx_MKT_SHR_ACT;
                durability.rlt_copay_act=RLT_COPAY_ACT;
                durability.rlt_copay_pln=RLT_COPAY_PLN;
                durability.durbl_idx_pln=DURBL_IDX_PLN;
                durability.durbl_idx_act=DURBL_IDX_ACT;
                durability.nrx_mkt_grth = NRx_MKT_GRTH;
                durability.nrx_mkt_grth_pln = NRx_MKT_GRTH_PLN;
                durability.trx_mkt_grth = TRx_MKT_GRTH;
                durability.trx_mkt_grth_pln = TRx_MKT_GRTH_PLN;
                
                durability.trx_nrx_ratio = TRxNRx_RATIO;
                durability.num_new_pat_strt=NUM_NEW_PAT_START;
                durability.num_new_pat_strt_pln=NUM_NEW_PAT_STRT_PLN;
                durability.num_swh_pat_strt=NUM_SWH_PAT;
                durability.num_swh_pat_strt_pln=NUM_SWH_PAT_STRT_PLN;
               [returnArray addObject:durability];
                
                
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);        
    return returnArray; 
}


-(NSArray *)getPayerAccessForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID;
{
    
    /*
     select payer_index.T2_LIV_PCT , payer_index.T3_LIV_PCT , payer_index.RST_LIV_PCT , payer_index.NC_LIV_PCT , payer_index.TOP_PAY_NM_1 , payer_index.TOP_PAY_SZ_1 , payer_index.TOP_PAY_ST_1 , payer_index.TOP_PAY_NM_2 , payer_index.TOP_PAY_SZ_2 , payer_index.TOP_PAY_ST_2 , payer_index.TOP_PAY_NM_3 , payer_index.TOP_PAY_SZ_3 , payer_index.TOP_PAY_ST_3 , payer_index.TOP_PAY_NM_4 , payer_index.TOP_PAY_SZ_4 , payer_index.TOP_PAY_ST_4 , payer_index.TOP_PAY_NM_5 , payer_index.TOP_PAY_SZ_5 , payer_index.TOP_PAY_ST_5 , REGIONS.REGIONID ,REGIONS.TERTRY ,REGIONS.ST_CD ,REGIONS.REGION ,REGIONS.HIER ,REGIONS.DESC from payer_index inner join REGIONS on payer_index.REGIONID = regions.regionid where brandid = 1 and TIMID = 1
     */
    
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select payer_index.T2_LIV_PCT , payer_index.T3_LIV_PCT , payer_index.RST_LIV_PCT , payer_index.NC_LIV_PCT , payer_index.TOP_PAY_NM_1 , payer_index.TOP_PAY_SZ_1 , payer_index.TOP_PAY_ST_1 , payer_index.TOP_PAY_NM_2 , payer_index.TOP_PAY_SZ_2 , payer_index.TOP_PAY_ST_2 , payer_index.TOP_PAY_NM_3 , payer_index.TOP_PAY_SZ_3 , payer_index.TOP_PAY_ST_3 , payer_index.TOP_PAY_NM_4 , payer_index.TOP_PAY_SZ_4 , payer_index.TOP_PAY_ST_4 , payer_index.TOP_PAY_NM_5 , payer_index.TOP_PAY_SZ_5 , payer_index.TOP_PAY_ST_5 , payer_index.regionid,brand_performance.ACSS_IDX_ACT,brand_performance.ACSS_IDX_PLN from payer_index inner join brand_performance on payer_index.regionid = brand_performance.regionid and payer_index.brandid = brand_performance.brandid and payer_index.timid = brand_performance.timid "];
        
        [sqlString appendFormat:@" where payer_index.brandid = %d and payer_index.timid = %d", [brandID intValue], [timID intValue]];        
        [sqlString appendString:@" order by payer_index.regionid"];
        
        // Fetch All Brands
		const char *sqlStatement = [sqlString UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                NSNumber *t2 = nil;
                char *t2Char = (char *)sqlite3_column_text(compiledStatement, 0);
                if(t2Char)
                {    
                    t2 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:t2Char] intValue]];
                } 
                
                NSNumber *t3 = nil;
                char *t3Char = (char *)sqlite3_column_text(compiledStatement, 1);
                if(t3Char)
                {    
                    t3 = [NSNumber numberWithInt:[[NSString stringWithUTF8String:t3Char] intValue]];
                }    
                
                NSNumber *res = nil;
                char *resChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(resChar)
                {    
                    res = [NSNumber numberWithInt:[[NSString stringWithUTF8String:resChar] intValue]];
                }  
                
                NSNumber *nc = nil;
                char *ncChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(ncChar)
                {    
                    nc = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ncChar] intValue]];
                }   
                
                //Payer 1
                NSString *payer1Nm = nil;
                char *payer1NmChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(payer1NmChar)
                {    
                    payer1Nm = [NSString stringWithUTF8String:payer1NmChar];
                }                  
                NSNumber *payer1Sz = nil;
                char *payer1SzChar = (char *)sqlite3_column_text(compiledStatement, 5);
                if(payer1SzChar)
                {    
                    payer1Sz = [NSNumber numberWithLong:[[NSString stringWithUTF8String:payer1SzChar] intValue]];
                }                   
                NSString *payer1Stat = nil;
                char *payer1StatChar = (char *)sqlite3_column_text(compiledStatement, 6);
                if(payer1StatChar)
                {    
                    payer1Stat = [NSString stringWithUTF8String:payer1StatChar];
                } 
                
                //Payer 2
                NSString *payer2Nm = nil;
                char *payer2NmChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(payer2NmChar)
                {    
                    payer2Nm = [NSString stringWithUTF8String:payer2NmChar];
                }                  
                NSNumber *payer2Sz = nil;
                char *payer2SzChar = (char *)sqlite3_column_text(compiledStatement, 8);
                if(payer2SzChar)
                {    
                    payer2Sz = [NSNumber numberWithLong:[[NSString stringWithUTF8String:payer2SzChar] intValue]];
                }                   
                NSString *payer2Stat = nil;
                char *payer2StatChar = (char *)sqlite3_column_text(compiledStatement, 9);
                if(payer2StatChar)
                {    
                    payer2Stat = [NSString stringWithUTF8String:payer2StatChar];
                } 
                
                //Payer 3
                NSString *payer3Nm = nil;
                char *payer3NmChar = (char *)sqlite3_column_text(compiledStatement, 10);
                if(payer3NmChar)
                {    
                    payer3Nm = [NSString stringWithUTF8String:payer3NmChar];
                }                  
                NSNumber *payer3Sz = nil;
                char *payer3SzChar = (char *)sqlite3_column_text(compiledStatement, 11);
                if(payer3SzChar)
                {    
                    payer3Sz = [NSNumber numberWithLong:[[NSString stringWithUTF8String:payer3SzChar] intValue]];
                }                   
                NSString *payer3Stat = nil;
                char *payer3StatChar = (char *)sqlite3_column_text(compiledStatement, 12);
                if(payer3StatChar)
                {    
                    payer3Stat = [NSString stringWithUTF8String:payer3StatChar];
                }  
                
                //Payer 4
                NSString *payer4Nm = nil;
                char *payer4NmChar = (char *)sqlite3_column_text(compiledStatement, 13);
                if(payer4NmChar)
                {    
                    payer4Nm = [NSString stringWithUTF8String:payer4NmChar];
                }                  
                NSNumber *payer4Sz = nil;
                char *payer4SzChar = (char *)sqlite3_column_text(compiledStatement, 14);
                if(payer4SzChar)
                {    
                    payer4Sz = [NSNumber numberWithLong:[[NSString stringWithUTF8String:payer4SzChar] intValue]];
                }                   
                NSString *payer4Stat = nil;
                char *payer4StatChar = (char *)sqlite3_column_text(compiledStatement, 15);
                if(payer4StatChar)
                {    
                    payer4Stat = [NSString stringWithUTF8String:payer4StatChar];
                }
                
                //Payer 5
                NSString *payer5Nm = nil;
                char *payer5NmChar = (char *)sqlite3_column_text(compiledStatement, 16);
                if(payer5NmChar)
                {    
                    payer5Nm = [NSString stringWithUTF8String:payer5NmChar];
                }                  
                NSNumber *payer5Sz = nil;
                char *payer5SzChar = (char *)sqlite3_column_text(compiledStatement, 17);
                if(payer5SzChar)
                {    
                    payer5Sz = [NSNumber numberWithLong:[[NSString stringWithUTF8String:payer5SzChar] intValue]];
                }                   
                NSString *payer5Stat = nil;
                char *payer5StatChar = (char *)sqlite3_column_text(compiledStatement, 18);
                if(payer5StatChar)
                {    
                    payer5Stat = [NSString stringWithUTF8String:payer5StatChar];
                }                
                
                //Get Region Detail
                NSNumber *regionID = nil;
                char *regionIDChar = (char *)sqlite3_column_text(compiledStatement, 19);
                if(regionIDChar)
                {    
                    regionID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:regionIDChar] intValue]];
                }
                
                NSNumber *accessActual = nil;
                char *accessActualChar = (char *)sqlite3_column_text(compiledStatement, 20);
                if(accessActualChar)
                {    
                    accessActual = [NSNumber numberWithInt:[[NSString stringWithUTF8String:accessActualChar] intValue]];
                }
                
                NSNumber *accessTarget = nil;
                char *accessTargetChar = (char *)sqlite3_column_text(compiledStatement, 21);
                if(accessTargetChar)
                {    
                    accessTarget = [NSNumber numberWithInt:[[NSString stringWithUTF8String:accessTargetChar] intValue]];
                }
                //NSLog(@"%d %d",[accessActual intValue],[accessTarget intValue]);
                NSArray *topPayers = [[NSArray alloc] initWithObjects:
                                      [[DOPayer alloc] initWithName:payer1Nm status:payer1Stat andLC:payer1Sz], 
                                      [[DOPayer alloc] initWithName:payer2Nm status:payer2Stat andLC:payer2Sz], 
                                      [[DOPayer alloc] initWithName:payer3Nm status:payer3Stat andLC:payer3Sz], 
                                      [[DOPayer alloc] initWithName:payer4Nm status:payer4Stat andLC:payer4Sz], 
                                      [[DOPayer alloc] initWithName:payer5Nm status:payer5Stat andLC:payer5Sz],                                       
                                      nil ];
                
                DORegion *regionDO = [[self.regions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionID=%d", [regionID intValue]]] lastObject];
                
                DOPayerPerf *payerPerf = [[DOPayerPerf alloc] initWithRegionDO:regionDO t2:t2 t3:t3 rest:res nc:nc payers:topPayers accessAct:accessActual accessPLN:accessTarget];
                [returnArray addObject:payerPerf];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);        
    return returnArray;    
}

-(NSArray *)getExecutionForBrand:(NSNumber *)brandID forPeriod:(NSNumber *)timID
{
    
    /*
     select payer_index.T2_LIV_PCT , payer_index.T3_LIV_PCT , payer_index.RST_LIV_PCT , payer_index.NC_LIV_PCT , payer_index.TOP_PAY_NM_1 , payer_index.TOP_PAY_SZ_1 , payer_index.TOP_PAY_ST_1 , payer_index.TOP_PAY_NM_2 , payer_index.TOP_PAY_SZ_2 , payer_index.TOP_PAY_ST_2 , payer_index.TOP_PAY_NM_3 , payer_index.TOP_PAY_SZ_3 , payer_index.TOP_PAY_ST_3 , payer_index.TOP_PAY_NM_4 , payer_index.TOP_PAY_SZ_4 , payer_index.TOP_PAY_ST_4 , payer_index.TOP_PAY_NM_5 , payer_index.TOP_PAY_SZ_5 , payer_index.TOP_PAY_ST_5 , REGIONS.REGIONID ,REGIONS.TERTRY ,REGIONS.ST_CD ,REGIONS.REGION ,REGIONS.HIER ,REGIONS.DESC from payer_index inner join REGIONS on payer_index.REGIONID = regions.regionid where brandid = 1 and TIMID = 1
     */
    
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select execution_index.PCT_RCH_PLN , execution_index.PCT_RCH_ACT , execution_index.FREQ_PLN , execution_index.FREQ_ACT , execution_index.SMP_ALLOC_PER_PLN , execution_index.SMP_ALLOC_PER_ACT , execution_index.regionid,finance_performance.PLN_SLS,finance_performance.ACT_SLS from execution_index inner join finance_performance on execution_index.regionid = finance_performance.regionid and execution_index.brandid = finance_performance.brandid and execution_index.timid = finance_performance.timid"];
        
        [sqlString appendFormat:@" where execution_index.brandid = %d and execution_index.timid = %d", [brandID intValue], [timID intValue]];        
        [sqlString appendString:@" order by execution_index.regionid"];
        //NSLog(@"sqlString : %@",sqlString);
      /*  
        NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select execution_index.PCT_RCH_PLN , execution_index.PCT_RCH_ACT , execution_index.FREQ_PLN , execution_index.FREQ_ACT , execution_index.SMP_ALLOC_PER_PLN , execution_index.SMP_ALLOC_PER_ACT , execution_index.regionid from execution_index"];
        
        [sqlString appendFormat:@" where execution_index.brandid = %d and execution_index.timid = %d", [brandID intValue], [timID intValue]];        
        [sqlString appendString:@" order by execution_index.regionid"];
        */
        // Fetch All Brands
		const char *sqlStatement = [sqlString UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                // Target Reached
                NSNumber *PCT_RCH_PLN = nil;
                NSNumber *PCT_RCH_ACT = nil;
                char *PCT_RCH_PLNChar = (char *)sqlite3_column_text(compiledStatement, 0);
                if(PCT_RCH_PLNChar)
                {    
                    PCT_RCH_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:PCT_RCH_PLNChar] intValue]];
                } 
                
                char *PCT_RCH_ACTChar = (char *)sqlite3_column_text(compiledStatement, 1);
                if(PCT_RCH_ACTChar)
                {    
                    PCT_RCH_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:PCT_RCH_ACTChar] intValue]];
                } 
                
                NSNumber *targetReached=[NSNumber numberWithFloat:([PCT_RCH_ACT floatValue]/[PCT_RCH_PLN floatValue]) * 100];
                //NSLog(@"targetReached : %d",[targetReached intValue]);
                              
                // Read the data from the result row
                // Average Frequency Details
              
                NSNumber *FREQ_PLN = nil;
                NSNumber *FREQ_ACT = nil;
                char *FREQ_PLNChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(FREQ_PLNChar)
                {    
                    FREQ_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FREQ_PLNChar] intValue]];
                } 
                
                char *FREQ_ACTChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(FREQ_ACTChar)
                {    
                    FREQ_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FREQ_ACTChar] intValue]];
                } 
                
                 NSNumber *frequencyReached=[NSNumber numberWithFloat:([FREQ_ACT floatValue]/[FREQ_PLN floatValue]) * 100];
                
                //NSLog(@"frequencyReached : %d",[frequencyReached intValue]);
                
                
                // Read the data from the result row
                // Sample Allocation
                NSNumber *SMP_ALLOC_PER_PLN = nil;
                NSNumber *SMP_ALLOC_PER_ACT = nil;
                char *SMP_ALLOC_PER_PLNChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(SMP_ALLOC_PER_PLNChar)
                {    
                    SMP_ALLOC_PER_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SMP_ALLOC_PER_PLNChar] intValue]];
                } 
                
                char *SMP_ALLOC_PER_ACTChar = (char *)sqlite3_column_text(compiledStatement, 5);
                if(SMP_ALLOC_PER_ACTChar)
                {    
                    SMP_ALLOC_PER_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SMP_ALLOC_PER_ACTChar] intValue]];
                } 
                
               NSNumber *sampleAllocationReached=[NSNumber numberWithFloat:([SMP_ALLOC_PER_ACT floatValue]/[SMP_ALLOC_PER_PLN floatValue]) * 100];
               // NSLog(@"sampleAllocationReached : %d",[sampleAllocationReached intValue]);
                
            
                
                //Get Region Detail
                NSNumber *regionID = nil;
                char *regionIDChar = (char *)sqlite3_column_text(compiledStatement, 6);
                if(regionIDChar)
                {    
                    regionID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:regionIDChar] intValue]];
                }  
                
                NSNumber *PLN_SLS = nil;
                NSNumber *ACT_SLS = nil;
                char *PLN_SLSChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(PLN_SLSChar)
                {    
                    PLN_SLS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:PLN_SLSChar] intValue]];
                } 
                
                char *ACT_SLSChar = (char *)sqlite3_column_text(compiledStatement, 8);
                if(ACT_SLSChar)
                {    
                    ACT_SLS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACT_SLSChar] intValue]];
                } 
                NSNumber *financePerforminPer=[NSNumber numberWithFloat:([ACT_SLS floatValue]/[PLN_SLS floatValue]) * 100];
                

                
                
                DORegion *regionDO = [[self.regions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionID=%d", [regionID intValue]]] lastObject];
                
                DOExecution *executionPerf = [[DOExecution alloc] initWithRegionDO:regionDO TargetReached:targetReached FrequencyReached:frequencyReached SampleAllocationReached:sampleAllocationReached financePerforminPer:financePerforminPer financePerformACT:ACT_SLS financePerformTarget:PLN_SLS];
                [returnArray addObject:executionPerf];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);        
    return returnArray;    
}


-(NSArray *)getBrandPerformancesForPeriod:(NSNumber *)timID;
{
    /*
     SELECT
     BRAND_PERFORMANCE.BRND_HTH_IDX_ACT,
     BRAND_PERFORMANCE.BRND_HTH_IDX_PLN,
     BRAND_PERFORMANCE.DURBL_IDX_ACT,
     BRAND_PERFORMANCE.DURBL_IDX_PLN,
     BRAND_PERFORMANCE.ADPT_IDX_ACT,
     BRAND_PERFORMANCE.ADPT_IDX_PLN,
     BRAND_PERFORMANCE.SCL_BUZZ_IDX_ACT,
     BRAND_PERFORMANCE.SCL_BUZZ_IDX_PLN,
     BRAND_PERFORMANCE.ACSS_IDX_ACT,
     BRAND_PERFORMANCE.ACSS_IDX_PLN,
     BRAND_PERFORMANCE.FIN_IDX_ACT,
     BRAND_PERFORMANCE.FIN_IDX_PLN,
     BRAND_PERFORMANCE.EXEC_IDX_ACT,
     BRAND_PERFORMANCE.EXEC_IDX_PLN,
     BRAND_PERFORMANCE.INTSTY_IDX_ACT,
     BRAND_PERFORMANCE.INTSTY_IDX_PLN,
     BRAND_PERFORMANCE.AVG_NRx_TGT_PSC,
     BRAND_PERFORMANCE.AVG_NRx_NON_TGT_PSC,
     FINANCE_PERFORMANCE.PLN_SLS,
     FINANCE_PERFORMANCE.ACT_SLS
     FROM
     BRAND_PERFORMANCE INNER JOIN FINANCE_PERFORMANCE
     ON
     BRAND_PERFORMANCE.BRANDID = FINANCE_PERFORMANCE.BRANDID AND
     BRAND_PERFORMANCE.REGIONID = FINANCE_PERFORMANCE.REGIONID AND       
     BRAND_PERFORMANCE.TIMID= FINANCE_PERFORMANCE.TIMID  
    */
    
    if(timID == nil)
    {
        timID = [NSNumber numberWithInt:1];
    }
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    //Fetch National Performance when region ID is initial;
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"SELECT BRAND_PERFORMANCE.BRND_HTH_IDX_ACT,BRAND_PERFORMANCE.BRND_HTH_IDX_PLN,BRAND_PERFORMANCE.DURBL_IDX_ACT,BRAND_PERFORMANCE.DURBL_IDX_PLN,BRAND_PERFORMANCE.ADPT_IDX_ACT,BRAND_PERFORMANCE.ADPT_IDX_PLN,BRAND_PERFORMANCE.SCL_BUZZ_IDX_ACT,BRAND_PERFORMANCE.SCL_BUZZ_IDX_PLN,BRAND_PERFORMANCE.ACSS_IDX_ACT,BRAND_PERFORMANCE.ACSS_IDX_PLN,BRAND_PERFORMANCE.FIN_IDX_ACT,BRAND_PERFORMANCE.FIN_IDX_PLN,BRAND_PERFORMANCE.EXEC_IDX_ACT,BRAND_PERFORMANCE.EXEC_IDX_PLN,BRAND_PERFORMANCE.INTSTY_IDX_ACT,BRAND_PERFORMANCE.INTSTY_IDX_PLN,BRAND_PERFORMANCE.AVG_NRx_TGT_PSC,BRAND_PERFORMANCE.AVG_NRx_NON_TGT_PSC, BRAND_PERFORMANCE.BRANDID,BRAND_PERFORMANCE.REGIONID, FINANCE_PERFORMANCE.PLN_SLS,FINANCE_PERFORMANCE.ACT_SLS FROM BRAND_PERFORMANCE INNER JOIN FINANCE_PERFORMANCE ON BRAND_PERFORMANCE.BRANDID = FINANCE_PERFORMANCE.BRANDID AND BRAND_PERFORMANCE.REGIONID = FINANCE_PERFORMANCE.REGIONID AND BRAND_PERFORMANCE.TIMID= FINANCE_PERFORMANCE.TIMID"];
        
        [sqlString appendFormat:@" where brand_performance.TIMID = %d", [timID intValue]];        
        [sqlString appendString:@" order by brand_performance.brandid"];
        //NSLog(@"sqlString : %@",sqlString);
        /*  
         NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select execution_index.PCT_RCH_PLN , execution_index.PCT_RCH_ACT , execution_index.FREQ_PLN , execution_index.FREQ_ACT , execution_index.SMP_ALLOC_PER_PLN , execution_index.SMP_ALLOC_PER_ACT , execution_index.regionid from execution_index"];
         
         [sqlString appendFormat:@" where execution_index.brandid = %d and execution_index.timid = %d", [brandID intValue], [timID intValue]];        
         [sqlString appendString:@" order by execution_index.regionid"];
         */
        // Fetch All Brands
		const char *sqlStatement = [sqlString UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                // Target Reached
                NSNumber *BRND_HTH_IDX_ACT = nil;
                NSNumber *BRND_HTH_IDX_PLN = nil;
                
                char *BRND_HTH_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 0);
                if(BRND_HTH_IDX_ACTChar)
                {    
                    BRND_HTH_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:BRND_HTH_IDX_ACTChar] intValue]];
                } 
                
                char *BRND_HTH_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 1);
                if(BRND_HTH_IDX_PLNChar)
                {    
                    BRND_HTH_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:BRND_HTH_IDX_PLNChar] intValue]];
                } 
                
                
                NSNumber *DURBL_IDX_ACT = nil;
                NSNumber *DURBL_IDX_PLN = nil;
                char *DURBL_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(DURBL_IDX_ACTChar)
                {    
                    DURBL_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:DURBL_IDX_ACTChar] intValue]];
                } 
                
                char *DURBL_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(DURBL_IDX_PLNChar)
                {    
                    DURBL_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:DURBL_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *ADPT_IDX_ACT = nil;
                NSNumber *ADPT_IDX_PLN = nil;
                char *ADPT_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(ADPT_IDX_ACTChar)
                {    
                    ADPT_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ADPT_IDX_ACTChar] intValue]];
                } 
                
                char *ADPT_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 5);
                if(ADPT_IDX_PLNChar)
                {    
                    ADPT_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ADPT_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *SCL_BUZZ_IDX_ACT = nil;
                NSNumber *SCL_BUZZ_IDX_PLN = nil;
                char *SCL_BUZZ_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 6);
                if(SCL_BUZZ_IDX_ACTChar)
                {    
                    SCL_BUZZ_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SCL_BUZZ_IDX_ACTChar] intValue]];
                } 
                
                char *SCL_BUZZ_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(SCL_BUZZ_IDX_PLNChar)
                {    
                    SCL_BUZZ_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SCL_BUZZ_IDX_PLNChar] intValue]];
                }                 
                     
                NSNumber *ACSS_IDX_ACT = nil;
                NSNumber *ACSS_IDX_PLN = nil;
                char *ACSS_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 8);
                if(ACSS_IDX_ACTChar)
                {    
                    ACSS_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACSS_IDX_ACTChar] intValue]];
                } 
                
                char *ACSS_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 9);
                if(ACSS_IDX_PLNChar)
                {    
                    ACSS_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACSS_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *FIN_IDX_ACT = nil;
                NSNumber *FIN_IDX_PLN = nil;
                char *FIN_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 10);
                if(FIN_IDX_ACTChar)
                {    
                    FIN_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FIN_IDX_ACTChar] intValue]];
                } 
                
                char *FIN_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 11);
                if(FIN_IDX_PLNChar)
                {    
                    FIN_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FIN_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *EXEC_IDX_ACT = nil;
                NSNumber *EXEC_IDX_PLN = nil;
                char *EXEC_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 12);
                if(EXEC_IDX_ACTChar)
                {    
                    EXEC_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:EXEC_IDX_ACTChar] intValue]];
                } 
                
                char *EXEC_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 13);
                if(EXEC_IDX_PLNChar)
                {    
                    EXEC_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:EXEC_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *INTSTY_IDX_ACT = nil;
                NSNumber *INTSTY_IDX_PLN = nil;
                char *INTSTY_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 14);
                if(INTSTY_IDX_ACTChar)
                {    
                    INTSTY_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:INTSTY_IDX_ACTChar] intValue]];
                } 
                
                char *INTSTY_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 15);
                if(INTSTY_IDX_PLNChar)
                {    
                    INTSTY_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:INTSTY_IDX_PLNChar] intValue]];
                }    
                
                DOBrand *brandDO = nil;
                DORegion *regionDO = nil;
                //Get Brand Detail
                NSNumber *brandID = nil;
                char *brandIDChar = (char *)sqlite3_column_text(compiledStatement, 18);
                if(brandIDChar)
                {    
                    brandID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:brandIDChar] intValue]];
                    
                    brandDO = [[self.brands filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.brandID=%d", [brandID intValue]]] lastObject];                    
                }  
                else
                {
                 //   NSLog(@"Dhana");
                }
                
                //Get Region Detail
                NSNumber *regionID = nil;
                char *regionIDChar = (char *)sqlite3_column_text(compiledStatement, 19);
                if(regionIDChar)
                {    
                    regionID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:regionIDChar] intValue]];
                    
                    
                    regionDO = [[self.regions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionID=%d", [regionID intValue]]] lastObject];                    
                }                  
                
                NSNumber *PLN_SLS = nil;
                NSNumber *ACT_SLS = nil;
                char *PLN_SLSChar = (char *)sqlite3_column_text(compiledStatement,20);
                if(PLN_SLSChar)
                {    
                    PLN_SLS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:PLN_SLSChar] intValue]];
                } 
                
                char *ACT_SLSChar = (char *)sqlite3_column_text(compiledStatement, 21);
                if(ACT_SLSChar)
                {    
                    ACT_SLS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACT_SLSChar] intValue]];
                } 
                
                


                
                DOBrandPerf *brandPerf = [[DOBrandPerf alloc] init];
                brandPerf.healthAct = BRND_HTH_IDX_ACT;
                brandPerf.healthPln = BRND_HTH_IDX_PLN;
                brandPerf.durabAct = DURBL_IDX_ACT;
                brandPerf.durabPln = DURBL_IDX_PLN;
                brandPerf.adapAct = ADPT_IDX_ACT;
                brandPerf.adapPln = ADPT_IDX_PLN;
                brandPerf.socialBuzz = SCL_BUZZ_IDX_ACT;
                //brandPerf.SCL_BUZZ_IDX_PLN = SCL_BUZZ_IDX_PLN;
                brandPerf.accessAct = ACSS_IDX_ACT;
                brandPerf.accessPln = ACSS_IDX_PLN;
                brandPerf.finAct = FIN_IDX_ACT;
                brandPerf.finPln = FIN_IDX_PLN;
                brandPerf.execAct = EXEC_IDX_ACT;
                brandPerf.execPln = EXEC_IDX_PLN;
                brandPerf.intensityAct = INTSTY_IDX_ACT;
                brandPerf.intensityPln = INTSTY_IDX_PLN;
                brandPerf.salesAct = PLN_SLS;
                brandPerf.salesPln = ACT_SLS;  
                brandPerf.timid = timID;
                brandPerf.doRegion = regionDO;
                brandPerf.doBrand = brandDO;
                
                [returnArray addObject:brandPerf];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);        
    return returnArray;      
    
}

-(NSArray *)getBrandPerformancesForPeriod:(NSNumber *)timID andBrand:(NSNumber *)brandID
{
    /*
     SELECT
     BRAND_PERFORMANCE.BRND_HTH_IDX_ACT,
     BRAND_PERFORMANCE.BRND_HTH_IDX_PLN,
     BRAND_PERFORMANCE.DURBL_IDX_ACT,
     BRAND_PERFORMANCE.DURBL_IDX_PLN,
     BRAND_PERFORMANCE.ADPT_IDX_ACT,
     BRAND_PERFORMANCE.ADPT_IDX_PLN,
     BRAND_PERFORMANCE.SCL_BUZZ_IDX_ACT,
     BRAND_PERFORMANCE.SCL_BUZZ_IDX_PLN,
     BRAND_PERFORMANCE.ACSS_IDX_ACT,
     BRAND_PERFORMANCE.ACSS_IDX_PLN,
     BRAND_PERFORMANCE.FIN_IDX_ACT,
     BRAND_PERFORMANCE.FIN_IDX_PLN,
     BRAND_PERFORMANCE.EXEC_IDX_ACT,
     BRAND_PERFORMANCE.EXEC_IDX_PLN,
     BRAND_PERFORMANCE.INTSTY_IDX_ACT,
     BRAND_PERFORMANCE.INTSTY_IDX_PLN,
     BRAND_PERFORMANCE.AVG_NRx_TGT_PSC,
     BRAND_PERFORMANCE.AVG_NRx_NON_TGT_PSC,
     FINANCE_PERFORMANCE.PLN_SLS,
     FINANCE_PERFORMANCE.ACT_SLS
     FROM
     BRAND_PERFORMANCE INNER JOIN FINANCE_PERFORMANCE
     ON
     BRAND_PERFORMANCE.BRANDID = FINANCE_PERFORMANCE.BRANDID AND
     BRAND_PERFORMANCE.REGIONID = FINANCE_PERFORMANCE.REGIONID AND       
     BRAND_PERFORMANCE.TIMID= FINANCE_PERFORMANCE.TIMID  
     */
    
    if(timID == nil)
    {
        timID = [NSNumber numberWithInt:1];
    }
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    //Fetch National Performance when region ID is initial;
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All regions
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"SELECT BRAND_PERFORMANCE.BRND_HTH_IDX_ACT,BRAND_PERFORMANCE.BRND_HTH_IDX_PLN,BRAND_PERFORMANCE.DURBL_IDX_ACT,BRAND_PERFORMANCE.DURBL_IDX_PLN,BRAND_PERFORMANCE.ADPT_IDX_ACT,BRAND_PERFORMANCE.ADPT_IDX_PLN,BRAND_PERFORMANCE.SCL_BUZZ_IDX_ACT,BRAND_PERFORMANCE.SCL_BUZZ_IDX_PLN,BRAND_PERFORMANCE.ACSS_IDX_ACT,BRAND_PERFORMANCE.ACSS_IDX_PLN,BRAND_PERFORMANCE.FIN_IDX_ACT,BRAND_PERFORMANCE.FIN_IDX_PLN,BRAND_PERFORMANCE.EXEC_IDX_ACT,BRAND_PERFORMANCE.EXEC_IDX_PLN,BRAND_PERFORMANCE.INTSTY_IDX_ACT,BRAND_PERFORMANCE.INTSTY_IDX_PLN,BRAND_PERFORMANCE.AVG_NRx_TGT_PSC,BRAND_PERFORMANCE.AVG_NRx_NON_TGT_PSC, BRAND_PERFORMANCE.BRANDID,BRAND_PERFORMANCE.REGIONID, FINANCE_PERFORMANCE.PLN_SLS,FINANCE_PERFORMANCE.ACT_SLS FROM BRAND_PERFORMANCE INNER JOIN FINANCE_PERFORMANCE ON BRAND_PERFORMANCE.BRANDID = FINANCE_PERFORMANCE.BRANDID AND BRAND_PERFORMANCE.REGIONID = FINANCE_PERFORMANCE.REGIONID AND BRAND_PERFORMANCE.TIMID= FINANCE_PERFORMANCE.TIMID"];
        
        [sqlString appendFormat:@" where brand_performance.TIMID = %d AND brand_performance.brandid = %d", [timID intValue], [brandID intValue]];        
        [sqlString appendString:@" order by brand_performance.brandid"];
       // NSLog(@"sqlString : %@",sqlString);
        /*  
         NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"select execution_index.PCT_RCH_PLN , execution_index.PCT_RCH_ACT , execution_index.FREQ_PLN , execution_index.FREQ_ACT , execution_index.SMP_ALLOC_PER_PLN , execution_index.SMP_ALLOC_PER_ACT , execution_index.regionid from execution_index"];
         
         [sqlString appendFormat:@" where execution_index.brandid = %d and execution_index.timid = %d", [brandID intValue], [timID intValue]];        
         [sqlString appendString:@" order by execution_index.regionid"];
         */
        // Fetch All Brands
		const char *sqlStatement = [sqlString UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                // Target Reached
                NSNumber *BRND_HTH_IDX_ACT = nil;
                NSNumber *BRND_HTH_IDX_PLN = nil;
                
                char *BRND_HTH_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 0);
                if(BRND_HTH_IDX_ACTChar)
                {    
                    BRND_HTH_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:BRND_HTH_IDX_ACTChar] intValue]];
                } 
                
                char *BRND_HTH_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 1);
                if(BRND_HTH_IDX_PLNChar)
                {    
                    BRND_HTH_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:BRND_HTH_IDX_PLNChar] intValue]];
                } 
                
                
                NSNumber *DURBL_IDX_ACT = nil;
                NSNumber *DURBL_IDX_PLN = nil;
                char *DURBL_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(DURBL_IDX_ACTChar)
                {    
                    DURBL_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:DURBL_IDX_ACTChar] intValue]];
                } 
                
                char *DURBL_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(DURBL_IDX_PLNChar)
                {    
                    DURBL_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:DURBL_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *ADPT_IDX_ACT = nil;
                NSNumber *ADPT_IDX_PLN = nil;
                char *ADPT_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(ADPT_IDX_ACTChar)
                {    
                    ADPT_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ADPT_IDX_ACTChar] intValue]];
                } 
                
                char *ADPT_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 5);
                if(ADPT_IDX_PLNChar)
                {    
                    ADPT_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ADPT_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *SCL_BUZZ_IDX_ACT = nil;
                NSNumber *SCL_BUZZ_IDX_PLN = nil;
                char *SCL_BUZZ_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 6);
                if(SCL_BUZZ_IDX_ACTChar)
                {    
                    SCL_BUZZ_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SCL_BUZZ_IDX_ACTChar] intValue]];
                } 
                
                char *SCL_BUZZ_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(SCL_BUZZ_IDX_PLNChar)
                {    
                    SCL_BUZZ_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SCL_BUZZ_IDX_PLNChar] intValue]];
                }                 
                
                NSNumber *ACSS_IDX_ACT = nil;
                NSNumber *ACSS_IDX_PLN = nil;
                char *ACSS_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 8);
                if(ACSS_IDX_ACTChar)
                {    
                    ACSS_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACSS_IDX_ACTChar] intValue]];
                } 
                
                char *ACSS_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 9);
                if(ACSS_IDX_PLNChar)
                {    
                    ACSS_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACSS_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *FIN_IDX_ACT = nil;
                NSNumber *FIN_IDX_PLN = nil;
                char *FIN_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 10);
                if(FIN_IDX_ACTChar)
                {    
                    FIN_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FIN_IDX_ACTChar] intValue]];
                } 
                
                char *FIN_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 11);
                if(FIN_IDX_PLNChar)
                {    
                    FIN_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FIN_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *EXEC_IDX_ACT = nil;
                NSNumber *EXEC_IDX_PLN = nil;
                char *EXEC_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 12);
                if(EXEC_IDX_ACTChar)
                {    
                    EXEC_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:EXEC_IDX_ACTChar] intValue]];
                } 
                
                char *EXEC_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 13);
                if(EXEC_IDX_PLNChar)
                {    
                    EXEC_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:EXEC_IDX_PLNChar] intValue]];
                } 
                
                NSNumber *INTSTY_IDX_ACT = nil;
                NSNumber *INTSTY_IDX_PLN = nil;
                char *INTSTY_IDX_ACTChar = (char *)sqlite3_column_text(compiledStatement, 14);
                if(INTSTY_IDX_ACTChar)
                {    
                    INTSTY_IDX_ACT = [NSNumber numberWithInt:[[NSString stringWithUTF8String:INTSTY_IDX_ACTChar] intValue]];
                } 
                
                char *INTSTY_IDX_PLNChar = (char *)sqlite3_column_text(compiledStatement, 15);
                if(INTSTY_IDX_PLNChar)
                {    
                    INTSTY_IDX_PLN = [NSNumber numberWithInt:[[NSString stringWithUTF8String:INTSTY_IDX_PLNChar] intValue]];
                }    
                
                DOBrand *brandDO = nil;
                DORegion *regionDO = nil;
                //Get Brand Detail
                NSNumber *brandID = nil;
                char *brandIDChar = (char *)sqlite3_column_text(compiledStatement, 18);
                if(brandIDChar)
                {    
                    brandID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:brandIDChar] intValue]];
                    
                    brandDO = [[self.brands filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.brandID=%d", [brandID intValue]]] lastObject];                    
                }  
                else
                {
                 //   NSLog(@"Dhana");
                }
                
                //Get Region Detail
                NSNumber *regionID = nil;
                char *regionIDChar = (char *)sqlite3_column_text(compiledStatement, 19);
                if(regionIDChar)
                {    
                    regionID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:regionIDChar] intValue]];
                    
                    
                    regionDO = [[self.regions filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionID=%d", [regionID intValue]]] lastObject];                    
                }                  
                
                NSNumber *PLN_SLS = nil;
                NSNumber *ACT_SLS = nil;
                char *PLN_SLSChar = (char *)sqlite3_column_text(compiledStatement,20);
                if(PLN_SLSChar)
                {    
                    PLN_SLS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:PLN_SLSChar] intValue]];
                } 
                
                char *ACT_SLSChar = (char *)sqlite3_column_text(compiledStatement, 21);
                if(ACT_SLSChar)
                {    
                    ACT_SLS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:ACT_SLSChar] intValue]];
                } 
                
                
                
                
                
                DOBrandPerf *brandPerf = [[DOBrandPerf alloc] init];
                brandPerf.healthAct = BRND_HTH_IDX_ACT;
                brandPerf.healthPln = BRND_HTH_IDX_PLN;
                brandPerf.durabAct = DURBL_IDX_ACT;
                brandPerf.durabPln = DURBL_IDX_PLN;
                brandPerf.adapAct = ADPT_IDX_ACT;
                brandPerf.adapPln = ADPT_IDX_PLN;
                brandPerf.socialBuzz = SCL_BUZZ_IDX_ACT;
                //brandPerf.SCL_BUZZ_IDX_PLN = SCL_BUZZ_IDX_PLN;
                brandPerf.accessAct = ACSS_IDX_ACT;
                brandPerf.accessPln = ACSS_IDX_PLN;
                brandPerf.finAct = FIN_IDX_ACT;
                brandPerf.finPln = FIN_IDX_PLN;
                brandPerf.execAct = EXEC_IDX_ACT;
                brandPerf.execPln = EXEC_IDX_PLN;
                brandPerf.intensityAct = INTSTY_IDX_ACT;
                brandPerf.intensityPln = INTSTY_IDX_PLN;
                brandPerf.salesAct = PLN_SLS;
                brandPerf.salesPln = ACT_SLS;  
                brandPerf.timid = timID;
                brandPerf.doRegion = regionDO;
                brandPerf.doBrand = brandDO;
                
                [returnArray addObject:brandPerf];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);        
    return returnArray; 
}

-(NSMutableArray *)getAllBrands
{
    //gaurav
//    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithObjects:[[DOBrand alloc]initWithBrandID:[NSNumber numberWithInt:0] brandDesc:@"Overall"], nil];
//    [returnArray addObjectsFromArray:self.brands];
//    return returnArray;
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithArray:self.brands];
    return returnArray;
}

-(NSMutableArray *)getAllPeriods
{
    return [NSMutableArray arrayWithArray:self.times];
}


//gaurav
-(NSArray *)getBrandSocialPerformance:(NSNumber *)brandID{
    
    // Setup the database object
	sqlite3 *database;
    
	// Init the Region and State Array
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    //Fetch National Performance when region ID is initial;
    
	// Open the database from the users filessytem
	if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK) {
		
        // Fetch All social response data
		NSMutableString *sqlString = [[NSMutableString alloc] initWithString: @"SELECT SOCIAL_RESPONSE.RSK_FLG,SOCIAL_RESPONSE.FACEBOOK_POS,SOCIAL_RESPONSE.TWITTER_POS,SOCIAL_RESPONSE.YOU_TUBE_POST,SOCIAL_RESPONSE.BLOG_POS,SOCIAL_RESPONSE.SEN_RECH,SOCIAL_RESPONSE.SEN_STRNTH,SOCIAL_RESPONSE.BRANDID FROM SOCIAL_RESPONSE"];
        
        [sqlString appendFormat:@" where social_response.brandid = %d", [brandID intValue]];        
        [sqlString appendString:@" order by social_response.brandid"];
        //NSLog(@"sqlString : %@",sqlString);
        
        
		const char *sqlStatement = [sqlString UTF8String];
        
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
                // Target Reached
                NSNumber *RISK_FLG = nil;
                NSNumber *FACEBOOK_POS = nil;
                
                char *RISK_FLGChar = (char *)sqlite3_column_text(compiledStatement, 0);
                if(RISK_FLGChar)
                {    
                    RISK_FLG = [NSNumber numberWithInt:[[NSString stringWithUTF8String:RISK_FLGChar] intValue]];
                } 
                
                char *FACEBOOK_POSChar = (char *)sqlite3_column_text(compiledStatement, 1);
                if(FACEBOOK_POSChar)
                {    
                    FACEBOOK_POS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:FACEBOOK_POSChar] intValue]];
                } 
                
                
                NSNumber *TWITTER_POS = nil;
                NSNumber *YOU_TUBE_POST = nil;
                NSNumber *BLOG_POS = nil;
                
                char *TWITTER_POSChar = (char *)sqlite3_column_text(compiledStatement, 2);
                if(TWITTER_POSChar)
                {    
                    TWITTER_POS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:TWITTER_POSChar] intValue]];
                } 
                
                char *YOU_TUBE_POSTChar = (char *)sqlite3_column_text(compiledStatement, 3);
                if(YOU_TUBE_POSTChar)
                {    
                    YOU_TUBE_POST = [NSNumber numberWithInt:[[NSString stringWithUTF8String:YOU_TUBE_POSTChar] intValue]];
                } 
                
                char *BLOG_POSChar = (char *)sqlite3_column_text(compiledStatement, 4);
                if(BLOG_POSChar)
                {    
                    BLOG_POS = [NSNumber numberWithInt:[[NSString stringWithUTF8String:BLOG_POSChar] intValue]];
                } 
                
                NSNumber *SEN_RECH = nil;
                NSNumber *SEN_STRNTH = nil;
                char *SEN_RECHChar = (char *)sqlite3_column_text(compiledStatement, 5);
                if(SEN_RECHChar)
                {    
                    SEN_RECH = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SEN_RECHChar] intValue]];
                } 
                
                char *SEN_STRNTHChar = (char *)sqlite3_column_text(compiledStatement, 6);
                if(SEN_STRNTHChar)
                {    
                    SEN_STRNTH = [NSNumber numberWithInt:[[NSString stringWithUTF8String:SEN_STRNTHChar] intValue]];
                } 
                
                DOBrand *brandDO = nil;
                //Get Brand Detail
                NSNumber *brandID = nil;
                char *brandIDChar = (char *)sqlite3_column_text(compiledStatement, 7);
                if(brandIDChar)
                {    
                    brandID = [NSNumber numberWithInt:[[NSString stringWithUTF8String:brandIDChar] intValue]];
                    
                    brandDO = [[self.brands filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.brandID=%d", [brandID intValue]]] lastObject];                    
                }  
                else
                {
                    //NSLog(@"Dhana");
                }
                
                
                DOSocialPerf *socialPerf = [[DOSocialPerf alloc] init];
                socialPerf.rskflg=RISK_FLG;
                socialPerf.facebookPos=FACEBOOK_POS;
                socialPerf.twitterPos=TWITTER_POS;
                socialPerf.youtubePos=YOU_TUBE_POST;
                socialPerf.blogPos=BLOG_POS;
                socialPerf.senRech=SEN_RECH;
                socialPerf.senStrnth=SEN_STRNTH;
                socialPerf.doBrand=brandDO;
                
                [returnArray addObject:socialPerf];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
	}
	sqlite3_close(database);        
    return returnArray; 
    
    
}


//gaurav
-(NSMutableArray *)getSocialPostsForBrand:(DOBrand *)brand  rskflag:(NSInteger)flag

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

@end
