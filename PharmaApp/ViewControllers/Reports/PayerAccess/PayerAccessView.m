//
//  PayerAccessView.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PayerAccessView.h"
#import "PayerAccessNode.h"
#import "GenericTreeView.h"
#import "PayerAccessTreeTitle.h"
#import "DOPayerPerf.h"
#import "DAOPharma.h"
#import "HTMLBuilder.h"
#import "TopPayerTableTitle.h"
#import "SFAGenericTableView.h"

@interface PayerAccessView ()

-(PayerAccessNode *)constructPayerIndexTreeForBrand:(NSNumber *)brandID andTim:(NSNumber *)timID;
-(void) fillChildNode:(PayerAccessNode *)parentNode andPayerPerfArray:(NSArray *)payerPerfArray;

@end
@implementation PayerAccessView
@synthesize treeView=_treeView;
@synthesize tableView=_tableView;
@synthesize webView=_webView;
@synthesize View=_View;
@synthesize activity=_activity;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"PayerAccessView" owner:nil options:nil];
    if (objs && [objs count]) {
        PayerAccessView *myView = [objs objectAtIndex:0];
        return myView;
    }
    
    return nil;
}

-(void) drawRect:(CGRect)rect
{

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    //[super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadData;
{
//    //Root
//    DOPayerPerf *performance = [[DOPayerPerf alloc] init];
//    performance.regionDO.desc = @"National";
//    PayerAccessNode *rootNode = [[PayerAccessNode alloc] initWithPayerPref:performance];
//    
//    //East
//    performance = [[DOPayerPerf alloc] init];
//    performance.regionDO.desc = @"East";
//    PayerAccessNode *eastNode = [[PayerAccessNode alloc] initWithPayerPref:performance];
//    [rootNode addChild:eastNode];
//
//    //West
//    performance = [[DOPayerPerf alloc] init];
//    performance.regionDO.desc = @"West";
//    PayerAccessNode *westNode = [[PayerAccessNode alloc] initWithPayerPref:performance];
//    [rootNode addChild:westNode];   
//    
//    //East
//    performance = [[DOPayerPerf alloc] init];
//    performance.regionDO.desc = @"NewYork";
//    PayerAccessNode *nwNode = [[PayerAccessNode alloc] initWithPayerPref:performance];
//    [eastNode addChild:nwNode];
//    eastNode.inclusive = NO;
     
    
    //Load Tree
    self.View.layer.borderColor=[UIColor blackColor].CGColor;
    self.View.layer.borderWidth=1.0f;
    
    PayerAccessNode *rootNode = [self constructPayerIndexTreeForBrand:[NSNumber numberWithInt:1] andTim:[NSNumber numberWithInt:1]];
    
    PayerAccessTreeTitle *titleView = [[PayerAccessTreeTitle alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.layer.frame), 40)];
    GenericTreeView *treeView = [[GenericTreeView alloc] initWithRootNode:rootNode titleView:titleView frame:CGRectMake(0, 0, CGRectGetWidth(self.layer.frame) - 10,308)];
    [treeView.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    treeView.cellIdentifier = @"PayerAccessNodeCell";
    [self.treeView addSubview:treeView];
    
    NSArray *payerArray = ((PayerAccessNode *)[rootNode.children objectAtIndex:1]).payerPref.payers;
    
    //Load Table
    TopPayerTableTitle *tableTitle = [[TopPayerTableTitle alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 40)];
    
    NSMutableArray *payerArrayMutable = [NSMutableArray arrayWithArray:payerArray];
    SFAGenericTableView *genericTable = [[SFAGenericTableView alloc] initWithItems:payerArrayMutable titleView:tableTitle frame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame) - 10, CGRectGetHeight(self.tableView.frame)) withRowHeight:40 searchSortNeeded: NO];
    [genericTable.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];    
    genericTable.cellIdentifier = @"TopPayerTableCell";
    [self.tableView addSubview:genericTable];    

    //Load Pie Chart
    NSString* path = [[NSBundle mainBundle] bundlePath];
    // NSLog(@"%@",path);
    
    [self.activity startAnimating];
    [self.webView loadHTMLString:[HTMLBuilder htmlForPayerAccess:payerArray] baseURL:[NSURL fileURLWithPath:path]];   
    [self.activity stopAnimating];
}

-(PayerAccessNode *)constructPayerIndexTreeForBrand:(NSNumber *)brandID andTim:(NSNumber *)timID
{
    NSArray *payerPerfArray = [[DAOPharma sharedDAO] getPayerAccessForBrand:brandID forPeriod:timID];
    
    DOPayerPerf *rootPayerPerf = [[payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionDO.hier = 0"]] lastObject];   
    
    PayerAccessNode *rootAccessNode = [[PayerAccessNode alloc] initWithPayerPref:rootPayerPerf];
    
    [self fillChildNode:rootAccessNode andPayerPerfArray:payerPerfArray];
    
    return rootAccessNode;
    
}

-(void) fillChildNode:(PayerAccessNode *)parentNode andPayerPerfArray:(NSArray *)payerPerfArray;
{
    int parentHier = [parentNode.payerPref.regionDO.hier intValue];
        
    NSArray *childArray = nil;
    if (parentHier == 1) {
        childArray = [payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.regionDO.hier=%@) AND (self.regionDO.region = %@)",[NSNumber numberWithInt:parentHier + 1] ,parentNode.payerPref.regionDO.region]];
    } 
    else if(parentHier == 2) {
        childArray = [payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.regionDO.hier=%@) AND (self.regionDO.state = %@)",[NSNumber numberWithInt:parentHier + 1] ,parentNode.payerPref.regionDO.state]];
    } 
    else if(parentHier == 3)
    {
        return;
    }
    else {
        childArray = [payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionDO.hier=%@",[NSNumber numberWithInt:parentHier + 1]]];        
    }
       
    for (DOPayerPerf *childPayerPref in childArray) {
        PayerAccessNode *accessNode = [[PayerAccessNode alloc] initWithPayerPref:childPayerPref];
        accessNode.parent = parentNode;
        [parentNode addChild:accessNode];
        [self fillChildNode:accessNode andPayerPerfArray:payerPerfArray];
    }
}

@end
