//
//  PerformanceMainVC.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 15/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PerformanceMainVC.h"
#import <QuartzCore/QuartzCore.h>
#import "PharmaDAO.h"
#import "RegionsTableVC.h"
#import "HTMLBuilder.h"
#import "SharedData.h"
#import "DAOPharma.h"
#import "DOBrandPerf.h"
#import "MBRoundProgressView.h"

#define CHART_TYPE_BUBBLE 0
#define CHART_TYPE_GEO 1

@interface PerformanceMainVC()
{
    NSArray *overAllPerfArray;
    NSArray *chartArray;    
    DOBrandPerf *currBrandPerf;
}

-(void) loadChart;

@end

@implementation PerformanceMainVC
@synthesize BubbleChartlegendView=_BubbleChartlegendView;
@synthesize contManagerView=_contManagerView;
@synthesize contFinanceView=_contFinanceView;
@synthesize contHealthView=_contHealthView;
@synthesize contExecutionView=_contExecutionView;
@synthesize contSideView=_contSideView;
@synthesize contMainView=_contMainView;
@synthesize leftNavController=_leftNavController;
@synthesize brand=_brand;
@synthesize regionLbl=_regionLbl;
@synthesize mngrLbl=_mngrLbl;
@synthesize chartType=_chartType;
@synthesize chartCtrlType=_chartCtrlType;
@synthesize webView=_webView;
@synthesize webHeaderView=_webHeaderView;
@synthesize activityIndicator=_activityIndicator;
@synthesize delegate=_delegate;
@synthesize bubbleButtonView=_bubbleButtonView;
@synthesize bubbleButtonView2=_bubbleButtonView2;
@synthesize bubbleButtonView3=_bubbleButtonView3;
@synthesize bubbleButtonView4=_bubbleButtonView4;
@synthesize legBrandlbl=_legBrandlbl;
@synthesize legRegionlbl=_legRegionlbl;
@synthesize legHealthlbl=_legHealthlbl;
@synthesize legSociallbl=_legSociallbl;
@synthesize ytdLbl=_ytdLbl;
@synthesize ytdPopoverController=_ytdPopoverController;
@synthesize tableSelectorView=_tableSelectorView;
@synthesize brandYTDview=_brandYTDview;
@synthesize YTDview=_YTDview;
@synthesize salesAct=_salesAct;
@synthesize legendMap=_legendMap;
@synthesize execView=_execView;
@synthesize brandView=_brandView;
@synthesize execActLbl=_execActLbl;
@synthesize healthActLbl=_healthActLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

