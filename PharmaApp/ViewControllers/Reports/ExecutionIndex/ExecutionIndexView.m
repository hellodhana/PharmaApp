//
//  ExecutionIndexView.m
//  PharmaApp
//
//  Created by Deloitte-1 on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExecutionIndexView.h"
#import "ExecutionIndexNode.h"
#import "GenericTreeView.h"
#import "ExecutionIndexTitle.h"
#import "DOExecution.h"
#import "DAOPharma.h"
#import "HTMLBuilder.h"

@interface ExecutionIndexView ()

-(ExecutionIndexNode *)constructPayerIndexTreeForBrand:(NSNumber *)brandID andTim:(NSNumber *)timID;
-(void) fillChildNode:(ExecutionIndexNode *)parentNode andPayerPerfArray:(NSArray *)payerPerfArray;

@end
@implementation ExecutionIndexView
@synthesize treeView=_treeView;
@synthesize tableView=_tableView;
@synthesize webView=_webView;
@synthesize View=_View;
@synthesize popupView=_popupView;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ExecutionIndexView" owner:nil options:nil];
    if (objs && [objs count]) {
        ExecutionIndexView *myView = [objs objectAtIndex:0];
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
    
    ExecutionIndexNode *rootNode = [self constructPayerIndexTreeForBrand:[NSNumber numberWithInt:1] andTim:[NSNumber numberWithInt:1]];
    
    ExecutionIndexTitle *titleView = [[ExecutionIndexTitle alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.layer.frame), 40)];
    GenericTreeView *treeView = [[GenericTreeView alloc] initWithRootNode:rootNode titleView:titleView frame:CGRectMake(0, 0, CGRectGetWidth(self.layer.frame) - 10,CGRectGetHeight(self.layer.frame)-10)];
    [treeView.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    treeView.cellIdentifier = @"ExecutionIndexNodeCell";
    [self.treeView addSubview:treeView];  
}

-(ExecutionIndexNode *)constructPayerIndexTreeForBrand:(NSNumber *)brandID andTim:(NSNumber *)timID
{
    NSArray *payerPerfArray = [[DAOPharma sharedDAO] getExecutionForBrand:brandID forPeriod:timID];
    
    DOExecution *rootPayerPerf = [[payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionDO.hier = 0"]] lastObject];   
    
    ExecutionIndexNode *rootAccessNode = [[ExecutionIndexNode alloc] initWithPayerPref:rootPayerPerf];
    
    [self fillChildNode:rootAccessNode andPayerPerfArray:payerPerfArray];
    
    return rootAccessNode;
    
}

-(void) fillChildNode:(ExecutionIndexNode *)parentNode andPayerPerfArray:(NSArray *)payerPerfArray;
{
    int parentHier = [parentNode.execPref.regionDO.hier intValue];
    
    NSArray *childArray = nil;
    if (parentHier == 1) {
        childArray = [payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.regionDO.hier=%@) AND (self.regionDO.region = %@)",[NSNumber numberWithInt:parentHier + 1] ,parentNode.execPref.regionDO.region]];
    } 
    else if(parentHier == 2) {
        childArray = [payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(self.regionDO.hier=%@) AND (self.regionDO.state = %@)",[NSNumber numberWithInt:parentHier + 1] ,parentNode.execPref.regionDO.state]];
    } 
    else if(parentHier == 3)
    {
        return;
    }
    else {
        childArray = [payerPerfArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.regionDO.hier=%@",[NSNumber numberWithInt:parentHier + 1]]];        
    }
    
    for (DOExecution *childPayerPref in childArray) {
        ExecutionIndexNode *accessNode = [[ExecutionIndexNode alloc] initWithPayerPref:childPayerPref];
        accessNode.parent = parentNode;
        [parentNode addChild:accessNode];
        [self fillChildNode:accessNode andPayerPerfArray:payerPerfArray];
    }
}
-(void) popupButtonClicked{
 //   NSLog(@"Button Clicked in Main View");
}


@end
