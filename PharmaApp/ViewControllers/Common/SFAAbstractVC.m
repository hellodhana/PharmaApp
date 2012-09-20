//
//  SFAAbstractVC.m
//  SFA
//
//  Created by Martin Heras on 3/29/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAAbstractVC.h"
#import "DashBoardVC.h"

@implementation SFAAbstractVC

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark -
#pragma mark Navigation methods

- (void)navGoBack
{
    NSUInteger count = [self.navigationController.viewControllers count];
    if (count > 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)navGoHome 
{
    NSUInteger count = [self.navigationController.viewControllers count];
    if (count > 2) {
        UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:vc animated:YES];
    }
}

- (void)navGoToLogin 
{
    if ([self.navigationController.viewControllers count]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)navOpenVC:(SFAAbstractVC *)viewController 
{  
    
    [self.navigationController pushViewController:viewController animated:YES];
  
   
}


@end
