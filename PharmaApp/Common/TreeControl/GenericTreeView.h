//
//  GenericTreeView.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericTreeNode.h"
#import "GenericTreeCell.h"

@interface GenericTreeView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    GenericTreeNode *_rootNode;
    UITableView *_table;
    UIView *_tableBackground;  
    NSString *_cellIdentifier;
    int i;
}

@property(nonatomic, retain) GenericTreeNode *rootNode;
@property(nonatomic, retain) UITableView *table;
@property(nonatomic, retain) UIView *tableBackground;   
@property(nonatomic, retain) NSString *cellIdentifier;

- (id)initWithRootNode:(GenericTreeNode *)rootNode titleView:(UIView *)titleView frame:(CGRect)tableFrame;

- (id)initWithRootNode:(GenericTreeNode *)rootNode NSString:(NSString *)title frame:(CGRect)tableFrame;
@end
