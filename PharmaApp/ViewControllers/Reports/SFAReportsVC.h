//
//  SFAReportsVC.h
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAPagesMasterFrameVC.h"
#import "SFAReportsMainVC.h"
#import "SFAReportsSidebarView.h"
#import "BrandDO.h"

@interface SFAReportsVC : SFAPagesMasterFrameVC <SFAReportsSidebarViewDelegate> {
	SFAReportsMainVC *_reportMainView;
	SFAReportsSidebarView *_sidebarView;
}

- (id)initWithBrand:(BrandDO *)brand;

@end
