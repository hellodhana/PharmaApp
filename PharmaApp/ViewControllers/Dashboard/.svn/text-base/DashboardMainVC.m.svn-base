//
//  DashboardMainVC.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DashboardMainVC.h"
#import "PharmaDAO.h"
#import "FinancePerfTable.h"
#import "BrandPerfTable.h"
#import "HTMLBuilder.h"
#import "SharedData.h"
#import "DOTime.h"
#import "DOBrand.h"
#import "DAOPharma.h"
#import "DOBrandPerf.h"
#import "SharedData.h"

#define MAP_MODE_REGION 0
#define MAP_MODE_DISTRICT 1
#define MAP_MODE_TERRITORY 2
#define NOT_AVAILABLE @"N/A";

@interface DashboardMainVC()
{
    BOOL _expandMode;
    BOOL pageControlUsed;
    NSMutableArray *financeTableArray;
    int kNumberOfPages;
    NSString *mapCenter;
    
    //New Data
    NSArray *overallPerfArray;
    NSMutableArray *financePerfArray;
    NSMutableArray *brandPerfArray; 
    
    DOTime *currTime;
    DOBrand *currBrand;    
    DORegion *currRegion;
    DORegion *prevRegion;
    
    BrandPerfTable *brandPerfTable;    
}

@property(nonatomic, assign) BOOL expandMode;

- (void)loadFinancialPerformance;
- (void)loadBrandPerformance;
- (void)loadMapWithNextRegion:(BOOL)isNext;
- (void)loadScrollViewWithPage:(int)page;
- (void)initPeriodDropDownWithName:(NSString *)name andParentView:(UIView *)view;

@end
@implementation DashboardMainVC
@synthesize mainFinancePerfView=_mainFinancePerfView;
@synthesize mainBrandPerfView=_mainBrandPerfView;
@synthesize mainMapView=_mainMapView;
@synthesize containerMapView=_containerMapView;
@synthesize expandButton=_expandButton;
@synthesize expandMode=_expandMode;
@synthesize barMapView=_barMapView;
@synthesize delegate=_delegate;
@synthesize legendView=_legendView;
@synthesize activityIndicator=_activityIndicator;
@synthesize mapSegmentCtrl=_mapSegmentCtrl;
@synthesize mapBrandlbl=_mapBrandlbl;
@synthesize mapGrowthlbl=_mapGrowthlbl;
@synthesize mapRegionlbl=_mapRegionlbl;
@synthesize legendBlue=_legendBlue;
@synthesize legendGreen=_legendGreen;
@synthesize legendRed=_legendRed;
@synthesize legendYellow=_legendYellow;
@synthesize finPerfScrollView=_finPerfScrollView;
@synthesize finPerfPageCtrl=_finPerfPageCtrl;
@synthesize finYTDview=_finYTDview;
@synthesize brandYTDview=_brandYTDview;
@synthesize ytdPopoverController=_ytdPopoverController;
@synthesize ytdBrandPopoverController=_ytdBrandPopoverController;

