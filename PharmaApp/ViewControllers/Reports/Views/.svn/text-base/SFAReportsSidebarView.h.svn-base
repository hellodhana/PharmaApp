//
//  SFAReportsSidebarView.h
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFAReportsSidebarViewDelegate;


@interface SFAReportsSidebarView : UIView <UITableViewDataSource, UITableViewDelegate> {
	NSMutableArray *_reportsList;
}

@property (nonatomic, retain) NSMutableArray *reportsList;
@property (nonatomic, retain) id<SFAReportsSidebarViewDelegate> delegate;

@end

@protocol SFAReportsSidebarViewDelegate

- (void)loadReport:(NSMutableDictionary *)report;

@end

