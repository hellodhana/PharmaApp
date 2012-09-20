//
//  PayerAccessView.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayerAccessView : UIView
{
    IBOutlet UIView *_treeView;
     IBOutlet UIView *_View;
    IBOutlet UIView *_tableView;
    IBOutlet UIWebView *_webView;
    IBOutlet UIActivityIndicatorView *_activity;
}

@property(nonatomic, retain) UIView *treeView;
@property(nonatomic, retain) UIView *View;
@property(nonatomic, retain) UIView *tableView;
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) UIActivityIndicatorView *activity;

-(void)loadData;
@end
