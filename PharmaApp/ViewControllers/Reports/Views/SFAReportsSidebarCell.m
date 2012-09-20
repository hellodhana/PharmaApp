//
//  SFAReportsSidebarCell.m
//  SFA
//
//  Created by Mitza Oyaneder on 5/17/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAReportsSidebarCell.h"


@implementation SFAReportsSidebarCell

@synthesize reportImage = _reportImage;
@synthesize reportTitle = _reportTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		CGFloat margin = 10.0;
		CGFloat width = 180;
		
		_selectedBorder = [[UIView alloc] initWithFrame:CGRectMake(margin, margin, width-margin*2, REPORTS_SIDEBAR_CELL_HEIGHT-margin*3)];
		[_selectedBorder setBackgroundColor:[UIColor clearColor]];
		[[_selectedBorder layer] setCornerRadius:6.0];
		[self addSubview:_selectedBorder];
		
		//self.reportImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, width-margin*2, REPORTS_SIDEBAR_CELL_HEIGHT-margin*3)];
		self.reportImage = [[UIImageView alloc] initWithFrame:CGRectMake(margin*1.5, margin*1.5, width-margin*3, REPORTS_SIDEBAR_CELL_HEIGHT-margin*4)];
		[[self reportImage] setBackgroundColor:[UIColor whiteColor]];
		[[[self reportImage] layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
		[[[self reportImage] layer] setBorderWidth:1.0];
		[self addSubview:self.reportImage];
		
		self.reportTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, REPORTS_SIDEBAR_CELL_HEIGHT-20.0, width, 20.0)];
		[[self reportTitle] setBackgroundColor:[UIColor clearColor]];
		[[self reportTitle] setTextAlignment:UITextAlignmentCenter];
		[[self reportTitle] setFont:[SFAUtils applicationFontWithSize:12]];
		[self addSubview:self.reportTitle];
		
		//Clear background for 
		UIView *customBackgroundView = [[UIView alloc] init];
        customBackgroundView.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = customBackgroundView;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
	if (selected) {
		[self selectedStyle];
	}	
}


-  (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	
	// Configure the view for the selected state.
	if (highlighted) {
		[self selectedStyle];
	}	
}

- (void)selectedStyle {
	[[self reportImage] setBackgroundColor:[UIColor whiteColor]];
	[_selectedBorder setBackgroundColor:REPORTS_BORDER_COLOR];
}


- (void)dealloc {

}


@end
