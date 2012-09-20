//
//  SFAReportsSidebarCell.h
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

#define REPORTS_SIDEBAR_CELL_HEIGHT		110.0

@interface SFAReportsSidebarCell : UITableViewCell {
	UIImageView *_reportImage;
	UILabel *_reportTitle;
	UIView *_selectedBorder;
}

@property (nonatomic, retain) UIImageView *reportImage;
@property (nonatomic, retain) UILabel *reportTitle;

- (void)selectedStyle;

@end
