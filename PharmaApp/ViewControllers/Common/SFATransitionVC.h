//
//  SFATransitionVC.h
//  PharmaApp
//
//  Created by Kaushik Hegde on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFAAbstractVC.h"

@interface SFATransitionVC : SFAAbstractVC

// make a transition that looks like a modal view 
//  is expanding from a subview
- (void)expandView:(UIView *)sourceView 
toModalViewController:(UIViewController *)modalViewController;

// make a transition that looks like the current modal view 
//  is shrinking into a subview
- (void)dismissModalViewControllerToView:(UIView *)view;

@end
