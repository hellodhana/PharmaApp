//
//  SocialPerformanceView.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialPerformanceView : UIView

{
@private
    IBOutlet UIView *_healthBar;
    IBOutlet UIView *_strengthBar;
    IBOutlet UIView *_reachBar;   
    
    IBOutlet UIView *_overallBar;
    IBOutlet UIView *_blogBar;
    IBOutlet UIView *_facebookBar; 
    IBOutlet UIView *_twitterBar;
    IBOutlet UIView *_youtubeBar;
    
    IBOutlet UIWebView *_tredWebView;
    IBOutlet UIWebView *_cloudWebView;    
    
    IBOutlet UIView *_recentPostView;
    IBOutlet UIActivityIndicatorView *_activityIndicatorViewCloud;
    IBOutlet UIActivityIndicatorView *_activityIndicatorViewTrend;
}

@property(nonatomic, retain) UIView *healthBar;
@property(nonatomic, retain) UIView *strengthBar;
@property(nonatomic, retain) UIView *reachBar; 

@property(nonatomic, retain) UIView *overallBar;
@property(nonatomic, retain) UIView *blogBar;
@property(nonatomic, retain) UIView *facebookBar; 
@property(nonatomic, retain) UIView *twitterBar;
@property(nonatomic, retain) UIView *youtubeBar;

@property(nonatomic, retain) UIWebView *tredWebView;
@property(nonatomic, retain) UIWebView *cloudWebView;   

@property(nonatomic, retain) UIView *recentPostView;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicatorViewCloud;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicatorViewTrend;

-(void)loaddata;

@end
