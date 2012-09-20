//
//  BrandPerfTable.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 13/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandPerfTable.h"
#import "BrandPerfTitleView.h"

@implementation BrandPerfTable
@synthesize brandPerf=_brandPerf;
@synthesize genericTable=_genericTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithBrandPerformance:(NSMutableArray *)brandPerformance frame:(CGRect)frame andDelegate:(NSObject<SFAGenericTableDelegate> *)delegate;
{
    self.brandPerf = brandPerformance;
    self = [super initWithFrame:frame];
    if (self) {
        BrandPerfTitleView *titleView = [[BrandPerfTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, 20)];
        self.genericTable = [[SFAGenericTableView alloc] initWithItems:self.brandPerf titleView:titleView frame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, CGRectGetHeight(frame)) withRowHeight:60 searchSortNeeded: NO];
        self.genericTable.cellIdentifier = @"BrandPerfTableCell";
        self.genericTable.genericDelegate = delegate;
        [self addSubview:self.genericTable];
        [self.genericTable.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];            
    }
    return self;        
}

@end
