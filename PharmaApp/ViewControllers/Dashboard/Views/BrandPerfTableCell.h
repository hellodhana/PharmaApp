//
//  BrandPerfTableCell.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DOBrandPerf.h"
#import "SFAGenericTableCell.h"

@interface BrandPerfTableCell : SFAGenericTableCell
{
    IBOutlet UILabel *_brand;
    IBOutlet UIView *_performanceBar;
    IBOutlet UILabel *_actualVal;    
    IBOutlet UILabel *_targetVal;   
    IBOutlet UILabel *_percentage;  
    IBOutlet UIView *_holdView;
    IBOutlet UIView *_executionView;
    IBOutlet UIView *_socialBuzzView;
    IBOutlet UIImageView *_revenueArrow;
}

@property(nonatomic, retain) UILabel *brand;
@property(nonatomic, retain) UIView *performanceBar;
@property(nonatomic, retain) UILabel *actualVal;    
@property(nonatomic, retain) UILabel *targetVal; 
@property(nonatomic, retain) UILabel *percentage; 
@property(nonatomic, retain) UIView *holdView;
@property(nonatomic, retain) UIView *executionView;
@property(nonatomic, retain) UIView *socialBuzzView;
@property(nonatomic, retain) UIImageView *revenueArrow;
    
@end
