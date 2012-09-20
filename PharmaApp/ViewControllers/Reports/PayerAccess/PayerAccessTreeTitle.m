//
//  PayerAccessTreeTitle.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PayerAccessTreeTitle.h"

@implementation PayerAccessTreeTitle

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"PayerAccessTreeTitle" owner:nil options:nil];
    if (objs && [objs count]) {
        PayerAccessTreeTitle *myView = [objs objectAtIndex:0];
        //myView.frame = frame;
        return myView;
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
