//
//  AdoptionNWView.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdoptionNWView : UIView<UIWebViewDelegate>
{
    IBOutlet UIWebView *_webView;
    IBOutlet UIView *_legendView;
}

@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) UIView *legendView;

-(void)loadGraph;

-(IBAction) mapClicked:(id)sender;
-(IBAction) graphClicked:(id)sender;
@end
