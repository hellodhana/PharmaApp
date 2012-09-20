//
//  ValueSelectTableVC.h
//  PharmaApp
//
//  Created by dkaruppanan on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOValueSelect.h"

@protocol ValueSelectorProtocol

- (void)valueSelected:(DOValueSelect *)valueDO forSender:(NSObject *)sender;

@end

@interface ValueSelectTableVC : UITableViewController {
    NSMutableArray *_values;
    NSObject <ValueSelectorProtocol> *_delegate;
    NSObject *_sender;
}
@property (nonatomic, retain) NSMutableArray *values;
@property (nonatomic, retain) NSObject <ValueSelectorProtocol> *delegate;
@property (nonatomic, retain) NSObject *sender;

- (id)initWithValues:(NSMutableArray *)values andSender:(NSObject *)sender;
- (void)reloadTableValues:(NSMutableArray *)newValues andSender:(NSObject *)sender;

@end
