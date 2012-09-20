//
//  SFAGenericTableCell.m
//  SFA
//
//  Created by Federico Lagarmilla on 4/27/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import "SFAGenericTableCell.h"


@implementation SFAGenericTableCell

@synthesize delegate=_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadDataFromEntity:(id)entity 
{
    // This method must be implemented in the subclasses
}

- (void)loadDataFromEntity:(id)entity forRow:(int)row
{
    // This method must be implemented in the subclasses
}

// Sets the selection style to none
- (void)drawRect:(CGRect)rect
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [super drawRect:rect];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
