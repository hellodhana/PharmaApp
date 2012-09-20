//
//  PayerAccessNodeCell.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PayerAccessNodeCell.h"
#import "PayerAccessNode.h"
#import "PercentageProgressBar.h"

@implementation PayerAccessNodeCell
@synthesize t2Lbl=_t2Lbl;
@synthesize t3Lbl=_t3Lbl;
@synthesize ncLbl=_ncLbl;
@synthesize resLbl=_resLbl;
@synthesize accessIndex=_accessIndex;
@synthesize t2Image=_t2Image;
@synthesize t3Image=_t3Image;
@synthesize resImage=_resImage;
@synthesize ncImage=_ncImage;
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
    PayerAccessNode *treeNode = (PayerAccessNode *)node;
    self.valueLabel.text = treeNode.value;
    
    self.t2Lbl.text = [NSString stringWithFormat:@"%@%%",[treeNode.payerPref.t2 stringValue]];
    self.t3Lbl.text = [NSString stringWithFormat:@"%@%%",[treeNode.payerPref.t3 stringValue]];    
    self.ncLbl.text = [NSString stringWithFormat:@"%@%%",[treeNode.payerPref.nc stringValue]];    
    self.resLbl.text = [NSString stringWithFormat:@"%@%%",[treeNode.payerPref.rest stringValue]]; 
    
    //T2 Image
    if([treeNode.payerPref.t2 intValue] < 30)
    {
        self.t2Image.image =[UIImage imageNamed:@"red_circle.png"]; 
    }
    else if([treeNode.payerPref.t2 intValue] > 30 && [treeNode.payerPref.t2 intValue] < 50)
    {
        self.t2Image.image =[UIImage imageNamed:@"yellow-circle.png"];                
    }
    else
    {
        self.t2Image.image =[UIImage imageNamed:@"green-circle.png"];                
    }
    
    //T3 Image
    if([treeNode.payerPref.t3 intValue] < 30)
    {
        self.t3Image.image =[UIImage imageNamed:@"red_circle.png"]; 
    }
    else if([treeNode.payerPref.t3 intValue] > 30 && [treeNode.payerPref.t3 intValue] < 50)
    {
        self.t3Image.image =[UIImage imageNamed:@"yellow-circle.png"];                
    }
    else
    {
        self.t3Image.image =[UIImage imageNamed:@"green-circle.png"];                
    }    
    
    //Restriction Image
    if([treeNode.payerPref.rest intValue] < 30)
    {
        self.resImage.image =[UIImage imageNamed:@"red_circle.png"]; 
    }
    else if([treeNode.payerPref.rest intValue] > 30 && [treeNode.payerPref.rest intValue] < 50)
    {
        self.resImage.image =[UIImage imageNamed:@"yellow-circle.png"];                
    }
    else
    {
        self.resImage.image =[UIImage imageNamed:@"green-circle.png"];                
    }   
    
    //NC Image
    if([treeNode.payerPref.nc intValue] < 30)
    {
        self.ncImage.image =[UIImage imageNamed:@"red_circle.png"]; 
    }
    else if([treeNode.payerPref.nc intValue] > 30 && [treeNode.payerPref.nc intValue] < 50)
    {
        self.ncImage.image =[UIImage imageNamed:@"yellow-circle.png"];                
    }
    else
    {
        self.ncImage.image =[UIImage imageNamed:@"green-circle.png"];                
    }  
    
    float access=[treeNode.payerPref.accessAct floatValue]/[treeNode.payerPref.accessPLN floatValue];
    PercentageProgressBar *accessBar = [[PercentageProgressBar alloc] initWithFrame:CGRectMake(0, 0, self.accessIndex.frame.size.width, self.accessIndex.frame.size.height) andProgressBarStyle:ProgressStyle];
    [self.accessIndex addSubview:accessBar];
    [accessBar setProgress:access];        
    
}
@end
