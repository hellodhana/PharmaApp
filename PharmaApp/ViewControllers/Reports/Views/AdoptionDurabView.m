//
//  AdoptionDurabView.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdoptionDurabView.h"
#import "HTMLBuilder.h"
#import "DOBrandPerf.h"
#import "DAOPharma.h"
#import "SharedData.h"

@interface AdoptionDurabView ()

@end

@implementation AdoptionDurabView

@synthesize webView=_webView;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"AdoptionDurabView" owner:nil options:nil];
    if (objs && [objs count]) {
        AdoptionDurabView *myView = [objs objectAtIndex:0];
        //myView.frame = frame;
        myView.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 85) ]; 
        [myView addSubview:myView.webView];        
        return myView;
    }
    
    return nil;
}

-(void) drawRect:(CGRect)rect
{
    //    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 45) ];
    //    NSString* path = [[NSBundle mainBundle] bundlePath];
    //    // NSLog(@"%@",path);
    //    [self.webView loadHTMLString:[HTMLBuilder htmlForForceDirected] baseURL:[NSURL fileURLWithPath:path]];      
    //    [self addSubview:self.webView];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadGraph;
{
    NSString* path = [[NSBundle mainBundle] bundlePath];
    // NSLog(@"%@",path);
    
    DOTime *currTime = [[SharedData sharedObj] doTime];
    DOBrand *currBrand = [[SharedData sharedObj] doBrand];
    DORegion *currRegion = [[SharedData sharedObj] doRegion];    
    
    //Fetch Data for Current Region, Brand & Time ID.
    NSArray *overallPerf = [[DAOPharma sharedDAO] getBrandPerformancesForPeriod:[currTime timID] andBrand:[currBrand brandID]];
    
    NSMutableArray *minimalArray = nil;
    //Fetch Data for Current Region, Brand & Time ID.
    if(currRegion == nil || [currRegion.hier intValue] == 0)
    {
        minimalArray = [NSMutableArray arrayWithArray:[overallPerf filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 1)"]]];
    }
    else if([currRegion.hier intValue] == 1)
    {
        minimalArray = [NSMutableArray arrayWithArray:[overallPerf filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 2) AND (self.doRegion.region == %@)",currRegion.region]]]; 
    }  
    else if([currRegion.hier intValue] == 2)
    {
        minimalArray = [NSMutableArray arrayWithArray:[overallPerf filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.doRegion.hier == 3) AND (self.doRegion.state == %@)",currRegion.state]]]; 
    }     
    
    [self.webView loadHTMLString:[HTMLBuilder htmlForAdopDuraBubbleChart:[HTMLBuilder dataForAdopDuraBubbleChart:minimalArray]] baseURL:[NSURL fileURLWithPath:path]];  
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
@end
