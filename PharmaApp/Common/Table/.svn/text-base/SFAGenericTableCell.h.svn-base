//
//  SFAGenericTableCell.h
//  SFA
//
//  Created by Federico Lagarmilla on 4/27/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAGenericTableView.h"
#import "DORegion.h"

@protocol SFAGenericTableCellProtocol

-(void) regionSelected:(DORegion *)doRegion;

@end

@interface SFAGenericTableCell : UITableViewCell {
    NSObject<SFAGenericTableCellProtocol> *_delegate;
}
@property(nonatomic, retain) NSObject<SFAGenericTableCellProtocol> *delegate;
// Defines how the data from the entity will be loaded into the view
- (void)loadDataFromEntity:(id)entity;
- (void)loadDataFromEntity:(id)entity forRow:(int)row;

@end
