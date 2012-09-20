//
//  SFAReportsSidebarView.m
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAReportsSidebarView.h"
#import "SFAReportsSidebarCell.h"
#import "SFAReportsService.h"

@implementation SFAReportsSidebarView

@synthesize reportsList = _reportsList;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		//[SFAUtils addMultiGradientToView:self beginColor:REPORTS_BACKGROUND_COLOR_FROM middleColor:REPORTS_BACKGROUND_COLOR_TO finalColor:REPORTS_BACKGROUND_COLOR_FROM];
		
		//MSReportsSidebarTableView *aSidebarView = [[MSReportsSidebarTableView alloc] initWithFrame:frame];
		UITableView *aSidebarView = [[UITableView alloc] initWithFrame:frame];
		[aSidebarView setBackgroundColor:[UIColor clearColor]];
		[aSidebarView setSeparatorColor:[UIColor clearColor]];
		[aSidebarView setDataSource:self];
		[aSidebarView setDelegate:self];
		[self addSubview:aSidebarView];
		
		if (self.reportsList == nil) {
			self.reportsList = [[NSMutableArray alloc] initWithArray:[[SFAReportsService sharedInstance] reports]];
		}		
    }
	
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.reportsList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SFAReportsSidebarCell *cell = (SFAReportsSidebarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SFAReportsSidebarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...	
	[[cell reportImage] setImage:[[self.reportsList objectAtIndex:indexPath.row] objectForKey:@"image"]];
	[[cell reportTitle] setText:[[self.reportsList objectAtIndex:indexPath.row] objectForKey:@"title"]];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.delegate loadReport:[self.reportsList objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return REPORTS_SIDEBAR_CELL_HEIGHT;
}

- (void)dealloc {

}


@end
