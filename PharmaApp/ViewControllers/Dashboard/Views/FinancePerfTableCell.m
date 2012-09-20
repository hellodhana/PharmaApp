//
//  FinancePerfTableCell.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FinancePerfTableCell.h"
#import "MBRoundProgressView.h"

@implementation FinancePerfTableCell
@synthesize region=_region;
@synthesize performanceBar=_performanceBar;
@synthesize revenueActual=_revenueActual;
@synthesize revenuePlan=_revenuePlan;
@synthesize performanceCircularBar=_performanceCircularBar;
@synthesize mrktPositionCircularBar = _mrktPositionCircularBar;
@synthesize holdView=_holdView;
@synthesize LHI_Button=_LHI_Button;
@synthesize doRegion=_doRegion;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     //   self.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}

- (void)loadDataFromEntity:(id)entity 
{
    self.holdView.layer.cornerRadius = 5;    
    self.holdView.layer.borderWidth = 2;
    self.holdView.layer.backgroundColor = [[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1.0] CGColor];
    self.holdView.layer.borderColor = [[UIColor colorWithRed:217.0/255.0 green:218.0/255.0 blue:217.0/255.0 alpha:1.0] CGColor];    
   
    
    DOBrandPerf *bo = (DOBrandPerf *)entity;
    self.doRegion=bo.doRegion;
    self.region.text = bo.doRegion.desc;
    
    int KsalesActual = [bo.salesAct longValue] / 1000;
    int KsalesPlan = [bo.salesPln longValue] / 1000;    
    //Add Actual and Target Sales;
    self.revenueActual.text = [NSString stringWithFormat:@"$%dM",KsalesActual];
    self.revenuePlan.text = [NSString stringWithFormat:@"$%dM",KsalesPlan];    
    
    ///Add progress Bar
    PercentageProgressBar *accessBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.performanceBar.frame.size.width, self.performanceBar.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.performanceBar addSubview:accessBar];
    
    float performance = [bo.salesAct doubleValue]/ [bo.salesPln doubleValue];
    [accessBar setProgress:performance];   
    
    MBRoundProgressView* rounded = [[MBRoundProgressView alloc] init];
    float execution = [bo.execAct floatValue] / [bo.execPln floatValue]; 
    [rounded setProgress:execution];
    [self.performanceCircularBar addSubview:rounded];
    
    MBRoundProgressView* rounded1 = [[MBRoundProgressView alloc] init];
    float mrktPosition = [bo.socialBuzz floatValue]; 
    [rounded1 setProgress:mrktPosition / 100.0f];
    [self.mrktPositionCircularBar addSubview:rounded1];
  
    mrktPosition=mrktPosition/100.0f;
   // NSLog(@"%f %f %f",performance,execution,(mrktPosition/10));
    float sortDesc=performance;
    if(execution<sortDesc){
        sortDesc=execution;
    }
    if(mrktPosition<sortDesc){
        sortDesc=mrktPosition;
    }
    float lhiValue=sortDesc;
    //NSLog(@"lhi : %f",lhiValue);
    self.LHI_Button.layer.cornerRadius=18;
    
    if(lhiValue>=0.95f){
        [self.LHI_Button setBackgroundColor:[UIColor colorWithRed:124.0/255.0 green:192.0/255.0 blue:18.0/255.0 alpha:1.0]];
        
    }
    else if(lhiValue>=0.85f&& lhiValue<0.95f)
    {
        
        [self.LHI_Button setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:149.0/255.0 blue:63.0/255.0 alpha:1.0]];   
    }
    else if(lhiValue<=0.85f){
       [self.LHI_Button setBackgroundColor:[UIColor colorWithRed:251.0/255.0 green:93.0/255.0 blue:125.0/255.0 alpha:1.0]];          
    }

}

- (void)loadDataFromEntity:(id)entity forRow:(int)row
{
    self.LHI_Button.tag=row;
    [self loadDataFromEntity:entity];
    if(row != 0)
    {    
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }     
    else {
        self.holdView.layer.backgroundColor = [[UIColor colorWithRed:227.0/255.0 green:228.0/255.0 blue:227.0/255.0 alpha:1.0] CGColor];
    }
    
}

-(IBAction)lhiButtonPressed:(id)sender{
   [super.delegate regionSelected:self.doRegion];
}

@end