@synthesize tableSelectorView=_tableSelectorView;
@synthesize ytdLabel=_ytdLabel;
@synthesize ytdBrandLabel=_ytdBrandLabel;
@synthesize mapGeographylbl=_mapGeographylbl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    
    
    self = [super initWithNibName:@"DashboardMainVC" bundle:[NSBundle mainBundle]];
    if (self) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[self.activityIndicator setFrame:CGRectMake(522.0, 175.0, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height)];
		[self.activityIndicator setHidesWhenStopped:YES];
		
		[self.view addSubview:self.activityIndicator];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    // Notification when keyboard appears.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    // Notification when keyboard hides.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	
    if ([self.activityIndicator isAnimating]) {
		[self.activityIndicator stopAnimating];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currBrand = [[SharedData sharedObj] doBrand];
    
    self.ytdBrandLabel.text = currBrand.brandDesc;
    //NSLog(@"selected brand = %@",currBrand.brandDesc);
    
    self.containerMapView.layer.cornerRadius = 5;    
    self.containerMapView.layer.borderWidth = 2;    
    self.containerMapView.layer.borderColor = [[UIColor grayColor] CGColor];  
    
    kNumberOfPages = 1;
    //  Set Scroll View Properties.
    self.finPerfScrollView.pagingEnabled = YES;
    self.finPerfScrollView.contentSize = CGSizeMake(self.finPerfScrollView.frame.size.width * kNumberOfPages,self.finPerfScrollView.frame.size.height);
    self.finPerfScrollView.showsHorizontalScrollIndicator = NO;
    self.finPerfScrollView.showsVerticalScrollIndicator = NO;
    self.finPerfScrollView.scrollsToTop = NO;
    self.finPerfScrollView.delegate = self;    
    
    self.finYTDview.layer.cornerRadius = 5;
    self.brandYTDview.layer.cornerRadius = 5;
    self.containerMapView.layer.borderWidth = 2;
    
    self.finPerfPageCtrl.currentPage = 0;
    self.legendBlue.backgroundColor = [SFAUtils colorWithHexString:@"#00FF00"];  
    //Load Overall Performance
    overallPerfArray = [[DAOPharma sharedDAO] getBrandPerformancesForPeriod:currTime.timID];
    
    [self loadFinancialPerformance];
    [self loadBrandPerformance];
    [self loadMapWithNextRegion:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)loadFinancialPerformance
{
    
    financePerfArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 0) AND (self.doBrand.brandID == %d)",[currBrand.brandID intValue]]]];
    
    [financePerfArray addObjectsFromArray:[NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doBrand.brandID == %d)",[currBrand.brandID intValue]]]]];
    
    FinancePerfTable *financePerfTable = [[FinancePerfTable alloc] initWithFinPerformance:financePerfArray frame:CGRectMake(0, 0, self.finPerfScrollView.frame.size.width, self.finPerfScrollView.frame.size.height) andDelegate:self];
    
    kNumberOfPages = 1;
    financeTableArray = [[NSMutableArray alloc] initWithCapacity:3];
    [financeTableArray addObject:financePerfTable];
    [financeTableArray addObject:[[UIView alloc] init]];
    [financeTableArray addObject:[[UIView alloc] init]];    
    [self loadScrollViewWithPage:0];
    //[self.mainFinancePerfView addSubview:financePerfTable];
}

- (void)loadBrandPerformance
{                                                                                                                                                                                                                    
    
    brandPerfArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 0) AND (self.doBrand != nil)"]]];    
    
    brandPerfTable = [[BrandPerfTable alloc] initWithBrandPerformance:brandPerfArray frame:CGRectMake(0,0, self.mainBrandPerfView.frame.size.width,self.mainBrandPerfView.frame.size.height) andDelegate:self];
    
    [(UIView *)[[self.mainBrandPerfView subviews] objectAtIndex:0] removeFromSuperview];
    [self.mainBrandPerfView addSubview:brandPerfTable];   
    
}
- (void)loadMapWithNextRegion:(BOOL)isNext;
{    
   
    //Load Labels
  
    DOBrandPerf *currPerf = (DOBrandPerf *)[financePerfArray objectAtIndex:0];
    self.mapRegionlbl.text = currPerf.doRegion.desc;
    int percent = ([currPerf.salesAct floatValue] / [currPerf.salesPln floatValue]) * 100;
    self.mapGrowthlbl.text = [NSString stringWithFormat:@"%d%%",percent];
    if(isNext)
    {
        NSMutableArray *mapArray = nil;
        NSString *parentReg = nil;
        if(currRegion == nil)
        {
            if(currBrand == nil || [currBrand.brandID intValue] == 0)
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doBrand == nil)"]]];
            }
            else
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doBrand.brandID == %d)", [currBrand.brandID intValue]]]];
                
            }
            
        }
        else
        {
            mapCenter = currRegion.center;
            int selectHier = [currRegion.hier intValue] + 1;
            NSString *predCondition = nil;
            NSString *predVal = nil;        
            if([currRegion.hier intValue] == 1)
            {
                predCondition = @"region";
                predVal = currRegion.region;
                parentReg=currRegion.region;
            }
            else if([currRegion.hier intValue] == 2)
            {
                predCondition = @"state";  
                predVal = currRegion.state;    
                parentReg=currRegion.state;
            }  

            
            if(currBrand == nil || [currBrand.brandID intValue] == 0)        
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == %d) AND (self.doBrand == nil) AND (self.doRegion.%@ == %@)",selectHier,predCondition, predVal]]];
            }
            else
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == %d) AND (self.doBrand.brandID == %d) AND (self.doRegion.%@ == %@)", selectHier, [currBrand.brandID intValue],predCondition, predVal]]];
            }        
            
        }
        
        [self.mainMapView loadHTMLString:[HTMLBuilder htmlForDashboardMapForFinPerfDetail:mapArray paerntReg:parentReg andCenter:mapCenter] baseURL:nil];            
    }
    else {
        
        NSMutableArray *mapArray = nil;
        NSString *parentReg = nil;
        if(currRegion == nil)
        {
            //parentReg = @"USA";
            if(currBrand == nil || [currBrand.brandID intValue] == 0)
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doBrand == nil)"]]];
            }
            else
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doBrand.brandID == %d)", [currBrand.brandID intValue]]]];
            }
        }
        else
        {
            //mapCenter = currRegion.center;
            int selectHier = [currRegion.hier intValue] + 1;
            NSString *predCondition = nil;
            NSString *predVal = nil;    
            if([currRegion.hier intValue] == 1)
            {
                predCondition = @"region";
                predVal = currRegion.region;
                parentReg=currRegion.region;
            }            
            if([currRegion.hier intValue] == 2)
            {
                predCondition = @"state";
                predVal = currRegion.state;
                parentReg=currRegion.state;
            }
            if([currRegion.hier intValue] == 3)
            {
                predCondition = @"territory";  
                predVal = currRegion.territory;
                parentReg=currRegion.territory;
            }  
            
            
            if(currBrand == nil || [currBrand.brandID intValue] == 0)
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = %d) AND (self.doBrand == nil) AND (self.doRegion.%@ = %@)",selectHier,predCondition, predVal]]];
            }
            else
            {    
                mapArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = %d) AND (self.doBrand.brandID = %d) AND (self.doRegion.%@ = %@)", selectHier, [currBrand.brandID intValue],predCondition, predVal]]];
            }        
            
        }      
        [self.mainMapView loadHTMLString:[HTMLBuilder htmlForDashboardMapForFinPerfDetail:mapArray paerntReg:parentReg andCenter:mapCenter] baseURL:nil];            
    }
    
    
}

