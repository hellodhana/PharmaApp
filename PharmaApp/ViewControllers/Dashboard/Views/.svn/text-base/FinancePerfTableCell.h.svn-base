//
//  FinancePerfTableCell.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFAGenericTableCell.h"
#import "PerformanceView.h"
#import "PercentageProgressBar.h"
#import "DOBrandPerf.h"
#import "DORegion.h"


@interface FinancePerfTableCell : SFAGenericTableCell
{
    DORegion *_doRegion;
    IBOutlet UILabel *_region;
    IBOutlet UIView *_performanceBar;
    IBOutlet UILabel *_revenueActual;  
    IBOutlet UILabel *_revenuePlan;      
    IBOutlet UIView *_performanceCircularBar;
    IBOutlet UIView *_mrktPositionCircularBar;
    IBOutlet UIView *_holdView;
    IBOutlet UIButton *_LHI_Button;
   
    
}
@property(nonatomic, retain)  DORegion *doRegion;
@property(nonatomic, retain) UILabel *region;
@property(nonatomic, retain) UIView *performanceBar;
@property(nonatomic, retain) UIView *performanceCircularBar;
@property(nonatomic, retain) IBOutlet UIView *mrktPositionCircularBar;
@property(nonatomic, retain) UIView *holdView;
@property(nonatomic, retain) UILabel *revenueActual;  
@property(nonatomic, retain) UILabel *revenuePlan; 
@property(nonatomic, retain) UIButton *LHI_Button;



-(IBAction)lhiButtonPressed:(id)sender;

@end
