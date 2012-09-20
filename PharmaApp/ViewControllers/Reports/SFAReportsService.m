//
//  SFAReportsService.m
//  SFA
//
//  Created by Mitza Oyaneder on 5/19/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAReportsService.h"
#import "SharedData.h"
static SFAReportsService *sharedInstance = nil;

@implementation SFAReportsService

// Private "init" method that should only be used internally
- (id)initService
{
    self = [super init];
    if (self != nil) {
        // Custom initialization code
    }
    return self;
}

+ (SFAReportsService *)sharedInstance {
	@synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:NULL] initService];
        }
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

// IMPORTANT: override here all the "initWith…" and instance getter methods that should not be invoked directly, invalidating them.
- (id)init {
    @throw [NSException exceptionWithName: @"NotSupportedException" reason: @"This is a singleton class. No init method can be used. Use '+(MSConfirmationService *)sharedInstance' method to get the instance..." userInfo: nil];
}

#pragma mark -
#pragma mark Service methods

- (NSArray *)reports {
	NSMutableArray *data = [[NSMutableArray alloc] init];
    NSArray *titles;
    NSArray *titlesImages;
    SharedData *sharedObject = [SharedData sharedObj];        
    int row=sharedObject.PerformancebuttonTag;
    //NSLog(@"%d",row);
    
    if(row==1 || row==2 || row==3 || row==4){
        titles = [[NSArray alloc] initWithObjects: @"Adoption vs Durability", @"Adoption Network", @"Social Performance",@"Market Access",@"Execution Index",@"Durability Index",@"Intensity",@"Self Org. Map",  nil];
        titlesImages=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    }
    else if(row==5){
	titles = [[NSArray alloc] initWithObjects:@"Adoption Network", @"Intensity", @"Adoption vs Durability",  nil];
        titlesImages=[[NSArray alloc]initWithObjects:@"2",@"7",@"1", nil];
    }
    else if(row==6){
        titles = [[NSArray alloc] initWithObjects:  @"Execution Index",@"Market Access", nil];
        titlesImages=[[NSArray alloc]initWithObjects:@"5",@"4", nil];
    }
    else if(row==7){
        titles = [[NSArray alloc] initWithObjects:  @"Self Org. Map",@"Social Performance", nil];
        titlesImages=[[NSArray alloc]initWithObjects:@"8",@"3", nil];
    }
	
	for (int i=0; i<[titles count]; i++) {
        NSString *tempImageNameString = [[NSString alloc] initWithFormat:@"Report%d.png", [[titlesImages objectAtIndex:i] intValue]];
		
		NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
		[tempDict setObject:[titles objectAtIndex:i] forKey:@"title"];
		[tempDict setObject:[UIImage imageNamed:tempImageNameString] forKey:@"image"];
		
		[data addObject:tempDict];
		
	}
	
	return data;
	
}


- (void)reloadReports {
	//TODO: implement this!
}

@end
