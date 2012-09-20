//
//  SocialPostTable.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialPostTable.h"
#import "SocialPostTitleView.h"
#import "SFAGenericTableView.h"

@implementation SocialPostTable
@synthesize socialPosts=_socialPosts;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithSocialPosts:(NSMutableArray *)socialPosts frame:(CGRect)frame
{
    self.socialPosts = socialPosts;
    self = [super initWithFrame:frame];
    if (self) {
        SocialPostTitleView *titleView = [[SocialPostTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, 40)];
        SFAGenericTableView *genericTable = [[SFAGenericTableView alloc] initWithItems:self.socialPosts titleView:titleView frame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame)) withRowHeight:80 searchSortNeeded: NO];
        genericTable.cellIdentifier = @"SocialPostTableCell";
        genericTable.genericDelegate = nil;
        [genericTable.table setSeparatorStyle:UITableViewCellSeparatorStyleNone]; 
        [self addSubview:genericTable];
    }
    return self;    
}

@end
