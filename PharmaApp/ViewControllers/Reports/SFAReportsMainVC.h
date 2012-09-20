//
//  SFAReportsMainVC.h
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExecutionIndexView.h"
#import "PayerAccessView.h"
#import "AdoptionNWView.h"
#import "AdoptionDurabView.h"
#import "SocialPerformanceView.h"
#import "DurabilityIndexView.h"
#import "SelfOrgMapView.h"
#import "IntensityView.h"


@interface SFAReportsMainVC : UIViewController {
	IBOutlet UILabel *_titleLabel;
	//IBOutlet UIImageView *_graphicImageView;
	IBOutlet UIView *_borderView;
	IBOutlet UIView *_contentView;
	IBOutlet UIButton *_reloadButton;
    IBOutlet UISegmentedControl *_segMaporGraph;
    IBOutlet UIView *_regionView;
    IBOutlet UIView *_YTDView;
    IBOutlet UIView *_brandView;
    IBOutlet UILabel *_regionlbl;
    IBOutlet UILabel *_YTDlbl;
    IBOutlet UILabel *_brandlbl;
    ExecutionIndexView *executionView;
    PayerAccessView *payerView;
    AdoptionNWView *adoptionView;
    SocialPerformanceView *socialView;
    AdoptionDurabView *adoptionDuraView;
    DurabilityIndexView *durabilityIndexView;
    SelfOrgMapView *selfOrgMapView;
    IntensityView *intensityView;
}

- (void)setTitleReport:(NSString *)titleReport;
- (void)setImageReport:(UIImage *)imageReport;
- (IBAction)onReloadTouch:(id)sender;
- (IBAction)SegValueChanged:(id)sender;


@end