-(id) init
{
    self = [super init];
    if(self)
    {
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
		[self.activityIndicator setFrame:CGRectMake(512.0, 305.0, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height)];
		[self.activityIndicator setHidesWhenStopped:YES];
		
		[self.view addSubview:self.activityIndicator];
       
        self.brand = [[SharedData sharedObj] doBrand];
        self.chartType = CHART_TYPE_BUBBLE;
        self.legBrandlbl.text = self.brand.brandDesc;
        NSString *getYTD=[[[SharedData sharedObj] doTime] getValueSelectDescription];
        if(getYTD!=NULL || getYTD !=nil){
            self.ytdLbl.text = getYTD;
        }
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.contManagerView.layer.cornerRadius = 10.0f;    
    [self.contManagerView.layer setMasksToBounds:YES];
    self.contManagerView.layer.borderWidth = 2;    
    self.contManagerView.layer.borderColor = [[UIColor darkGrayColor] CGColor];    
    
    self.contFinanceView.layer.cornerRadius = 5;    
    self.contFinanceView.layer.borderWidth = 2;    
    self.contFinanceView.layer.borderColor = [[UIColor darkGrayColor] CGColor]; 
    
    self.contHealthView.layer.cornerRadius = 5;    
    self.contHealthView.layer.borderWidth = 2;    
    self.contHealthView.layer.borderColor = [[UIColor darkGrayColor] CGColor];   
    
    self.contExecutionView.layer.cornerRadius = 5;    
    self.contExecutionView.layer.borderWidth = 2;    
    self.contExecutionView.layer.borderColor = [[UIColor darkGrayColor] CGColor];  
    
   self.YTDview.layer.cornerRadius = 5;
    self.brandYTDview.layer.cornerRadius = 5;
    
    self.bubbleButtonView.layer.cornerRadius=5;
    self.bubbleButtonView.layer.borderWidth = 2;    
    self.bubbleButtonView.layer.borderColor = [[UIColor grayColor] CGColor];    
    
    self.bubbleButtonView2.layer.cornerRadius=5;
    self.bubbleButtonView2.layer.borderWidth = 2;    
    self.bubbleButtonView2.layer.borderColor = [[UIColor grayColor] CGColor];    
    
    self.bubbleButtonView3.layer.cornerRadius=5;
    self.bubbleButtonView3.layer.borderWidth = 2;    
    self.bubbleButtonView3.layer.borderColor = [[UIColor grayColor] CGColor];    
    
    self.bubbleButtonView4.layer.cornerRadius=5;
    self.bubbleButtonView4.layer.borderWidth = 2;    
    self.bubbleButtonView4.layer.borderColor = [[UIColor grayColor] CGColor];    
    
    rounded = [[MBRoundProgressView alloc] init];
    roundedBrand = [[MBRoundProgressView alloc] init];
    
    
    //[self loadLeftContainer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
       
}

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) loadScreen
{
    self.legBrandlbl.text = self.brand.brandDesc;
    NSNumber *timID = [[[SharedData sharedObj] doTime] timID];
    //self.legBrandlbl.text = [[[SharedData sharedObj] doBrand] brandDesc];
    overAllPerfArray = [[DAOPharma sharedDAO] getBrandPerformancesForPeriod:timID andBrand:self.brand.brandID];

    //Get Minimal Array;
    NSMutableArray *minimalArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 0)"]]];
    
    [minimalArray addObjectsFromArray:[NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1)"]]]];
    
    chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1)"]]];
    
    // Load left container
    RegionsTableVC *tableVC = [[RegionsTableVC alloc] initWithStyle:UITableViewStylePlain];
    tableVC.delegate = self;
    tableVC.parentBrandPerf = (DOBrandPerf *)[[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 0)"]] lastObject];
    tableVC.currBrandPerf = minimalArray;
    currBrandPerf = tableVC.parentBrandPerf;
    
    tableVC.overAllBrandPerf = overAllPerfArray;
    tableVC.currentLevel = 1;
    self.regionLbl.text=@"National";
    
    
    self.leftNavController = [[UINavigationController alloc] initWithRootViewController:tableVC];
    self.leftNavController.view.frame = CGRectMake(0, 0, self.contSideView.frame.size.width, self.contSideView.frame.size.height);
    self.leftNavController.navigationBar.frame = CGRectMake(0, 0, self.webHeaderView.frame.size.width, self.webHeaderView.frame.size.height);
    self.leftNavController.navigationBar.tintColor = self.webHeaderView.backgroundColor;    
    self.leftNavController.navigationBar.translucent = NO;
    //self.leftNavController.navigationBar.alpha = 0.0f    
    [self.contSideView addSubview:self.leftNavController.view];
    [self pushRegionTables];
    //Load other screen elements
    self.chartType = CHART_TYPE_BUBBLE;
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];    
    [self refreshScreen];
    [UIView commitAnimations];
}


