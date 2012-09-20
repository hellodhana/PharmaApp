//
//  PerformanceVC.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 15/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PerformanceVC.h"
#import "PerformanceMainVC.h"
#import "SFAReportsVC.h"

@interface PerformanceVC()
{
    PerformanceMainVC *_mainVC;
}

@property(nonatomic, retain) PerformanceMainVC *mainVC;
@end

@implementation PerformanceVC
@synthesize mainVC = _mainVC;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = SCREEN_TITLE_PERFORMANCE;
    }
    return self;
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    self.title = SCREEN_TITLE_PERFORMANCE;
    self.titleLabel.font= [UIFont fontWithName:@"futura" size:(30.0)];
    
    [super viewDidLoad];
    
    PerformanceMainVC *performanceVC = [[PerformanceMainVC alloc] init];
    performanceVC.delegate = self;
    [self addView:performanceVC.view atRow:0 atColumn:0];
    self.mainVC = performanceVC;
    [self.mainVC loadScreen];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //Set Brand in master Frame;    
    [super viewWillAppear:animated];
}

-(void) navigateUsingBrand:(BrandDO *)brand;
{
    SFAReportsVC *reportsVC = [[SFAReportsVC alloc] initWithBrand:brand];
    [self navOpenVC:reportsVC];      
}




@end
