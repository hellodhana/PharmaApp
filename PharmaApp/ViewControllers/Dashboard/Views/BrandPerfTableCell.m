//
//  BrandPerfTableCell.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandPerfTableCell.h"
#import "PerformanceView.h"
#import "PercentageProgressBar.h"
#import "MBRoundProgressView.h"

@implementation BrandPerfTableCell
@synthesize brand=_brand;
@synthesize performanceBar=_performanceBar;
@synthesize actualVal=_actualVal;
@synthesize targetVal=_targetVal;
@synthesize holdView=_holdView;
@synthesize percentage=_percentage;
@synthesize executionView=_executionView;
@synthesize socialBuzzView=_socialBuzzView;
@synthesize revenueArrow=_revenueArrow;
 
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        

        //self.containerMapView.layer.borderColor = [[UIColor darkGrayColor] CGColor];          
    }
    return self;
}

- (void)loadDataFromEntity:(id)entity 
{
    
    self.holdView.layer.cornerRadius = 5;    
    self.holdView.layer.borderWidth = 2;
    self.holdView.layer.backgroundColor = [[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1.0] CGColor];
    self.holdView.layer.borderColor = [[UIColor colorWithRed:217.0/255.0 green:218.0/255.0 blue:217.0/255.0 alpha:1.0] CGColor];    
    
    self.holdView.layer.cornerRadius = 5;    
    self.holdView.layer.borderWidth = 2;
    self.holdView.layer.backgroundColor = [[UIColor colorWithRed:241.0/255.0 green:243.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];
    self.holdView.layer.borderColor = [[UIColor clearColor] CGColor];    
    
    DOBrandPerf *bo = (DOBrandPerf *)entity;
    self.brand.text = bo.doBrand.brandDesc;
    
    int KsalesActual = [bo.salesAct longValue] / 1000;
    int KsalesPlan = [bo.salesPln longValue] / 1000;    
    //Add Actual and Target Sales;
    self.actualVal.text = [NSString stringWithFormat:@"$%dM",KsalesActual];
    self.targetVal.text = [NSString stringWithFormat:@"$%dM",KsalesPlan];
    
    //Performance
    PercentageProgressBar *accessBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.performanceBar.frame.size.width, self.performanceBar.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.performanceBar addSubview:accessBar];
    
    float performance = [bo.salesAct doubleValue]/ [bo.salesPln doubleValue];
    [accessBar setProgress:performance];    
    
    //Execution Index
    MBRoundProgressView* roundedExe = [[MBRoundProgressView alloc] initWithFrame:CGRectMake(829.0f, 6.0f, 37.0f, 37.0f)];
    float execution = [bo.execAct floatValue] / [bo.execPln floatValue]; 
    [roundedExe setProgress:execution];
    [self.holdView addSubview:roundedExe];  
    
    //Social Buzz
    MBRoundProgressView* roundedSoc = [[MBRoundProgressView alloc] initWithFrame:CGRectMake(905.0f, 6.0f, 37.0f, 37.0f)];
    [roundedSoc setProgress:[bo.socialBuzz intValue] / 100.0f];
    [self.holdView addSubview:roundedSoc];      
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    int performanceValue=performance * 100;
    if(performanceValue<85){
        self.actualVal.textColor = [UIColor colorWithRed:207.0/255.0 green:20.0/255.0 blue:90.0/255.0 alpha:1.0];
        self.revenueArrow.image=[UIImage imageNamed:@"downArrow.png"];
    }
    else  if(performanceValue>=85 && performanceValue<=95){
         self.actualVal.textColor = [UIColor colorWithRed:216.0/255.0 green:138.0/255.0 blue:4.0/255.0 alpha:1.0];
         self.revenueArrow.image=[UIImage imageNamed:@"equalArrow.png"];
    }
    else{
           self.actualVal.textColor = [UIColor colorWithRed:74.0/255.0 green:141.0/255.0 blue:70.0/255.0 alpha:1.0];
         self.revenueArrow.image=[UIImage imageNamed:@"UpArrow.png"];
    }
 
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
}


- (void)loadDataFromEntity:(id)entity forRow:(int)row
{
    [self loadDataFromEntity:entity];
}
@end