-(void) pushRegionTables
{
    DORegion *currRegion = [[SharedData sharedObj] doRegion];
  //  NSLog(@"%@",currRegion.desc);
    if(currRegion == nil || [currRegion.hier intValue] == 0)
    {
        return;
    }
    
    if([currRegion.hier intValue] >= 1)
    {
        //Get Parent
        DOBrandPerf *parentBrandPerf = [[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 0)"]] lastObject];
        
        //Get Child Array
        NSMutableArray *minimalArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doRegion.region == %@)", currRegion.region]]];
        
        [minimalArray addObjectsFromArray:[NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.region == %@)", currRegion.region]]]];  
        
        //Push Region Table
        RegionsTableVC *tableVC = [[RegionsTableVC alloc] initWithStyle:UITableViewStylePlain];
        tableVC.delegate = self;
        tableVC.parentBrandPerf = parentBrandPerf;
        tableVC.currBrandPerf = minimalArray;
        currBrandPerf=[minimalArray objectAtIndex:0];
        tableVC.overAllBrandPerf = overAllPerfArray;
        tableVC.currentLevel = 2;
        self.regionLbl.text=currRegion.desc;   
        
        [self.leftNavController pushViewController:tableVC animated:NO];
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.region == %@)", currRegion.region]]];   
        
        
    }
    
    if([currRegion.hier intValue] >= 2)
    {
        //Get Parent
       
        
        DOBrandPerf *parentBrandPerf = [[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1) AND (self.doRegion.region == %@)",currRegion.region]] lastObject];
        
        //Get Child Array
        NSMutableArray *minimalArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.state == %@)", currRegion.state]]];
        
        [minimalArray addObjectsFromArray:[NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 3) AND (self.doRegion.state == %@)", currRegion.state]]]];  
        
        //Push Region Table
        RegionsTableVC *tableVC = [[RegionsTableVC alloc] initWithStyle:UITableViewStylePlain];
        tableVC.delegate = self;
        tableVC.parentBrandPerf = parentBrandPerf;
        tableVC.currBrandPerf = minimalArray;
        currBrandPerf = [minimalArray objectAtIndex:0];
        
        tableVC.overAllBrandPerf = overAllPerfArray;
        tableVC.currentLevel = 3;
        self.regionLbl.text=currRegion.desc;   
        
        [self.leftNavController pushViewController:tableVC animated:NO];
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 3) AND (self.doRegion.state == %@)", currRegion.state]]]; 
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
//            NSString *selectedReg = [webView stringByEvaluatingJavaScriptFromString:
//                                     @"document.getElementById('sel_reg').value"];
//            if(selectedReg)
//            {
//                self.legRegionlbl.text = selectedReg;
//                
//                RegionBrandPerfDO *selectedDO = [[self.regionBrandPerfDO.child filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.region=%@", selectedReg]] lastObject];
//                
//                if(selectedDO)
//                {
//                    self.legRegionlbl.text = selectedDO.regionTxt;
//                    self.legHealthlbl.text = [NSString stringWithFormat:@"%@%%", selectedDO.brandPerfDO.health];
//                    self.legSociallbl.text = [NSString stringWithFormat:@"%@%%", selectedDO.brandPerfDO.socialPos];
//                }
//            }
//        } 
        return NO; // Tells the webView not to load the URL
    }
    else {
        return YES; // Tells the webView to go ahead and load the URL
    }
    
}

-(void) willDrillDown:(DOBrandPerf *)doBrandPerf
{
    currBrandPerf = doBrandPerf;
    //NSLog(@"%@",doBrandPerf.doRegion.region);
    if ([doBrandPerf.doRegion.hier intValue] == 1) {
        self.regionLbl.text=doBrandPerf.doRegion.desc;
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.region = %@)", doBrandPerf.doRegion.region]]];
        
        [[SharedData sharedObj] setDoRegion:currBrandPerf.doRegion];        
    }
    
    else if ([doBrandPerf.doRegion.hier intValue] == 2) {
        self.regionLbl.text=doBrandPerf.doRegion.desc;
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 3) AND (self.doRegion.state = %@)", doBrandPerf.doRegion.state]]];  
        
        [[SharedData sharedObj] setDoRegion:currBrandPerf.doRegion];
          
    }  
    
   // self.regionBrandPerfDO = regionBrandPerfDO;
    [self refreshScreen];
}

-(void) willDrillUp:(DOBrandPerf *)doBrandPerf
{
    currBrandPerf = doBrandPerf;
    
    if ([doBrandPerf.doRegion.hier intValue] == 1) {
        self.regionLbl.text=doBrandPerf.doRegion.desc;
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.region = %@)", doBrandPerf.doRegion.region]]];
        
        [[SharedData sharedObj] setDoRegion:currBrandPerf.doRegion];        
    }
    
    else if ([doBrandPerf.doRegion.hier intValue] == 2) {
        self.regionLbl.text=doBrandPerf.doRegion.state;
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 3) AND (self.doRegion.state = %@)", doBrandPerf.doRegion.state]]]; 
        
        [[SharedData sharedObj] setDoRegion:currBrandPerf.doRegion];
        
    }
    else if ([doBrandPerf.doRegion.hier intValue] == 0) {
        self.regionLbl.text=@"National";
        
        chartArray = [NSMutableArray arrayWithArray:[overAllPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1)"]]];
        
        [[SharedData sharedObj] setDoRegion:currBrandPerf.doRegion];        
    }
    
    
    // self.regionBrandPerfDO = regionBrandPerfDO;
    [self refreshScreen];
}

