//
//  TopPayerTableCell.m
//  PharmaApp
//
//  Created by dkaruppanan on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopPayerTableCell.h"
#import "DOPayer.h"

@implementation TopPayerTableCell
@synthesize payerName=_payerName;
@synthesize payerStatus=_payerStatus;
@synthesize statusImg=_statusImg;
@synthesize lc=_lc;

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
    DOPayer *bo = (DOPayer *)entity;
    
    self.payerName.text = bo.payerName;
    if([bo.status isEqualToString:@"T2"]){
        self.statusImg.image=[UIImage imageNamed:@"green-circle.png"];
    }
    else if([bo.status isEqualToString:@"T3"]){
        self.statusImg.image=[UIImage imageNamed:@"yellow-circle.png"];
    }
    else if([bo.status isEqualToString:@"NC"]){
        self.statusImg.image=[UIImage imageNamed:@"red_circle.png"];
    }
    else if([bo.status isEqualToString:@"Restriction"]){
        self.statusImg.image=[UIImage imageNamed:@"red_circle.png"];
        self.payerStatus.text=@"*";
    }
    self.lc.text = [NSString stringWithFormat:@"%.1fM",[bo.livesCovered floatValue]/1000000];
}

@end
