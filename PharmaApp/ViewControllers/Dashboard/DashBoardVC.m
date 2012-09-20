//
//  DashBoardVC.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 08/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DashBoardVC.h"
#import "DashboardMainVC.h"
#import "PerformanceVC.h"

@implementation DashBoardVC


- (id)init
{
    self = [super init];
    if (self) {
        self.title = SCREEN_TITLE_DASHBOARD;
      
    }
    return self;
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    self.title = SCREEN_TITLE_DASHBOARD;
    self.titleLabel.font= [UIFont fontWithName:@"futura" size:(30.0)];
    
    // The Contacts view has not 360º menu
    /*UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPad_Contacts.png"]];
     img.frame = _contentView.frame;
     img.contentMode = UIViewContentModeScaleToFill;
     [self.view addSubview:img];
     [img release];*/
    
    [super viewDidLoad];
    
    DashboardMainVC *aDashBoardVC = [[DashboardMainVC alloc] init];
    aDashBoardVC.delegate = self;
    [self addView:aDashBoardVC.view atRow:0 atColumn:0];

}

-(void) navigateToPerformanceScreen;
{
    PerformanceVC *performanceVC = [[PerformanceVC alloc] init];
    [self navOpenVC:performanceVC];      
}

- (void)viewWillAppear:(BOOL)animated
{   
    
    [super viewWillAppear:animated];
}
@end