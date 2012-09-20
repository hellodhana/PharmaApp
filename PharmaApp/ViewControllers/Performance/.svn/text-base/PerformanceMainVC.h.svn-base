//
//  PerformanceMainVC.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 15/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SFAGenericTableView.h"
#import "SFAAbstractVC.h"
#import "RegionsTableVC.h"
#import "BrandDO.h"
#import "ValueSelectTableVC.h"
#import "DOBrand.h"
#import "MBRoundProgressView.h"

@protocol PerformanceDelegate
-(void) navigateUsingBrand:(BrandDO *)brand;
@end

@interface PerformanceMainVC : SFAAbstractVC <RegionTableDrillDelegate, UIWebViewDelegate, ValueSelectorProtocol> 
{
    IBOutlet UIView *_contManagerView;
    IBOutlet UIView *_contFinanceView;   
    IBOutlet UIView *_contExecutionView;
    IBOutlet UIView *_contHealthView; 
    IBOutlet UIView *_contSideView;
    IBOutlet UIView *_contMainView;  
    IBOutlet UIView *_webHeaderView;
    IBOutlet UIView *_brandYTDview;
    IBOutlet UIView *_YTDview;
    IBOutlet UIView *_execView;
    IBOutlet UIView *_brandView;
    
    IBOutlet UINavigationController *_leftNavController;
    IBOutlet UILabel *_regionLbl;
    IBOutlet UILabel *_mngrLbl;
    IBOutlet UISegmentedControl *_chartCtrlType;
    IBOutlet UIWebView *_webView;
    
    IBOutlet UIView *_BubbleChartlegendView;
    IBOutlet UILabel *_execActLbl;
    IBOutlet UILabel *_healthActLbl;
    IBOutlet UIView *_bubbleButtonView;
    IBOutlet UIView *_bubbleButtonView2;
    IBOutlet UIView *_bubbleButtonView3;
    IBOutlet UIView *_bubbleButtonView4;
    
    IBOutlet UIView *_legendMap;
    IBOutlet UILabel *_legBrandlbl;
    IBOutlet UILabel *_legRegionlbl;
    IBOutlet UILabel *_legHealthlbl;
    IBOutlet UILabel *_legSociallbl;  
    
    
    IBOutlet UILabel *_salesAct;
    
    IBOutlet UILabel *_ytdLbl;
    IBOutlet UIPopoverController *_ytdPopoverController;
    ValueSelectTableVC *_tableSelectorView;
    
    DOBrand *_brand; 
    NSInteger _chartType;
    
    UIActivityIndicatorView *_activityIndicator;    
    
    NSObject<PerformanceDelegate> *_delegate;
    MBRoundProgressView* rounded;
    MBRoundProgressView* roundedBrand;
}

@property(nonatomic, retain) UIView *contManagerView;
@property(nonatomic, retain)  UIView *execView;
@property(nonatomic, retain)  UIView *brandView;
@property(nonatomic, retain) UIView *contFinanceView;   
@property(nonatomic, retain) UIView *contExecutionView;
@property(nonatomic, retain) UIView *contHealthView; 
@property(nonatomic, retain) UIView *contSideView;
@property(nonatomic, retain) UIView *brandYTDview;
@property(nonatomic, retain) UIView *YTDview;
@property(nonatomic, retain) UIView *contMainView; 
@property(nonatomic, retain) UINavigationController *leftNavController;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) NSObject<PerformanceDelegate> *delegate;
@property(nonatomic, retain) UILabel *execActLbl;
@property(nonatomic, retain) UILabel *healthActLbl;
@property(nonatomic, retain) UILabel *regionLbl;
@property(nonatomic, retain) UILabel *mngrLbl;
@property(nonatomic, retain) DOBrand *brand;
@property(nonatomic, readwrite) NSInteger chartType;
@property(nonatomic, retain) UISegmentedControl *chartCtrlType;
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) UIView *webHeaderView;
@property(nonatomic, retain) UIView *bubbleButtonView;
@property(nonatomic, retain) UIView *bubbleButtonView2;
@property(nonatomic, retain) UIView *bubbleButtonView3;
@property(nonatomic, retain) UIView *bubbleButtonView4;
@property(nonatomic, retain) UIView *BubbleChartlegendView;
@property(nonatomic, retain) UIView *legendMap;
@property(nonatomic, retain) UILabel *legBrandlbl;
@property(nonatomic, retain) UILabel *legRegionlbl;
@property(nonatomic, retain) UILabel *legHealthlbl;
@property(nonatomic, retain) UILabel *legSociallbl;
@property(nonatomic, retain) UILabel *ytdLbl;
@property(nonatomic, retain) UIPopoverController *ytdPopoverController;
@property(nonatomic, retain) ValueSelectTableVC *tableSelectorView;

@property(nonatomic, retain) UILabel *salesAct;

-(void) loadScreen;
-(void) refreshScreen;

-(id) init;

-(IBAction)toggleChart:(id)sender;
-(IBAction)inInDepthAnalysis:(id)sender;
-(IBAction)showYTDoption:(id)sender;
-(IBAction)showBrandoption:(id)sender;
@end
