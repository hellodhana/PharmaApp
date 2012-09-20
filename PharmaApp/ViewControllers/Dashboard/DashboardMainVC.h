//
//  DashboardMainVC.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAGenericTableView.h"
#import "SFATransitionVC.h"
#import "ValueSelectTableVC.h"
#import "DOBrandPerf.h"

@protocol DashboardDelegate
-(void) navigateToPerformanceScreen;
@end

@interface DashboardMainVC : SFAAbstractVC <SFAGenericTableDelegate, UIWebViewDelegate, UIScrollViewDelegate, ValueSelectorProtocol> 
{
    IBOutlet UIView *_mainFinancePerfView;
    IBOutlet UIView *_mainBrandPerfView;
    IBOutlet UIWebView *_mainMapView;    
    
    IBOutlet UIView *_containerMapView;
    IBOutlet UIButton *_expandButton;
    IBOutlet UIView *_barMapView;
    IBOutlet UIView *_legendView;
    NSObject<DashboardDelegate> *_delegate;
    UIActivityIndicatorView *_activityIndicator;

    IBOutlet UIScrollView *_finPerfScrollView;
    IBOutlet UIPageControl *_finPerfPageCtrl;
    IBOutlet UIView *_finYTDview;
    IBOutlet UIView *_brandYTDview;
    IBOutlet UIPopoverController *_ytdPopoverController;
    IBOutlet UIPopoverController *_ytdBrandPopoverController;
    ValueSelectTableVC *_tableSelectorView;
    IBOutlet UILabel *_ytdLabel;
    IBOutlet UILabel *_ytdBrandLabel;
    //Map Specific Declarations
    BOOL _brandMode;
    NSInteger _mapMode;
    IBOutlet UISegmentedControl *_mapSegmentCtrl;
    NSArray *_brandGrowthArray;
    IBOutlet UILabel *_mapRegionlbl;
    IBOutlet UILabel *_mapGeographylbl;
    
    IBOutlet UILabel *_mapBrandlbl;
    IBOutlet UILabel *_mapGrowthlbl;   
    NSArray *_overallGrowthArray;
    IBOutlet UIView *_legendRed;
    IBOutlet UIView *_legendYellow;
    IBOutlet UIView *_legendBlue;
    IBOutlet UIView *_legendGreen; 
    int pageBeforeScrolling;
    DOBrandPerf *currentDOBrandPerf;
   
}

@property(nonatomic, retain) UIView *mainFinancePerfView;
@property(nonatomic, retain) UIView *mainBrandPerfView;
@property(nonatomic, retain) UIWebView *mainMapView;   
@property(nonatomic, retain) UIView *containerMapView;
@property(nonatomic, retain) UIButton *expandButton;
@property(nonatomic, retain) UIView *barMapView;
@property(nonatomic, retain) NSObject<DashboardDelegate> *delegate;
@property(nonatomic, retain) UIView *legendView;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property(nonatomic, retain) UIScrollView *finPerfScrollView;
@property(nonatomic, retain) UIPageControl *finPerfPageCtrl;

@property(nonatomic, retain) UIView *finYTDview;
@property(nonatomic, retain) UIView *brandYTDview;
@property(nonatomic, retain) UILabel *ytdLabel;
@property(nonatomic, retain) UILabel *ytdBrandLabel;

//Map Specific Declarations
@property(nonatomic, retain) UISegmentedControl *mapSegmentCtrl;
@property(nonatomic, retain) UILabel *mapRegionlbl;
@property(nonatomic, retain) UILabel *mapGeographylbl;
@property(nonatomic, retain) UILabel *mapBrandlbl;
@property(nonatomic, retain) UILabel *mapGrowthlbl;  

@property(nonatomic, retain) UIView *legendRed;
@property(nonatomic, retain) UIView *legendYellow;
@property(nonatomic, retain) UIView *legendBlue;
@property(nonatomic, retain) UIView *legendGreen;
@property(nonatomic, retain) UIPopoverController *ytdPopoverController;
@property(nonatomic, retain) UIPopoverController *ytdBrandPopoverController;
@property(nonatomic, retain) ValueSelectTableVC *tableSelectorView;

-(IBAction)onExpandScreen:(id)sender;
-(IBAction)onSelectDetail:(id)sender;
-(IBAction)showYTDoption:(id)sender;
-(IBAction)showBrandYTDoption:(id)sender;
- (void)refreshOnScroll:(DOBrandPerf *)entity Direction:(int)direction;
@end
