//
//  SFAGenericTableSortTableVC.h
//  SFA
//
//  Created by Federico Lagarmilla on 5/3/11.
//  Copyright 2011 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAGenericTableProtocols.h"

@protocol SFASortTableSelectorProtocol

- (void)sortValueSelected:(NSString *)value;

@end


@interface SFAGenericTableSortTableVC : UITableViewController {
    NSMutableArray *_sortValues;
    NSObject <SFASortTableSelectorProtocol> *_delegate;
}
@property (nonatomic, retain) NSMutableArray *sortValues;
@property (nonatomic, retain) NSObject <SFASortTableSelectorProtocol> *delegate;

- (id)initWithValues:(NSMutableArray *)values;

- (void)reloadTableValues:(NSMutableArray *)newValues;

@end
