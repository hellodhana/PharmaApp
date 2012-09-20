//
//  FinancePerfTable.m
//  PharmaApp
//
//  Created by Kaushik Hegde on 09/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FinancePerfTable.h"
#import "FinancePerfTitleView.h"

@implementation FinancePerfTable
@synthesize financialPerf=_financialPerf;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFinPerformance:(NSMutableArray *)finPerformance frame:(CGRect)frame andDelegate:(NSObject<SFAGenericTableDelegate> *)delegate;
{
    self.financialPerf = finPerformance;
    self = [super initWithFrame:frame];
    if (self) {
        FinancePerfTitleView *titleView = [[FinancePerfTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame) - 10, 20)];
        SFAGenericTableView *genericTable = [[SFAGenericTableView alloc] initWithItems:self.financialPerf titleView:titleView frame:CGRectMake(0, 0, CGRectGetWidth(frame) -20, CGRectGetHeight(frame)-35) withRowHeight:60 searchSortNeeded: NO];
        genericTable.cellIdentifier = @"FinancePerfTableCell";
        genericTable.genericDelegate = delegate;
        [self addSubview:genericTable];
         [genericTable.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;    
    
}



@end