-(void) refreshScreen
{
    //Financial Performance value on the top
    
   
    
    //NSLog(@"%@", currBrandPerf.doRegion.desc);
    float salesActual=[currBrandPerf.salesAct floatValue];
    float salesTarget=[currBrandPerf.salesPln floatValue];
    self.salesAct.text=[NSString stringWithFormat:@"$%.1fM/$%.1fM",(salesActual/1000),(salesTarget/1000)];
    float salesDivide=salesActual/salesTarget;
    if(salesDivide<0.85){
        self.salesAct.textColor = [UIColor colorWithRed:207.0/255.0 green:20.0/255.0 blue:90.0/255.0 alpha:1.0];
    }
    else  if((salesDivide>=0.85) && (salesDivide<=0.95)){
          self.salesAct.textColor = [UIColor colorWithRed:216.0/255.0 green:138.0/255.0 blue:4.0/255.0 alpha:1.0];
    }
    else{
         self.salesAct.textColor = [UIColor colorWithRed:74.0/255.0 green:141.0/255.0 blue:70.0/255.0 alpha:1.0];
    }
    //Execution Index value on the top
    float execFdivide=0.0;
    float execActual=[currBrandPerf.execAct floatValue];
    float execTarget=[currBrandPerf.execPln floatValue];
    execFdivide=(execActual/execTarget);
    self.execActLbl.text=[NSString stringWithFormat:@"%d",(int)execActual];
    
  // 
    rounded.progresslabel.text=0;
    [rounded setProgress:execFdivide];
    [self.execView addSubview:rounded]; 
    
    //Brand Health Index value on the top
    ////execFdivide=0.0;
    //float healthActual=[currBrandPerf.healthAct floatValue];
    //float healthTarget=[currBrandPerf.healthPln floatValue];
    //execFdivide=(healthActual/healthTarget);
    
    float mrktPosition = [currBrandPerf.socialBuzz floatValue]; 
    self.healthActLbl.text=[NSString stringWithFormat:@"%d",(int)mrktPosition];
    roundedBrand.progresslabel.text=0;
    [roundedBrand setProgress:mrktPosition / 100.0f];
    [self.brandView addSubview:roundedBrand]; 
   
   // self.regionLbl.text = [[[SharedData sharedObj] doRegion] desc];    
    [self loadChart];
}

-(IBAction)toggleChart:(id)sender
{

    self.chartType = self.chartCtrlType.selectedSegmentIndex;
    [self loadChart];
}

-(IBAction)inInDepthAnalysis:(id)sender
{
    SharedData *sharedObject = [SharedData sharedObj];
    sharedObject.period = self.ytdLbl.text;
    sharedObject.RegionData = self.regionLbl.text;
    sharedObject.PerformancebuttonTag=1;
    UIButton *button = (UIButton*)sender;
    sharedObject.PerformancebuttonTag = button.tag;
    
    [self.delegate navigateUsingBrand:self.brand];
}

