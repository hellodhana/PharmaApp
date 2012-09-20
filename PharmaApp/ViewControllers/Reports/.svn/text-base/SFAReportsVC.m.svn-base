//
//  SFAReportsVC.m
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAReportsVC.h"
#import "SFAReportsMainVC.h"
#import "BrandDO.h"
#import "SharedData.h"

@interface SFAReportsVC ()
{
    BrandDO *_brand;
}

@property (nonatomic, retain) SFAReportsMainVC *reportMainView;
@property (nonatomic, retain) SFAReportsSidebarView *sidebarView;
@property (nonatomic, retain) BrandDO *brand;

@end


@implementation SFAReportsVC

@synthesize reportMainView = _reportMainView;
@synthesize sidebarView = _sidebarView;
@synthesize brand=_brand;

- (id)init {
    self = [super init];
    if (self) {
        // Custom initialization.
		self.title = SCREEN_TITLE_DEPTH_ANALYSIS;		
    }
    return self;
}

- (id)initWithBrand:(BrandDO *)brand;
{
    self = [super init];
    if (self) {
        self.title = SCREEN_TITLE_DEPTH_ANALYSIS;
        self.brand = brand;
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated {
    //Set Brand in master Frame;
    self.editButton.hidden = NO;
    self.brandLabel.hidden = NO;
    self.brandLabel.text = self.brand.brandDesc;    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    self.title = SCREEN_TITLE_DEPTH_ANALYSIS;
    self.titleLabel.font= [UIFont fontWithName:@"futura" size:(30.0)];
    
    [super viewDidLoad];
	
	CGFloat width = 180;
	
	_pagesView.frame = CGRectMake(width, 0.0, CGRectGetWidth(_pagesView.frame), CGRectGetHeight(_pagesView.frame));
    
	//Sidebar View
	SFAReportsSidebarView *aSidebarView = [[SFAReportsSidebarView alloc] initWithFrame:CGRectMake(0, 0.0, width, CGRectGetHeight(_pagesView.frame))];
	[aSidebarView setDelegate:self];
	self.sidebarView = aSidebarView;
	
	[_pagesView.superview addSubview:self.sidebarView];
	
	//Main View
	SFAReportsMainVC *aReportMainVC = [[SFAReportsMainVC alloc] init];
	[self setReportMainView:aReportMainVC];
	
	[self addView:self.reportMainView.view atRow:0 atColumn:0];
	
	//Load the first object in the reportsList array.
	if([self.sidebarView.reportsList count]>0) {
        SharedData *sharedObject = [SharedData sharedObj];        
        int PerformancebuttonTag=sharedObject.PerformancebuttonTag;
        if(PerformancebuttonTag==1){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:1]];
        }
        else if(PerformancebuttonTag==2){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:0]];
        }
        else if(PerformancebuttonTag==3){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:4]];
        }
        else if(PerformancebuttonTag==4){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:1]];
        }
        else if(PerformancebuttonTag==5){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:0]];
        }
        else if(PerformancebuttonTag==6){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:0]];
        }
        else if(PerformancebuttonTag==7){
            [self loadReport:[self.sidebarView.reportsList objectAtIndex:0]];
        }
	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)loadReport:(NSMutableDictionary *)report {
	[[self reportMainView] setTitleReport:[report objectForKey:@"title"]];
	[[self reportMainView] setImageReport:[report objectForKey:@"image"]];
}


- (void)dealloc {
    
}

@end
