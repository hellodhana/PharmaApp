//
//  BrandPerfTable.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DurabilityTable.h"
#import "DurabilityTitleView.h"

@implementation DurabilityTable


@synthesize durability=_durability;
@synthesize genericTable=_genericTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithDurabilityIndex:(NSMutableArray *)durabilityArray frame:(CGRect)frame andDelegate:(NSObject<SFAGenericTableDelegate> *)delegate;
{
    self.durability = durabilityArray;
    self = [super initWithFrame:frame];
    if (self) {
        DurabilityTitleView *titleView = [[DurabilityTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, 20)];
        self.genericTable = [[SFAGenericTableView alloc] initWithItems:self.durability titleView:titleView frame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame)) withRowHeight:60 searchSortNeeded: NO];
        self.genericTable.cellIdentifier = @"DurabilityTableCell";
        self.genericTable.genericDelegate = delegate;
        [self addSubview:self.genericTable];
        [self.genericTable.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];            
    }
    return self;        
}

@end