-(IBAction)onExpandScreen:(id)sender
{
    self.expandMode = !self.expandMode;
    //[self loadMap];
}

-(void)didSelectValue:(NSString *)value forField:(UITextField *)textField
{
    textField.text = value;
    
} 


- (void)selectedEntity:(NSObject *)entity forRow:(int)row
{
  
    DOBrandPerf *selectDO = (DOBrandPerf *)entity;

    // if(selectDO.doBrand == nil)
    //{
    if(row!=0){
        
       
        //Add initial Object
        if([selectDO.doRegion.hier intValue] < 3)
        {
            prevRegion=currRegion;
            currRegion = selectDO.doRegion;
            
            currentDOBrandPerf = selectDO;
            
            financePerfArray = [NSMutableArray arrayWithObject:selectDO];        
            if ([selectDO.doRegion.hier intValue] == 1) {
                [financePerfArray addObjectsFromArray:[NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = 2) AND (self.doBrand = nil) AND(self.doRegion.region = %@)", selectDO.doRegion.region]]]];     
                
                //brandPerfArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = 1) AND (self.doBrand != nil) AND (self.doRegion.region = %@)",selectDO.doRegion.region]]];      
                
                self.mapGeographylbl.text=@"Region: ";            
            }
            else if ([selectDO.doRegion.hier intValue] == 2) {
                [financePerfArray addObjectsFromArray:[NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = 3) AND (self.doBrand = nil) AND(self.doRegion.state = %@)", selectDO.doRegion.state]]]];   
                
                //brandPerfArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = 2) AND (self.doBrand != nil) AND (self.doRegion.state = %@)",selectDO.doRegion.state]]];       
                
                self.mapGeographylbl.text=@"State: ";            
            } 
            
            //Scroll
            kNumberOfPages = kNumberOfPages + 1;
            
            FinancePerfTable *financePerfTable = [[FinancePerfTable alloc] initWithFinPerformance:financePerfArray frame:CGRectMake(0, 0, self.finPerfScrollView.frame.size.width, self.finPerfScrollView.frame.size.height) andDelegate:self];
            
            //Remove Old View
            UIView *oldView = [financeTableArray objectAtIndex:[selectDO.doRegion.hier intValue]];
            if(oldView)
            {
                [oldView removeFromSuperview];
            }
            
            [financeTableArray replaceObjectAtIndex:[selectDO.doRegion.hier intValue] withObject:financePerfTable];
            
            self.finPerfScrollView.contentSize = CGSizeMake(self.finPerfScrollView.frame.size.width * kNumberOfPages, self.finPerfScrollView.frame.size.height);            
            self.finPerfPageCtrl.currentPage = kNumberOfPages - 1;
            CGRect frame = self.finPerfScrollView.frame;
            frame.origin.x = frame.size.width * self.finPerfPageCtrl.currentPage;
            frame.origin.y = 41;
            [self.finPerfScrollView scrollRectToVisible:frame animated:YES];   
            
            [self loadMapWithNextRegion:YES];
        }
        else {
           // brandPerfArray = [NSMutableArray arrayWithArray:[overallPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier = 3) AND (self.doBrand != nil) AND (self.doRegion.territory = %@)",selectDO.doRegion.territory]]];       
            
            //self.mapGeographylbl.text=@"Territory: ";   
        }
        //Load Brand Performance Data          
      //  [brandPerfTable.genericTable reloadData:brandPerfArray];
    }
    //    }
    //    else 
    //    {
    //        //Move to next Screen
    //        SharedData *sharedObject = [SharedData sharedObj];
    //        sharedObject.doBrand = selectDO.doBrand;
    //        sharedObject.doRegion = currRegion;
    //        sharedObject.doTime = currTime;
    //        //NSLog(@"%d",[currRegion.regionID intValue]);
    //        
    //        
    //        [self.delegate navigateToPerformanceScreen];
    //    }
}


- (void)refreshOnScroll:(DOBrandPerf *)entity Direction:(int)direction
{
    //DOBrandPerf *selectDO = (DOBrandPerf *)entity;
    //Add initial Object
    
     NSLog(@"self.finPerfPageCtrl.currentPage :%d",self.finPerfPageCtrl.currentPage);
    if(self.finPerfPageCtrl.currentPage  < 4)
    {
        if(self.finPerfPageCtrl.currentPage ==1 || self.finPerfPageCtrl.currentPage ==2){
            self.mapGeographylbl.text=@"Region: ";
        }
        else if(self.finPerfPageCtrl.currentPage ==3) {
            self.mapGeographylbl.text=@"State: ";
        }
              
        
        FinancePerfTable *fpTable= [financeTableArray objectAtIndex:self.finPerfPageCtrl.currentPage];
        
        DOBrandPerf *currPerf = [fpTable.financialPerf objectAtIndex:0];
    
        prevRegion=currRegion;
        
        if(self.finPerfPageCtrl.currentPage==0)
        {
            currRegion = nil;
        }else {
            currRegion = currPerf.doRegion;
        }
        currentDOBrandPerf = currPerf;
        
        [self loadMapWithNextRegion:YES];
        
        NSLog(@"region :%@",currPerf.doRegion.desc);
        self.mapRegionlbl.text = currPerf.doRegion.desc;
        int percent = ([currPerf.salesAct floatValue] / [currPerf.salesPln floatValue]) * 100;
        self.mapGrowthlbl.text = [NSString stringWithFormat:@"%d%%",percent];


        
    }
      
    
}


- (void)activityIndicatorStart {
	[self.activityIndicator setHidden:NO];
	[self.activityIndicator startAnimating];
}

- (void)activityIndicatorStop {
	[self.activityIndicator stopAnimating];
}

//UIWebViewDelegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self performSelectorInBackground:@selector(activityIndicatorStart) withObject:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(!webView.loading)
    {    
        self.activityIndicator.hidden = YES; 
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // NSLog(@"%@",[request.URL scheme]);
    // NSLog(@"%@",[request.URL host]);
    if ([[request.URL scheme] isEqual:@"myapp"]) {
        //        if ([[request.URL host] isEqual:@"mapClicked"]) {
        //            
        //            self.mapGrowthlbl.text = NOT_AVAILABLE;
        //            NSString *selectedReg = [webView stringByEvaluatingJavaScriptFromString:
        //                                     @"document.getElementById('sel_reg').value"];
        //            if(selectedReg)
        //            {
        //                self.mapRegionlbl.text = selectedReg;
        //                
        //                if (self.brandMode) {
        //                    self.selectedMapEntry = [[self.brandGrowthArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.region=%@", selectedReg]] lastObject];
        //                    
        //                    if(self.selectedMapEntry)
        //                    {
        //                        self.mapRegionlbl.text = self.selectedMapEntry.regionTxt;
        //                        //    self.mapGrowthlbl.text = [NSString stringWithFormat:@"%@%%h3", self.selectedMapEntry.performance];
        //                        self.mapGrowthlbl.text = [NSString stringWithFormat:@"%d%%($%@M)",[self.selectedMapEntry.performance intValue], [self.selectedMapEntry.revenue stringValue]];
        //                        
        //                    }
        //                }    
        //                else {
        //                    BrandPerfRegionDO *selectedDO = [[overallMinArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.region=%@", selectedReg]] lastObject];
        //                    
        //                    if(selectedDO)
        //                    {
        //                        if(([selectedDO.hierarchy intValue] == 1) || ([selectedDO.hierarchy intValue] == 2)){
        //                            self.mapGeographylbl.text=@"Region: ";
        //                        }
        //                        else if([selectedDO.hierarchy intValue] == 3){
        //                            self.mapGeographylbl.text=@"State: ";
        //                        }
        //                        else if([selectedDO.hierarchy intValue] == 4){
        //                            self.mapGeographylbl.text=@"Territory: ";
        //                        }
        //                        
        //                        self.mapRegionlbl.text = selectedDO.regionTxt;
        //                        //   self.mapGrowthlbl.text = [NSString stringWithFormat:@"%@%%h4", selectedDO.performance];
        //                        self.mapGrowthlbl.text = [NSString stringWithFormat:@"%d%%($%@M)",[selectedDO.performance intValue], [selectedDO.revenue stringValue]];
        //                        
        //                    }
        //                }
        //            }
        //        }
        //        if ([[request.URL host] isEqual:@"zoomChanged"]) {
        //            NSString *zoomLevelstr = [webView stringByEvaluatingJavaScriptFromString:
        //                                      @"document.getElementById('zoom_lvl').value"];
        //            if(zoomLevelstr)
        //            {
        //                int zoomLevel = [zoomLevelstr intValue];
        //                if(zoomLevel <= 3)
        //                {
        //                    self.mapSegmentCtrl.selectedSegmentIndex = MAP_MODE_REGION;
        //                }
        //                else if (zoomLevel == 4) {
        //                    
        //                    self.mapSegmentCtrl.selectedSegmentIndex = MAP_MODE_DISTRICT;
        //                }
        //                else {
        //                    
        //                    self.mapSegmentCtrl.selectedSegmentIndex = MAP_MODE_TERRITORY;
        //                }
        //            }
        //            
        //        }    
        return NO; // Tells the webView not to load the URL
    }
    else {
        return YES; // Tells the webView to go ahead and load the URL
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

//UIScrollViewDelegate Methods

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    UIView *financeTableView = [financeTableArray objectAtIndex:page];
    CGRect frame = self.finPerfScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 41;
    financeTableView.frame = frame;
    [self.finPerfScrollView addSubview:financeTableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.finPerfScrollView.frame.size.width;
    int page = floor((self.finPerfScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.finPerfPageCtrl.currentPage = page;
    
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    //[self loadScrollViewWithPage:page + 1];
    
    kNumberOfPages = self.finPerfPageCtrl.currentPage + 1;
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageBeforeScrolling =self.finPerfPageCtrl.currentPage;
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"self.finPerfPageCtrl.currentPage :%d || pageBeforeScrolling:%d",self.finPerfPageCtrl.currentPage,pageBeforeScrolling);
    if(self.finPerfPageCtrl.currentPage !=pageBeforeScrolling){
        pageControlUsed = NO;
        if([currRegion.hier intValue]==2){
            currRegion=prevRegion;
        }
        else if([currRegion.hier intValue]==1){
            currRegion=nil;
        }
        
        if(currentDOBrandPerf){
            // [self loadMapWithNextRegion:YES];
            if(self.finPerfPageCtrl.currentPage >pageBeforeScrolling)
                [self refreshOnScroll:currentDOBrandPerf Direction:1 ];
            else {
                [self refreshOnScroll:currentDOBrandPerf Direction:0 ];
            }
            
        }
    }
}

-(IBAction)showYTDoption:(id)sender
{
    UIView *senderView = (UIButton *)sender;
    
    NSMutableArray *keys = [[DAOPharma sharedDAO] getAllPeriods];
    
    if (!self.tableSelectorView) {
        self.tableSelectorView = [[ValueSelectTableVC alloc] initWithValues:keys andSender:self.ytdLabel];
    } else {
        [self.tableSelectorView reloadTableValues:keys andSender:self.ytdLabel];
    }
    self.tableSelectorView.delegate = self;
    if (!self.ytdPopoverController) {
        self.ytdPopoverController = [[UIPopoverController alloc] 
                                     initWithContentViewController:self.tableSelectorView];               
    }
    [self.ytdPopoverController presentPopoverFromRect:senderView.frame inView:senderView.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];    
}

-(IBAction)showBrandYTDoption:(id)sender
{
    UIView *senderView = (UIButton *)sender;
    
    NSMutableArray *keys = [[DAOPharma sharedDAO] getAllBrands];
    
    if (!self.tableSelectorView) {
        self.tableSelectorView = [[ValueSelectTableVC alloc] initWithValues:keys andSender:self.ytdBrandLabel];
    } else {
        [self.tableSelectorView reloadTableValues:keys andSender:self.ytdBrandLabel];
    }
    self.tableSelectorView.delegate = self;
    if (!self.ytdBrandPopoverController) {
        self.ytdBrandPopoverController = [[UIPopoverController alloc] 
                                          initWithContentViewController:self.tableSelectorView];               
    }
    [self.ytdBrandPopoverController presentPopoverFromRect:senderView.frame inView:senderView.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];    
}

- (void)valueSelected:(DOValueSelect *)valueDO forSender:(NSObject *)sender
{
    UILabel *senderLbl = (UILabel *)sender;
    senderLbl.text = [valueDO getValueSelectDescription];
    
    //Change based on valueDO
    if([valueDO isKindOfClass:[DOTime class]])
    {
        kNumberOfPages = 1;
        self.finPerfPageCtrl.currentPage = 0;
        self.finPerfScrollView.pagingEnabled = YES;
        self.finPerfScrollView.contentSize = CGSizeMake(self.finPerfScrollView.frame.size.width * kNumberOfPages,     self.finPerfScrollView.frame.size.height);
        
        currTime = (DOTime *)valueDO; 
        currRegion = nil;
        overallPerfArray = [[DAOPharma sharedDAO] getBrandPerformancesForPeriod:currTime.timID];
        
        NSArray *financeSubViews = [self.finPerfScrollView subviews];
        
        for (UIView *subView in financeSubViews) {
            [subView removeFromSuperview]; 
        }
        [self loadFinancialPerformance];
        [self loadBrandPerformance];
        [self loadMapWithNextRegion:YES];        
    }
    else if([valueDO isKindOfClass:[DOBrand class]])
    {
        currBrand = (DOBrand *)valueDO;
        [self loadMapWithNextRegion:NO];
    }
    
    [self.ytdPopoverController dismissPopoverAnimated:YES];
    [self.ytdBrandPopoverController dismissPopoverAnimated:YES];
}

-(void) regionSelected:(DORegion *)doRegion{
    
    SharedData *sharedObject = [SharedData sharedObj];
    sharedObject.doBrand = currBrand;
    sharedObject.doRegion = doRegion;
    sharedObject.doTime = currTime;
    //  NSLog(@"%d",[currRegion.regionID intValue]);
    
    
    [self.delegate navigateToPerformanceScreen];
    
}

@end
