//
//  PayerAccessNodeCell.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExecutionIndexNodeCell.h"
#import "ExecutionIndexNode.h"
#import "PercentageProgressBar.h"

@implementation ExecutionIndexNodeCell
@synthesize financePerformanceLbl=_financePerformanceLbl;
@synthesize accessIndex=_accessIndex;
@synthesize avgDet=_avgDet;
@synthesize tgtRchd=_tgtRchd;
@synthesize sampleAlloc=_sampleAlloc;
@synthesize button=_button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) loadDataFromNode:(GenericTreeNode *)node
{
    ExecutionIndexNode *treeNode = (ExecutionIndexNode *)node;
    self.valueLabel.text = treeNode.value;
    self.button.tag=treeNode.index;
    //NSLog(@"Output as currency: %@", formattedOutput);
    
    PercentageProgressBar *accessBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.accessIndex.frame.size.width, self.accessIndex.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.accessIndex addSubview:accessBar];
    [accessBar setProgress:[treeNode.execPref.financePerforminPer floatValue]/100];  
    if([treeNode.execPref.financePerforminPer floatValue]>=100){
        [accessBar setProgress:1.0];        
    }

    
    self.financePerformanceLbl.text = [NSString stringWithFormat:@"$%.1fM",[treeNode.execPref.financePerformActual floatValue]/1000];       
    PercentageProgressBar *avgdetbar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.avgDet.frame.size.width, self.avgDet.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.avgDet addSubview:avgdetbar];
    [avgdetbar setProgressinText:[treeNode.execPref.frequencyReached floatValue]/100];     
    if([treeNode.execPref.frequencyReached floatValue]>=100){
        [avgdetbar setProgressinText:1.0];        
    }
    
    PercentageProgressBar *tgtRchdBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.tgtRchd.frame.size.width, self.tgtRchd.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.tgtRchd addSubview:tgtRchdBar];
    [tgtRchdBar setProgress:[treeNode.execPref.targetReached floatValue]/100]; 
   
    PercentageProgressBar *sampleAllocBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.sampleAlloc.frame.size.width, self.sampleAlloc.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.sampleAlloc addSubview:sampleAllocBar];
    [sampleAllocBar setProgress:[treeNode.execPref.sampleAllocationReached floatValue]/100];        
    if([treeNode.execPref.sampleAllocationReached floatValue]>=100){
        [sampleAllocBar setProgress:1.0];        
    }
    
      
}
@end
