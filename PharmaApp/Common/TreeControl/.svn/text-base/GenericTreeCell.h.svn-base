//
//  GenericTreeCell.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTreeNode.h"

@interface GenericTreeCell : UITableViewCell
{
    UILabel *valueLabel;
	UIImageView *arrowImage;
	int level;
	BOOL expanded;
}

@property (nonatomic, retain) UILabel *valueLabel;
@property (nonatomic, retain) UIImageView *arrowImage;
@property (nonatomic) int level;
@property (nonatomic) BOOL expanded;

-(void)loadTreeDataWithLevel:(int)level andExpanded:(BOOL)expanded;
-(void)loadDataFromNode:(GenericTreeNode *)node;

@end
