//
//  SocialPerformanceView.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialPerformanceView.h"
#import "PercentageProgressBar.h"
#import "HTMLBuilder.h"
#import "SocialPostTable.h"
#import "PharmaDAO.h"
#import "DAOPharma.h"
#import "DOBrand.h"
#import "SharedData.h"
#import "DOSocialPerf.h"

@interface SocialPerformanceView (){
 NSArray *socialPerfArray;
}

@end

@implementation SocialPerformanceView
@synthesize healthBar=_healthBar;
@synthesize reachBar=_reachBar;
@synthesize strengthBar=_strengthBar;
@synthesize overallBar=_overallBar;
@synthesize blogBar=_blogBar;
@synthesize facebookBar=_facebookBar;
@synthesize twitterBar=_twitterBar;
@synthesize youtubeBar=_youtubeBar;
@synthesize tredWebView=_tredWebView;
@synthesize cloudWebView=_cloudWebView;
@synthesize recentPostView=_recentPostView;
@synthesize activityIndicatorViewCloud=_activityIndicatorViewCloud;
@synthesize activityIndicatorViewTrend=_activityIndicatorViewTrend;


- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"SocialPerformanceView" owner:nil options:nil];
    if (objs && [objs count]) {
        SocialPerformanceView *myView = [objs objectAtIndex:0];      
        return myView;
    }
    
    return nil;
}

-(void) drawRect:(CGRect)rect
{

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
//gaurav
-(void)loaddata
{
    DOBrand *brandDO=[[SharedData sharedObj] doBrand];
    
   // NSNumber *brandID=[NSNumber numberWithInt:2];
    socialPerfArray=[[DAOPharma sharedDAO] getBrandSocialPerformance:brandDO.brandID];
    
   
    DOSocialPerf *socialPerf=[socialPerfArray objectAtIndex:0];
    
    
    PercentageProgressBar *health = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.healthBar.frame.size.width, self.healthBar.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.healthBar addSubview:health];
    [health setProgress:[socialPerf.senStrnth floatValue]/100];    
    
    PercentageProgressBar *str = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.strengthBar.frame.size.width, self.strengthBar.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.strengthBar addSubview:str];
    [str setProgress:[socialPerf.senStrnth floatValue]/100];    
    
    PercentageProgressBar *reach = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.reachBar.frame.size.width, self.reachBar.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.reachBar addSubview:reach];
    [reach setProgress:[socialPerf.senRech floatValue]/100];     
    
    //Various Sources
    PercentageProgressBar *overall = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.overallBar.frame.size.width, self.overallBar.frame.size.height) andProgressBarStyle:SentimentStyle];
    [self.overallBar addSubview:overall];
    float overallValue=([socialPerf.facebookPos floatValue]+[socialPerf.twitterPos floatValue]+[socialPerf.youtubePos floatValue]+[socialPerf.blogPos floatValue])/400;
    [overall setProgress:overallValue];     
    
    PercentageProgressBar *blog = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.blogBar.frame.size.width, self.blogBar.frame.size.height) andProgressBarStyle:SentimentStyle];
    [self.blogBar addSubview:blog];
    [blog setProgress:[socialPerf.blogPos floatValue]/100];  
    
    PercentageProgressBar *twitter = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.twitterBar.frame.size.width, self.twitterBar.frame.size.height) andProgressBarStyle:SentimentStyle];
    [self.twitterBar addSubview:twitter];
    [twitter setProgress:[socialPerf.twitterPos floatValue]/100];  
    
    PercentageProgressBar *facebook = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.facebookBar.frame.size.width, self.facebookBar.frame.size.height) andProgressBarStyle:SentimentStyle];
    [self.facebookBar addSubview:facebook];
    [facebook setProgress:[socialPerf.facebookPos floatValue]/100];     
    
    PercentageProgressBar *youtube = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.youtubeBar.frame.size.width, self.youtubeBar.frame.size.height) andProgressBarStyle:SentimentStyle];
    [self.youtubeBar addSubview:youtube];
    [youtube setProgress:[socialPerf.youtubePos floatValue]/100];     
    
    //Load Trend View
    [self.tredWebView loadHTMLString:[HTMLBuilder htmlForLineChat] baseURL:nil];
    
    NSString* path = [[NSBundle mainBundle] bundlePath];
    // NSLog(@"%@",path);    
    //Load Word Cloud
    [self.cloudWebView loadHTMLString:[HTMLBuilder htmlForWordCloud:brandDO.brandDesc rskflag:[socialPerf.rskflg intValue]] baseURL:[NSURL fileURLWithPath:path]];  
    
    
    //Load Recent Posts
    SocialPostTable *socialPostTable = [[SocialPostTable alloc] initWithSocialPosts:[[PharmaDAO sharedDAO] getSocialPostsForBrand:brandDO rskflag:[socialPerf.rskflg intValue]] frame:CGRectMake(0, 0, self.recentPostView.frame.size.width, self.recentPostView.frame.size.height)];   
    
    [self.recentPostView addSubview:socialPostTable];
    
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
@end
