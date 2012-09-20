//
//  SocialPostTableCell.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialPostTableCell.h"
#import "SocialPostDO.h"

@interface SocialPostTableCell ()

@end

@implementation SocialPostTableCell
@synthesize userlbl=_userlbl;
@synthesize datelbl=_datelbl;
@synthesize contenttext=_contenttext;
 
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}

- (void)loadDataFromEntity:(id)entity forRow:(int)row
{    
    SocialPostDO *bo = (SocialPostDO *)entity;
    self.userlbl.text = [NSString stringWithFormat:@"%@(%@)", bo.user, bo.source];
    self.datelbl.text = bo.when;
    self.contenttext.text = bo.content;
    
}

@end
