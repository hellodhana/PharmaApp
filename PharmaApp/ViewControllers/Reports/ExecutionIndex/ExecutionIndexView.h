//
//  ExecutionIndexView.h
//  PharmaApp
//
//  Created by Deloitte-1 on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ExecutionIndexView : UIView
{
    IBOutlet UIView *_treeView;
    IBOutlet UIView *_View;
    IBOutlet UIView *_tableView;
    IBOutlet UIWebView *_webView;
    IBOutlet UIView *_popupView;
}

@property(nonatomic, retain) UIView *treeView;
@property(nonatomic, retain) UIView *popupView;
@property(nonatomic, retain) UIView *View;
@property(nonatomic, retain) UIView *tableView;
@property(nonatomic, retain) UIWebView *webView;

-(void)loadData;
-(void) popupButtonClicked;
@end
