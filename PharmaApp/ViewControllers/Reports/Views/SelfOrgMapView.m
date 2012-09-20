//
//  SocialOrgMapView.m
//  PharmaApp
//
//  Created by Gaurav Thakur on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelfOrgMapView.h"
#import "HTMLBuilder.h"

@implementation SelfOrgMapView

@synthesize webView=_webView;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"SelfOrgMapView" owner:nil options:nil];
    if (objs && [objs count]) {
        SelfOrgMapView *myView = [objs objectAtIndex:0];

        myView.webView.delegate = myView;
         
        return myView;
    }
    
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)loadGraph;
{
  //  NSString* path = [[NSBundle mainBundle] bundlePath];
    // NSLog(@"%@",path);
    //[self.webView loadHTMLString:[HTMLBuilder htmlForForceDirected] baseURL:[NSURL fileURLWithPath:path]];  
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"splom" ofType:@"html"]isDirectory:NO]]];  
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"loading :%@",[request URL].absoluteString);
    return YES;
}

@end