-(void) loadChart
{
    //Draw Bubble or Geo Chart
    if(self.chartType == CHART_TYPE_BUBBLE)
    {
        self.bubbleButtonView.hidden=NO;
        self.bubbleButtonView2.hidden=NO;
        self.bubbleButtonView3.hidden=NO;
        self.bubbleButtonView4.hidden=NO;
        
        self.legendMap.hidden = YES;
        self.BubbleChartlegendView.hidden=NO;
        NSString *htmlString = [HTMLBuilder htmlForPerfBubbleChart:[HTMLBuilder dataForPerfBubbleChart:chartArray]];
        self.webView.frame=CGRectMake(0, 45, 716, 480);
        [self.webView loadHTMLString:htmlString baseURL:nil];             
    }
    else
    {
        self.bubbleButtonView.hidden=YES;
        self.bubbleButtonView2.hidden=YES;
        self.bubbleButtonView3.hidden=YES;
        self.bubbleButtonView4.hidden=YES;
        self.BubbleChartlegendView.hidden=YES;   
        self.webView.frame=CGRectMake(0, 45, 716, 510);        
        [self.webView loadHTMLString:[HTMLBuilder htmlForDashboardMapForFinPerfDetail:chartArray paerntReg:nil andCenter:currBrandPerf.doRegion.center] baseURL:nil];  
        self.legendMap.hidden=NO;
        
//        self.legendView.hidden = NO;
//        self.BubbleChartlegendView.hidden=YES;
//        self.legRegionlbl.text = self.regionBrandPerfDO.regionTxt;
//        self.legHealthlbl.text = [NSString stringWithFormat:@"%@%%", self.regionBrandPerfDO.brandPerfDO.health];
//        self.legSociallbl.text = [NSString stringWithFormat:@"%@%%", self.regionBrandPerfDO.brandPerfDO.socialPos];        
//        
//        NSMutableArray *brandRegionArray = [[NSMutableArray alloc] initWithCapacity:self.regionBrandPerfDO.child.count];
//        
//        for (RegionBrandPerfDO *regionBrandDO in self.regionBrandPerfDO.child) {
//            BrandPerfRegionDO *brandRegionDO = [[BrandPerfRegionDO alloc] initWithRegion:regionBrandDO.region regionTxt:regionBrandDO.regionTxt regionCtr:regionBrandDO.regionCtr hierarchy:regionBrandDO.regionHier performance:regionBrandDO.brandPerfDO.performance revenue:regionBrandDO.brandPerfDO.revenue health:regionBrandDO.brandPerfDO.health execution:regionBrandDO.brandPerfDO.execution socialPos:regionBrandDO.brandPerfDO.socialPos alert:regionBrandDO.brandPerfDO.alert andParentReg:regionBrandDO.parent.region];
//            
//            [brandRegionArray addObject:brandRegionDO];
//            self.webView.frame=CGRectMake(0, 45, 716, 438);
            
       // }
        
     //   NSString *htmlString = [HTMLBuilder htmlForDashboardMapForFinPerfDetail:brandRegionArray andCenter:self.regionBrandPerfDO.regionCtr];
        
     //   [self.webView loadHTMLString:htmlString baseURL:nil];        
    }
}

-(IBAction)showYTDoption:(id)sender
{
    UIView *senderView = (UIButton *)sender;
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"YTD",nil];
    [keys addObjectsFromArray:[SFAUtils getYTDMonths]];
        
    if (!self.tableSelectorView) {
        self.tableSelectorView = [[ValueSelectTableVC alloc] initWithValues:keys andSender:self.ytdLbl];
    } else {
        [self.tableSelectorView reloadTableValues:keys andSender:self.ytdLbl];
    }
    self.tableSelectorView.delegate = self;
    if (!self.ytdPopoverController) {
        self.ytdPopoverController = [[UIPopoverController alloc] 
                                     initWithContentViewController:self.tableSelectorView];               
    }
    [self.ytdPopoverController presentPopoverFromRect:senderView.frame inView:senderView.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];    
}

-(IBAction)showBrandoption:(id)sender
{
    UIView *senderView = (UIButton *)sender;
    
    NSMutableArray *keys = [[PharmaDAO sharedDAO] getAllBrands];
    //[keys addObjectsFromArray:[SFAUtils getYTDMonths]];
    
    if (!self.tableSelectorView) {
        self.tableSelectorView = [[ValueSelectTableVC alloc] initWithValues:keys andSender:self.legBrandlbl];
    } else {
        [self.tableSelectorView reloadTableValues:keys andSender:self.legBrandlbl];
    }
    self.tableSelectorView.delegate = self;
    if (!self.ytdPopoverController) {
        self.ytdPopoverController = [[UIPopoverController alloc] 
                                     initWithContentViewController:self.tableSelectorView];               
    }
    [self.ytdPopoverController presentPopoverFromRect:senderView.frame inView:senderView.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];    
        
}

- (void)valueSelected:(NSString *)value forSender:(NSObject *)sender
{
    UILabel *senderLbl = (UILabel *)sender;
    senderLbl.text = value;
    [self.ytdPopoverController dismissPopoverAnimated:YES];
}

@end
