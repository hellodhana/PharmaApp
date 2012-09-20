//
//  RegionsTableVC.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionBrandPerfDO.h"
#import "DOBrandPerf.h"

@protocol RegionTableDrillDelegate

-(void) willDrillDown:(DOBrandPerf *)doBrandPerf;
-(void) willDrillUp:(DOBrandPerf *)doBrandPerf;

@end
@interface RegionsTableVC : UITableViewController<UINavigationBarDelegate>
{
    DOBrandPerf *_parentBrandPerf;
    NSArray *_overAllBrandPerf;
    NSMutableArray *_currBrandPerf;
    
    NSString *_currentTitle;
	NSInteger _currentLevel;
    NSObject<RegionTableDrillDelegate> *_delegate;
    NSMutableArray *regionNameArray;
    int checkRegionName;
}

@property(nonatomic, retain) DOBrandPerf *parentBrandPerf;
@property(nonatomic, retain) NSArray *overAllBrandPerf;
@property(nonatomic, retain) NSMutableArray *currBrandPerf;
@property(nonatomic, retain) NSString *currentTitle;
@property(nonatomic, retain) NSObject<RegionTableDrillDelegate> *delegate;
@property(nonatomic, readwrite) NSInteger currentLevel;

-(IBAction) backbuttonClicked:(id)sender;
- (void)checkRegionandUpdateTable;
@end
