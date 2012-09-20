//
//  RegionsTableViewCell.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 19/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegionsTableViewCell.h"
#import "DOBrandPerf.h"
#import "PerformanceView.h"
#import "PercentageProgressBar.h"

@implementation RegionsTableViewCell
@synthesize region=_region;
@synthesize performance=_performance;
@synthesize targetValue=_targetValue;
@synthesize holdView=_holdView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadDataFromEntity:(id)entity forRow:(int)row; 
{
    DOBrandPerf *bo = (DOBrandPerf *)entity;
    self.region.text = bo.doRegion.desc;
    
    int KsalesActual = [bo.salesAct longValue] / 1000;
    int KsalesPlan = [bo.salesPln longValue] / 1000;    
    //Add Actual and Target Sales;
    self.targetValue.text  = [NSString stringWithFormat:@"$%dM / $%dM",KsalesActual,KsalesPlan];
   
    ///Add progress Bar
    PercentageProgressBar *accessBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.performance.frame.size.width, self.performance.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.performance addSubview:accessBar];
    
    float performance = [bo.salesAct doubleValue]/ [bo.salesPln doubleValue];
    [accessBar setProgress:performance];   
    
    if(row != 0)
    {    
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }     
    else {
        self.holdView.layer.backgroundColor = [[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:245.0/255.0 alpha:1.0] CGColor];
    }    
          
  //  [perfView setProgress:[perfDO.salesAct doubleValue] / 100.0f]; ;
     
}

// Sets the selection style to none
- (void)drawRect:(CGRect)rect
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [super drawRect:rect];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
