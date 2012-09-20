//
//  AdoptionNWView.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdoptionNWView.h"
#import "HTMLBuilder.h"

@interface AdoptionNWView ()

@end

@implementation AdoptionNWView
@synthesize legendView=_legendView;
@synthesize webView=_webView;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"AdoptionNWView" owner:nil options:nil];
    if (objs && [objs count]) {
        AdoptionNWView *myView = [objs objectAtIndex:0];
        //myView.frame = frame;
//        myView.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 31, frame.size.width, frame.size.height - 75) ]; 
        myView.webView.delegate = myView;
        //[myView addSubview:myView.webView];        
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
    self.legendView.hidden=NO;
    NSString* path = [[NSBundle mainBundle] bundlePath];
    // NSLog(@"%@",path);
    [self.webView loadHTMLString:[HTMLBuilder htmlForForceDirected] baseURL:[NSURL fileURLWithPath:path]];  
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // NSLog(@"%@",@"Touched....");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // NSLog(@"%@",@"Navigating...");
    
    // NSLog(@"%@",[request.URL scheme]);
    // NSLog(@"%@",[request.URL host]);
    if ([[request.URL scheme] isEqual:@"myapp"]) {
        if ([[request.URL host] isEqual:@"nodeClicked"]) {
            return NO;
        }
    }
    return YES;
}

-(IBAction) mapClicked:(id)sender
{
    self.legendView.hidden=YES;
   // NSString* path = [[NSBundle mainBundle] bundlePath];
    // NSLog(@"%@",path);
//    [self.webView loadHTMLString:[HTMLBuilder htmlForForceDirectedMap] baseURL:[NSURL fileURLWithPath:path]];  
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"HCPMap" ofType:@"htm"]isDirectory:NO]]];       
}

-(IBAction) graphClicked:(id)sender
{
    [self loadGraph];
}


@end
